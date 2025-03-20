import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLayout {
  static getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static _getScreenHeight() => Get.height;

  static _getScreenWidth() => Get.width;

  static double getHeight(double pixel) {
    double x = _getScreenHeight() / pixel;
    return _getScreenHeight() / x;
  }

  static double getWidth(double pixel) {
    double x = _getScreenWidth() / pixel;
    return _getScreenWidth() / x;
  }
}

class ResponsiveLayout {
  static double screenWidth = 0;
  static double screenHeight = 0;

  static double baseWidth = 375.0; // Base width of the design
  static double baseHeight = 812.0; // Base height of the design

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  static double scaleWidth(double value) {
    return (value / baseWidth) * screenWidth;
  }

  static double scaleHeight(double value) {
    return (value / baseHeight) * screenHeight;
  }

  static double scaleText(double value) {
    // Adjust text size based on screen width
    return scaleWidth(value);
  }
}