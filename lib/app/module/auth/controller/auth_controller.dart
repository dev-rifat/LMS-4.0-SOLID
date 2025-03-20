import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/global/view/widget/success_message.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/logger.dart';
import '../../../global/models/error_model.dart';
import '../../../global/view/widget/error_message.dart';
import '../repository/auth_repository.dart';
import '../models/sign_in_model_model.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final AuthRepository _authRepository;
  AuthController(this._authRepository);

  final isSignInLoading = false.obs;
  final isSignUpLoading = false.obs;
  final isForgotPasswordLoading = false.obs;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPassController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> logIn(String phoneNumber, String password) async {
    await _authRequest(
      isSignInLoading,
          () => _authRepository.login(phoneNumber: phoneNumber, password: password),
      "logIn",
    );
  }




  Future<void> forgotPassword(String email) async {
    isForgotPasswordLoading(true);
    final String url = "${Api.BASE_URL}${Api.forgotPassword}";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Accept': 'application/json'},
        body: {'email': email},
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSuccessMessage(message: data['message']);
        emailController.clear();

      } else {
        showErrorMessage(message: data['message']);
      }

    } catch (e) {
      showErrorMessage(message: "Something went wrong. Please try again.");
      print("Exception: $e");
    } finally {
      isForgotPasswordLoading(false);
    }
  }


  Future<void> signUp(String name, String email, String phoneNumber,
      String password, String confPassword) async {
    await _authRequest(
      isSignUpLoading,
          () => _authRepository.signUp(
          name: name,
          email: email,
          phoneNumber: phoneNumber,
          password: password,
          confPassword: confPassword),
      "signUp",
    );
  }

  Future<void> _authRequest(RxBool loadingFlag,
      Future<Response?> Function() apiCall, String methodName) async {
    try {
      loadingFlag(true);  // Start loading
      final response = await apiCall();

      if (response != null && response.statusCode==200) {
        if (methodName.contains("forgotPassword")) {
          showSuccessMessage(message: response.body["message"]);
          showSuccessMessage(message: "Check your inbox to view the email.");
          emailController.clear();
        } else {
          _onSuccess(response);
        }
      } else {
        _onError(response, methodName);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loadingFlag(false);  // Always stop loading, regardless of success or error
    }
  }

  void _onSuccess(Response response) {
    final signInResponse = SignInResponse.fromJson(response.body);
    GetStorage().write(AppString.ID_STORE, signInResponse.user?.id);
    GetStorage().write(AppString.ACCESS_TOKEN, signInResponse.token).then((_) {
      Get.toNamed(Routes.MAIN);
    });
  }

  void _onError(Response? response, String methodName) {
    if (response == null) {
      showErrorMessage(message: "Please check your internet connection");
    } else {
      if (methodName.contains("logIn") || methodName.contains("forgotPassword")) {
        final errorMessage = ErrorModel.fromJson(response.body).message ?? "Unknown error";
        showErrorMessage(message: errorMessage);
      }

      if (methodName.contains("signUp")) {
        final error =
            ErrorModel.fromJson(response.body).errorMessage ?? "Unknown error";
        showErrorMessage(message: error);
      }

      logErrorMessage(logName: methodName, response: response);
    }
  }



  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }
}
