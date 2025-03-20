import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/auth/controller/auth_controller.dart';
import 'package:lms_0_3/app/module/auth/view/widget/sign_up_text_field_widget.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_alert_dialog.dart';



class TextFieldLayout extends GetView<AuthController> {
  const TextFieldLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: roundedRectangleBorder.copyWith(
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          side: const BorderSide(width: 1, color: AppColor.disableColor)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Column(
        children: [
          userEmailField(controller.emailController),

          divider(),
          userPasswordField(controller:controller. passwordController),
        ],
      ),
    );
  }
}
