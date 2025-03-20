import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/chapter_details_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/view/screen/chapter/summury.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/view/widget/custom_onloading.dart';
import '../../../../../global/view/widget/custon_btn_sheet.dart';
import '../../../controller/tabbar_controller.dart';
import '../../../enrolled_crouse_bindings/courseDetailsBindings.dart';
import '../../widget/chapter/chapter_details/document.dart';
import '../../widget/chapter/chapter_details/read_book.dart';
import '../../widget/chapter/chapter_details/videos.dart';


class ChapterDetails extends GetView<CourseDetailsController> {
  const ChapterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CourseDetailsBindings().dependencies();
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Chapter details",
            style:
                AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
          ),
          actions: [
            _loadingWhenChangeStatus(),
            IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showCustomDrawer(context: context, child: Summary());
                  });
                },
                icon: const Icon(Icons.menu))
          ],
          bottom: TabBar(
            controller: Get.find<TabControllerX>().tabController, // Connect TabController
            onTap: (index) {
              Get.find<TabControllerX>().tabController.animateTo(index); // Update TabBar
            },
            tabs: [_tab("Overview"), _tab("Videos"), _tab("Download")],
          ),
        ),
        body: controller.obx((state)=>TabBarView(
          controller:  Get.find<TabControllerX>().tabController, // Connect TabController
          children: const [
            ReadBook(),
            VideosWidget(),
            DownloadFile(),
          ],
        ),onLoading: loadingIndicator()));
  }

  _tab(String text) {
    return Tab(
      child: Text(
        text,
        style: AppStyle.small_text_black.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: Dimensions.fontSizeDefault - 1),
      ),
    );
  }

  _loadingWhenChangeStatus() {
    return Obx(() => controller.isLeadingVideoStatus.isTrue
        ?  Padding(
            padding: EdgeInsets.only(right: 20.0),
            child:loadingIndicator(),
          )
        : Container());
  }


}
