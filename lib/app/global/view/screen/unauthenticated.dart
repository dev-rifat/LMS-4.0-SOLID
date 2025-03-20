import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../widget/custom_spacer.dart';
import '../widget/cutom_component/custom_app_buttom.dart';


class Unauthenticated extends StatelessWidget {
  const Unauthenticated({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Unauthenticated, please login!',
          style: AppStyle.normal_text_grey,
          textAlign: TextAlign.center, // Center the text if desired
        ),
        customSpacerHeight(height: 15),
        Center(
          child: SizedBox(
            width: 170,
            height: 40,
            child: CustomAppButton(
              onPressed: () => Get.offNamed(Routes.SIGN_IN),
              buttonColor: AppColor.primaryColor,
              text: "Login",
            ),
          ),
        )
      ],
    );

  }
}
