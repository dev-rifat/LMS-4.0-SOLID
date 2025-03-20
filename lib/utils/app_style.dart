import 'package:flutter/material.dart';
import 'app_color.dart';
import 'app_layout.dart';
import 'dimensions.dart';

class AppStyle {
  AppStyle._();

  static TextStyle title_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.paddingExtraLarge),
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat");


  static TextStyle small_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeSmall),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  static TextStyle small_text_grey = TextStyle(
      fontSize: AppLayout.getWidth(12),
      color: Colors.grey,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  static TextStyle small_text_black = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeSmall),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  static TextStyle normal_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  static TextStyle normal_text_black = TextStyle(
      fontSize: Dimensions.fontSizeDefault,
      color: const Color(0xFF24235F),
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  static TextStyle normal_text_grey = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeDefault),
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontFamily: "Montserrat");

  static TextStyle large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeExtraDefault),
      color: AppColor.cardColor,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  static TextStyle large_text_black = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeExtraDefault),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  static TextStyle mid_large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeMid),
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");

  static TextStyle extra_large_text = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeLarge),
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  static TextStyle extra_large_text_black = TextStyle(
      fontSize: AppLayout.getWidth(Dimensions.fontSizeLarge),
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat");
  static BoxDecoration ContainerStyle = BoxDecoration(
    borderRadius: BorderRadius.circular(
      Dimensions.radiusMid,
    ),
  );
}