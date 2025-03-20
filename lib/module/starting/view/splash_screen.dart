import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/global/view/screen/netwotk_error_screen.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildLogoLayout(constraints);
        },
      ),
    );
  }

  Widget _buildLogoLayout(BoxConstraints constraints) {
    final logoHeight = constraints.maxWidth * 0.3;
    final logoWidth = constraints.maxWidth * 0.4;
    final iconSize = constraints.maxWidth * 0.1;
    final fontSize = constraints.maxWidth * 0.06;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splashPng),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          _buildLogoCard(logoHeight, logoWidth, iconSize, fontSize),
          const Spacer(),
          _buildVersionText(),
        ],
      ),
    );
  }

  Widget _buildLogoCard(double height, double width, double iconSize, double fontSize) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.book_circle,
            size: iconSize,
            color: Colors.black,
          ),
          Text(
            "Rise",
            style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Text(
        AppString.appVersion,
        style: AppStyle.small_text_black,
      ),
    );
  }
}

