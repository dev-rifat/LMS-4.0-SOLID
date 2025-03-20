import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/margin_layout.dart';
import '../widget/edit_profile_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customInsideAppbar(title: AppString.text_edit_profile.tr),
      backgroundColor:AppColor.backgroundColor,
      body: Padding(
        padding: marginLayout.copyWith(left: 18, right: 18),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              TextFieldLayout(),
              
              customSpacerHeight(height: 200)
            ],
          ),
        ),
      ),
    );
  }

}

customInsideAppbar({String? title}) {
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
          color: AppColor.normalTextColor,
        )),
    centerTitle: true,
    backgroundColor: AppColor.backgroundColor,
    title: Text(
      title ?? AppString.text_edit_profile.tr,
      style: AppStyle.mid_large_text.copyWith(
        fontSize: Dimensions.fontSizeMid,
        color: AppColor.normalTextColor,
      ),
    ),
  );
}
