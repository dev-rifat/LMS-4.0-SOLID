import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../module/starting/controller/network_controller.dart';
import '../../../../module/starting/view/splash_screen.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_layout.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/dimensions.dart';



class NetworkErrorScreen extends StatelessWidget {
  const NetworkErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _contentTextLayout(),
          const SizedBox(height: 40,),
          _tryAgainBtn()
        ],
      ),
    );
  }

  _tryAgainBtn() {
    return Center(
      child: GestureDetector(
        onTap: () =>Get.find<SplashController>(). checkInitialConnection(),

        child: Container(
          height: AppLayout.getHeight(46),
          width: AppLayout.getHeight(200),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: AppColor.primaryColor),
          child: Center(
              child: Text(
                "Try Again",
                style: AppStyle.mid_large_text.copyWith(fontSize: Dimensions.fontSizeMid),
              )),
        ),
      ),
    );
  }

  _contentTextLayout() {
    return Center(
      child: Column(
        children: [
          Text(
            "Ooops!",
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.normalTextColor,
                fontSize: Dimensions.fontSizeExtraLarge + 5),
          ),
          Text(
            "No internet connection found.",
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.hintColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
          Text(
            "Check your connection",
            style: AppStyle.normal_text_grey.copyWith(
                color: AppColor.hintColor.withOpacity(0.8),
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeDefault + 1),
          ),
        ],
      ),
    );
  }

}
