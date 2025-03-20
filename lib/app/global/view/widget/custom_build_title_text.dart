import 'package:flutter/cupertino.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';


Widget buildText(String text){
  return Text(
    text,
    style: AppStyle.title_text.copyWith(
      color: AppColor.normalTextColor,
      fontSize: Dimensions.fontSizeMid - 2,
      fontWeight: FontWeight.bold,
    ),
  );
}