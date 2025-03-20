import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/auth/controller/auth_controller.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/cutom_component/custom_password_field.dart';
import '../../../../global/view/widget/cutom_component/cutom_input_field.dart';

userEmailField(controller, {Color? borderColor}) {
  return CustomInputField(
    hitText: AppString.text_enter_email_address.tr,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      Icons.email_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor:borderColor ?? Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_email_field_is_required;
      } else if (value.isEmpty || !RegExp(emailExp()).hasMatch(value)) {
        return AppString.please_insert_a_valid_email_address.tr;
      } else {
        return null;
      }
    },
  );
}
emailExp() {
  const pattern =
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
  return pattern;
}
userNameField(controller) {
  return CustomInputField(
    hitText: AppString.text_user_name.tr,
    controller: controller,
    isHideLabelText: true,
    prefixIcon: Icon(
      CupertinoIcons.person_alt_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_first_name_field_is_required;
      } else {
        return null;
      }
    },
  );
}

userPhoneNumberField(controller) {
  return CustomInputField(
    hitText: AppString.text_enter_phone_number.tr,
    controller: controller,
    errorBorderColor: Colors.transparent,
    isHideLabelText: true,

    prefixIcon: Icon(
      CupertinoIcons.phone_circle,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
    borderColor: Colors.transparent,
    textInputType: TextInputType.number,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_email_field_is_required;
      } else {
        return null;
      }
    },
  );
}

userPasswordField({hintText, TextEditingController? controller}) {
  return PasswordInputField(
    controller: controller ?? Get.find<AuthController>().passwordController,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: "Enter password",
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the_password_field_is_required;
      } else {
        return null;
      }
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

userConfirmPasswordField({hintText, TextEditingController? controller}) {
  return PasswordInputField(
    controller: controller ?? Get.find<AuthController>().confirmPassController,
    borderColor: Colors.transparent,
    hintStyle: AppStyle.normal_text_black.copyWith(
      color: AppColor.hintColor,
      fontSize: Dimensions.fontSizeDefault + 1,
    ),
    hitText: "Enter confirm password",
    validator: (value) {
      if (value!.isEmpty) {
        return AppString.the__confirm_password_field_is_required;
      } else {
        return null;
      }
    },
    prefixIcon: Icon(
      Icons.lock_open_outlined,
      color: AppColor.hintColor.withOpacity(0.6),
    ),
  );
}

Divider divider() {
  return const Divider(
    color: AppColor.disableColor,
  );
}
