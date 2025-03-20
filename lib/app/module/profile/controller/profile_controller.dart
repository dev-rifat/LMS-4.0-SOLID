import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/logger.dart';
import '../../../global/view/widget/error_message.dart';
import '../../../global/view/widget/success_message.dart';
import '../model/change_pas_model.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';

class ProfileController extends GetxController with StateMixin {
  final ProfileRepository _profileRepository;
  ProfileController(this._profileRepository);

  Rx<ProfileModel?> profileModel = ProfileModel().obs;
  final isMyPostLoading = false.obs;
  final isImgUploadLoading = false.obs;
  final isChangePassLoading = false.obs;
  final isUpdateProfileLoading = false.obs;
  final isChangeProfileLoading = false.obs;

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  TextEditingController editFirstNameController = TextEditingController();
  TextEditingController editLastNameController = TextEditingController();
  TextEditingController editPhoneController = TextEditingController();
  TextEditingController editBioController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future getProfile() async {
    try{
      change(null, status: RxStatus.loading());
      profileModel.value = await _profileRepository.getProfile();
      change(null, status: RxStatus.success());
    }catch(e){
      log("getProfile : $e");
    }
  }

  Future<void> changeImageImage({required XFile image}) async {
    try {
      isImgUploadLoading(true);
      await _profileRepository.changeProfileImage(image: image).then((value) {
        showSuccessMessage(
            message: AppString.text_file_upload_update_successfully.tr);
        getProfile();
      });
      isImgUploadLoading(false);
    } catch (e) {
      log("changeImageImage $e");
      isImgUploadLoading(false);
    }
  }

  Future<void> changePassword(
      String currentPassword, String newPassword, String confirmPass) async {
    isChangePassLoading(true);
    Response? response = await _profileRepository.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPass: confirmPass);
    if (response?.statusCode != null && response?.statusCode == 200) {
      logSuccessMessage(logName: "changePassword", response: response);
      await _clearUserDataAndNavigate();
    } else {
      logErrorMessage(logName: "changePassword", response: response);
      handleErrorResponse(response?.body);
    }
    isChangePassLoading(false);
  }

  Future<void> updatedProfile(
      String name, String email, String phoneNumber) async {
    isUpdateProfileLoading(true);
    Response? response = await _profileRepository.updatedProfile(
        name: name, email: email, phoneNumber: phoneNumber);
    if (response != null && response.statusCode==200) {
      logSuccessMessage(logName: "updatedProfile", response: response);
      showSuccessMessage(message: response.body["message"]);
      getProfile();
      Get.back(canPop: false);
    } else {
      logErrorMessage(logName: "updatedProfile", response: response);
      handleErrorResponse(response?.body);
    }
    isUpdateProfileLoading(false);
  }

  @override
  void onInit() {
    if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
      getProfile();
    }
    super.onInit();
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPasswordController.dispose();
    passwordController.dispose();
    confirmPassController.dispose();
    editFirstNameController.dispose();
    editLastNameController.dispose();
    editPhoneController.dispose();
    emailController.dispose();
    editBioController.dispose();
    super.dispose();
  }
}

Future<void> _clearUserDataAndNavigate() async {
  ProfileController controller = Get.find<ProfileController>();
  final keysToRemove = [
    AppString.ACCESS_TOKEN,
    AppString.STORE_ADDRESS,
    AppString.USER_EMAIL,
    AppString.USER_PASSWORD,
    AppString.ID_STORE,
  ];

  for (var key in keysToRemove) {
    GetStorage().remove(key);
  }

  controller.currentPassword.clear();
  controller.newPasswordController.clear();
  controller.passwordController.clear();
  Get.offNamed(Routes.SIGN_IN);
}

// Error handling function
void handleErrorResponse(Map<String, dynamic> response) {
  final errorModel = ChangePasswordModel.fromJson(response);

  // Check if there is a general message to display
  if (errorModel.message != null && errorModel.message!.isNotEmpty) {
    showErrorMessage(message: errorModel.message!); // Show the general message
    return;
  }

  // Show 'new_password' errors if available
  final newPasswordErrors = errorModel.getErrorMessages('new_password');
  if (newPasswordErrors != null && newPasswordErrors.isNotEmpty) {
    for (var error in newPasswordErrors) {
      showErrorMessage(
          message: error); // Show each error message for 'new_password'
    }
    return;
  }

  // Otherwise, show 'old_password' errors if available
  final oldPasswordErrors = errorModel.getErrorMessages('old_password');
  if (oldPasswordErrors != null && oldPasswordErrors.isNotEmpty) {
    for (var error in oldPasswordErrors) {
      showErrorMessage(
          message: error); // Show each error message for 'old_password'
    }
    return;
  }

  // If neither message nor specific errors are found, handle default case
  showErrorMessage(message: 'An unknown error occurred');
}
