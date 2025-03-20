import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/home/view/widget/search_widget.dart';
import 'package:lms_0_3/routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/images.dart';
import '../../controller/home_controller.dart';
import 'appbar_leading.dart';

SliverAppBar get sliverAppBar {
  return SliverAppBar(
    expandedHeight: 200,
    elevation: 12,
    bottom: _subAppbar(),
    pinned: true,
    leadingWidth: double.infinity,
    leading:   const AppBarInfoLeading(),

    backgroundColor: AppColor.primaryColor,
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AppImages.appbarLine,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0, left: 20, right: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SearchWidget(
                  onChanged: (value) {},
                  onTap: (){
                    Get.toNamed(Routes.SEARCH_SCREEN);
                    Get.find<HomeController>().getSearchList();
                  },
                  readOnly: true,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

_subAppbar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40),
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        width: double.maxFinite,
        padding: const EdgeInsets.only(top: 5, bottom: 0),
        child: const Center(
            child: Text(
          "",
          style: TextStyle(fontSize: 14),
        ))),
  );
}
