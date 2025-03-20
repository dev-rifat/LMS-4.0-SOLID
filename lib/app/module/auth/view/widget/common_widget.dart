import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lms_0_3/app/module/auth/controller/auth_controller.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/custom_app_buttom.dart';

Widget guestButtonLayout() {
  return CustomAppButton(
      text: "",
      widget: Text(
        "Guest",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
      onPressed: () => Get.toNamed(Routes.MAIN),
      btnBorderColor: AppColor.primaryColor,
      buttonRadius: Dimensions.radiusDefault,
      buttonColor: AppColor.cardColor);
}

titleTextLayout({context, titleText, subTitleText, subText}) {
  return Column(
    children: [
      Text(titleText,
          textAlign: TextAlign.center,
          style: AppStyle.title_text.copyWith(
              color: AppColor.normalTextColor,
              fontSize: ResponsiveLayout.scaleText(
                  Dimensions.fontSizeDoubleLarge - 4))),
      customSpacerHeight(height: 6),
      _subTextLayout(context, subTitleText, subText)
    ],
  );
}

_subTextLayout(context, text, subtext) {
  return Column(
    children: [
      Text(
        text,
        style: AppStyle.normal_text
            .copyWith(color: Theme.of(context).disabledColor.withOpacity(0.5)),
      ),
      Text(
        subtext,
        style: AppStyle.normal_text.copyWith(
            color: Theme.of(context).disabledColor.withOpacity(0.5),
            fontSize: ResponsiveLayout.scaleText(Dimensions.fontSizeDefault)),
      ),
    ],
  );
}

createUserAccount({context, firstText, endText, onAction}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: firstText,
              style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                  fontSize: Dimensions.radiusMid)),
          TextSpan(
            text: endText,
            style: AppStyle.mid_large_text.copyWith(
                color: Colors.blue,
                fontSize: Dimensions.radiusMid - 2,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()..onTap = onAction,
          ),
        ],
      ),
    ),
  );
}

clearAuthTextField() {
  AuthController controller = Get.find<AuthController>();
  controller.passwordController.clear();
  controller.phoneController.clear();
  controller.confirmPassController.clear();
  controller.userNameController.clear();
  controller.emailController.clear();
}
