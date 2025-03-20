import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/custom_app_buttom.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/margin_layout.dart';
import 'package:lms_0_3/app/module/auth/controller/auth_controller.dart';
import 'package:lms_0_3/utils/app_color.dart';
import 'package:lms_0_3/utils/app_style.dart';
import '../widget/sign_up_text_field_widget.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
   const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: AppStyle.large_text.copyWith(color: AppColor.normalTextColor),
        ),
      ),
      body: Padding(
        padding: marginLayout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Text(
              'Forgot Password?',
              style: AppStyle.large_text.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColor.normalTextColor,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Enter your email address and we will send you a link to reset your password.',
              style: AppStyle.normal_text_black
                  .copyWith(color: AppColor.hintColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            userEmailField(controller.emailController,
                borderColor: AppColor.disableColor),
            const SizedBox(height: 20),
            Obx(
              () => controller.isForgotPasswordLoading.isTrue
                  ? loadingIndicator()
                  : _buildButton(),
            ),
            _backButton(context)
          ],
        ),
      ),
    );
  }

  _backButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Back to Login',
        style: TextStyle(
          color: Colors.blueAccent,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildButton() {
    return CustomAppButton(
      text: "Send Reset Link",
      buttonColor: AppColor.primaryColor,
      onPressed: () {
        controller.forgotPassword(controller.emailController.text);
      },
      buttonRadius: 8,
    );
  }
}
