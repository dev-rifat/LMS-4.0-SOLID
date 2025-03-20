import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';

 Widget buildCustomTitleText({String? text,isHoldSeeMoreText=false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text ?? "",
        style: AppStyle.normal_text_grey.copyWith(
            color: AppColor.normalTextColor, fontSize: Dimensions.fontSizeMid),
      ),
      if(isHoldSeeMoreText==false)
      GestureDetector(
        onTap:(){
          Get.toNamed(Routes.SEARCH_SCREEN);
        //  Get.find<HomeController>().getSearchList(query: "");

   },

        child: Text(
          "See more",
          style: AppStyle.normal_text_grey
              .copyWith(
              color: AppColor.primaryColor,

              overflow: TextOverflow.ellipsis),
        ),
      ),
    ],
  );
}
