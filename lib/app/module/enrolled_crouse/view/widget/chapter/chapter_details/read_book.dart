import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../controller/chapter_details_controller.dart';
import '../../../../controller/my_crouse_controller.dart';


class ReadBook extends GetView<CourseDetailsController> {
  const ReadBook({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14),
      child: controller.chapterDetailsModel?.data?.module?.description==null?Center(child: Text("No overview found!",style: AppStyle.normal_text_grey,)):


      SelectableText(
        controller.chapterDetailsModel?.data?.module?.description ?? "",
        style: AppStyle.small_text_black.copyWith(color:AppColor.normalTextColor,fontSize: Dimensions.fontSizeDefault),
      ),
    );
  }
}
