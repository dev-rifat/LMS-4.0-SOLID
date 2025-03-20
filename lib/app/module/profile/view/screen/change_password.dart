import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/profile/controller/profile_controller.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/custom_app_buttom.dart';
import '../../../../global/view/widget/cutom_component/cutom_input_field.dart';
import '../../../../global/view/widget/cutom_component/margin_layout.dart';
import '../screen/edit_profile.dart';

class ChangePassword extends GetView<ProfileController> {
  ChangePassword({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customInsideAppbar(title: "Change password"),
      backgroundColor: AppColor.backgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: marginLayout.copyWith(left: 16, right: 16, bottom: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpacerHeight(height: 14),
                _currentPassword(),
                customSpacerHeight(height: 14),
                _newPassword(),
                customSpacerHeight(height: 14),
                _confirmPassword(),
                customSpacerHeight(height: 50),
                Obx(() => _buttonLayout()),
                customSpacerHeight(height: 200)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _currentPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Current password",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        customSpacerHeight(height: 12),
        CustomInputField(
          controller:controller. currentPassword,
          hitText: "Current password",
          errorBorderColor: Colors.red,
          hintStyle: AppStyle.normal_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
          borderColor: AppColor.hintColor,
          validator: (value) {
            if (value!.isEmpty) {
              return "The password field is required!";
            } else if (value.length < 6) {
              return "Not valid password";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  _newPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New password",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        customSpacerHeight(height: 12),
        CustomInputField(
          controller: controller.newPasswordController,
          errorBorderColor: Colors.red,
          hintStyle: AppStyle.normal_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
          borderColor: AppColor.hintColor,
          hitText: "New password",
          validator: (value) {
            if (value!.isEmpty) {
              return "The password field is required!";
            } else if (value.length < 8) {
              return "The password field must be at least 8 characters.";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  _confirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm password",
          style: AppStyle.mid_large_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 2),
        ),
        customSpacerHeight(height: 12),
        CustomInputField(
          controller:controller. confirmPassController,
          errorBorderColor: Colors.red,
          hintStyle: AppStyle.normal_text_black.copyWith(
            color: AppColor.hintColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
          borderColor: AppColor.hintColor,
          hitText: "Confirm password",
          validator: (value) {
            if (value!.isEmpty) {
              return "The password field is required!";
            } else if (value.length < 8) {
              return "The password field must be at least 8 characters.";
            } else if (controller.newPasswordController.text !=
                controller.confirmPassController.text) {
              return "Password does not match. Please re-type again";
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }

  _buttonLayout() {
    if (Get.find<ProfileController>().isChangePassLoading.isTrue) {
      return const Center(child: CircularProgressIndicator(color: AppColor.primaryColor));

    } else {
      return Row(
            children: [
              Expanded(
                child: CustomAppButton(
                  buttonColor: AppColor.cardColor,
                  btnBorderColor: AppColor.primaryColor,
                  buttonTextColor: AppColor.primaryColor,
                  text: "Cancel",
                  buttonRadius: 8,
                  onPressed: () => Get.back(),
                ),
              ),
              customSpacerWidth(width: 12),
              Expanded(
                child: CustomAppButton(
                  buttonColor: AppColor.primaryColor,
                  text: "Save",
                  buttonRadius: 8,
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      Get.find<ProfileController>().changePassword( controller.currentPassword.text,controller.newPasswordController.text,controller.confirmPassController.text);

                    }
                  },
                ),
              ),
            ],
          );
    }
  }
}
