import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';
import '../../../global/view/widget/custom_alert_dialog.dart';
import '../../../global/view/widget/custom_dialog_layout.dart';
import '../../../global/view/widget/custom_network_image.dart';
import '../../../global/view/widget/custom_spacer.dart';
import '../../../global/view/widget/cutom_component/margin_layout.dart';
import '../../enrolled_crouse/view/screen/certificate_list/certificate_list_screen.dart';
import '../../home/controller/home_controller.dart';
import '../../profile/controller/pick_img_controller.dart';
import '../../profile/controller/profile_controller.dart';


class DrawerMenuScreen extends StatefulWidget {
  const DrawerMenuScreen({super.key});

  @override
  State<DrawerMenuScreen> createState() => _DrawerMenuScreenState();
}

class _DrawerMenuScreenState extends State<DrawerMenuScreen> {
 final PickedFileFormStorage storageForUpload = PickedFileFormStorage();

  @override
  Widget build(BuildContext context) {
    final accessToken = GetStorage().read<String?>(AppString.ACCESS_TOKEN);

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Padding(
        padding: marginLayout.copyWith(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            _buildProfileInformation(),
            if(accessToken!=null)...[
              customSpacerHeight(height: 24),
              _buildMenuItems(accessToken),
              customSpacerHeight(height: 20),
            ],
            _logout(accessToken),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInformation() {
   final ProfileController controller = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Wrapping only the part that depends on observables inside Obx
        Obx(() {
          final imageUrl = controller.profileModel.value?.data?.image;
          if (controller.isImgUploadLoading.isFalse) {
            return CustomNetworkImage(
              imgUrl: imageUrl ?? "",
              isProfileImg: true,
              height: 35,
            );
          } else {
            return const CircleAvatar(
              radius: 30,
              backgroundColor: AppColor.cardColor,
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          }
        }),

        GestureDetector(
          onTap: () {
            if (GetStorage().read<String?>(AppString.ACCESS_TOKEN) != null) {
              storageForUpload.pickImageForProfile(ImageSource.gallery);
            }
          },
          child: SizedBox(
            width: 80,
            child: Card(
              elevation: 0,
              color: AppColor.primaryOrange,
              shape: roundedRectangleBorder.copyWith(
                borderRadius: BorderRadius.circular(4),
              ),
              child: GetStorage().read<String?>(AppString.ACCESS_TOKEN) == null
                  ? const SizedBox.shrink()
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        // Wrapping only the text inside Obx
                        child: Obx(() {
                          if (controller.profileModel.value?.data?.image !=
                              null) {
                            return Text(
                              "Update",
                              style: AppStyle.normal_text_black.copyWith(
                                color: AppColor.cardColor,
                              ),
                            );
                          } else {
                            return Text(
                              "Add",
                              style: AppStyle.normal_text_black.copyWith(
                                color: AppColor.cardColor,
                              ),
                            );
                          }

                          return const Text("data");
                        }),
                      ),
                    ),
            ),
          ),
        ),
        customSpacerHeight(height: 4),
        // Wrapping only the part that depends on observables inside Obx
        Obx(() {
         final name = controller.profileModel.value?.data?.name ?? "Guest";
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppStyle.title_text.copyWith(
                  fontSize: Dimensions.fontSizeMid,
                  color: AppColor.cardColor,
                ),
              ),
              Text(
                controller.profileModel.value?.data?.email ?? "",
                style: AppStyle.title_text.copyWith(
                    fontSize: Dimensions.fontSizeDefault - 2,
                    color: Colors.black),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildMenuItems(String? accessToken) {
    ProfileController controller = Get.find<ProfileController>();
    return Column(
      children: [
        _buildWidget(
          text: "Wishlist",
          icon: Icons.favorite_border,
          onAction: () => Get.toNamed(Routes.FAVORITE),
        ),
        if (accessToken != null) ...[
          Divider(color: AppColor.cardColor.withOpacity(0.3)),
          _buildWidget(
            text: "Notifications",
            icon: CupertinoIcons.bell,
            onAction: () => Get.toNamed(Routes.NOTIFICATION_SCREEN),
          ),
          Divider(color: AppColor.cardColor.withOpacity(0.3)),
          _buildWidget(
              text: "Change password",
              icon: CupertinoIcons.lock,
              onAction: () {
                controller.  currentPassword.clear();
                controller.   newPasswordController.clear();
                controller.   confirmPassController.clear();
                Get.toNamed(Routes.CHNAGE_PASSWORD);
              }),
          Divider(color: AppColor.cardColor.withOpacity(0.3)),
          _buildWidget(
              text: "Edit profile",
              icon: Icons.image_outlined,
              onAction: () {
                controller.  editFirstNameController.clear();
                controller. editLastNameController.clear();
                controller.    emailController.clear();
                controller.  editPhoneController.clear();

                controller.  editFirstNameController.text =
                    controller.profileModel.value?.data?.name ?? "";
                controller.   emailController.text =
                    controller.profileModel.value?.data?.email ?? "";
                controller.    editPhoneController.text =
                    controller.profileModel.value?.data?.phoneNumber ?? "";

                Get.toNamed(Routes.EDIT_PROFILE_SCREEN);
              }),
          Divider(color: AppColor.cardColor.withOpacity(0.3)),
          _buildWidget(
              text: "Payment History",
              icon: Icons.monetization_on_outlined,
              onAction: () {
               Get.find<HomeController>().getPaymentHistoryList();
                Get.toNamed(Routes.PAYMENT_HISTORY_SCREEN);
              }),

          Divider(color: AppColor.cardColor.withOpacity(0.3)),
          _buildWidget(
              text: "Certificates",
              icon: CupertinoIcons.doc,
              onAction: () {
               Get.find<MyCourseController>().myCertificate();
                Get.to(()=>CertificationListScreen());
              }),
        ]
      ],
    );
  }

  Widget _buildWidget({
    required String text,
    required IconData icon,
    VoidCallback? onAction,
  }) {
    return GestureDetector(
      onTap: onAction ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.black),
            customSpacerWidth(width: 8),
            Text(
              text,
              style: AppStyle.normal_text_black.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: Dimensions.fontSizeMid - 2,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logout(accessToken) {
    return GestureDetector(
      onTap: accessToken == null
          ? () => Get.toNamed(Routes.SIGN_IN)
          : _logoutDialog,
      child: SizedBox(
        width: 80,
        child: Card(
          elevation: 0,
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(4)),
          color: accessToken == null?AppColor.pendingTextColor: Colors.red,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                accessToken == null ? "Login" : "Logout",
                style: AppStyle.normal_text_black
                    .copyWith(color: AppColor.cardColor),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logoutDialog() {
    showCustomDialog(
      context: Get.context!,
      titleText: "Confirm logout",
      iconWidget: const Icon(
        Icons.logout,
        color: AppColor.errorColor,
        size: 34,
      ),
      titleTextStyle: AppStyle.normal_text_black.copyWith(
        color: AppColor.normalTextColor,
        fontSize: 22,
      ),
      descriptionTextStyle: AppStyle.normal_text_black.copyWith(
        color: AppColor.normalTextColor.withOpacity(0.8),
      ),
      btnWidget: _btnLayout(),
      descriptionText: "Are you sure you want to logout?",
    );
  }

  Widget _btnLayout() {
    final DrawerMenuController controller = Get.put(DrawerMenuController());

    return Obx(() => controller.isLoading.isFalse
        ? Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  AppString.text_cancel.tr,
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.normalTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: controller.logout,
                child: Text(
                  "Logout",
                  style: AppStyle.normal_text_black.copyWith(
                    color: AppColor.errorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          )
        : const CircularProgressIndicator(
            strokeWidth: 3,
            color: AppColor.primaryColor,
          ));
  }
}

class DrawerMenuController extends GetxController {
  var isLoading = false.obs;

  void logout() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 4));
    Get.offAllNamed(Routes.SIGN_IN);
    GetStorage().remove(AppString.ACCESS_TOKEN);
    // Get.find<ProfileController>().profileModel.value = ProfileModel();
    // Get.find<NotificationController>().notificationModel = NotificationModel();
    // Get.find<MyCourseController>().myCourseModel.value = MyCourseModel();
    // Get.find<WishlistController>().clearStorage();
    // passwordController.clear();
    isLoading(false);
  }
}
