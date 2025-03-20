import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/chapter_details_controller.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../global/view/widget/custom_spacer.dart';
import '../../../models/chapter_details.dart';

class Summary extends GetView<CourseDetailsController> {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(screenWidth),
          _buildVideoList(screenWidth),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Get.back(canPop: false),
      child: Container(
        height: 80,
        width: double.infinity,
        color: AppColor.hintColor,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios, color: Colors.white),
            const SizedBox(width: 4),
            Text(
              "Back",
              style: AppStyle.small_text_grey.copyWith(
                color: AppColor.cardColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.04,
            bottom: 12,
            top: 50,
          ),
          child: Row(
            children: [
              IconButton(
                  padding:    EdgeInsets.zero ,
                  onPressed: ()=>Get.back(canPop: false), icon: Icon(Icons.arrow_back)),

              Text(
                "Summary's",
                style: AppStyle.mid_large_text.copyWith(
                  color: AppColor.normalTextColor,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade200, thickness: 2),
      ],
    );
  }

  Widget _buildVideoList(double screenWidth) {
    final videos =controller.chapterDetailsModel?.data?.videos ?? [];

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: 18,
        ),
        child: videos.isEmpty
            ? Center(
                child: Text(
                  "No Summary Found!",
                  style: AppStyle.normal_text_grey.copyWith(
                    color: AppColor.hintColor,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: videos.length,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final video = videos[index];
                  final hasPermission = video.status == "1" || index == 0;
                  return _buildVideoListItem(
                    video: video,
                    screenWidth: screenWidth,
                    hasPermission: hasPermission,
                  );
                },
              ),
      ),
    );
  }

  Widget _buildVideoListItem({
    required Videos video,
    required double screenWidth,
    required bool hasPermission,
  }) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColor.cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.normal_text_grey.copyWith(
                          color: AppColor.normalTextColor,
                        ),
                      ),
                      customSpacerHeight(height: 5),
                      if (controller.chapterDetailsModel?.data?.createdAt
                              ?.isNotEmpty ??
                          false)
                        _buildDateInfo(
                          label: "Created At:",
                          dateTime:
                              controller.chapterDetailsModel?.data?.createdAt ??
                                  "",
                          color: AppColor.hintColor,
                        ),
                      if (controller.chapterDetailsModel?.data?.updatedAt
                              ?.isNotEmpty ??
                          false)
                        _buildDateInfo(
                          label: "Updated At:",
                          dateTime:
                              controller.chapterDetailsModel!.data!.updatedAt!,
                          color: AppColor.pendingTextColor,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 18,
          child: CircleAvatar(
            radius: 14,
            backgroundColor:
                hasPermission ? AppColor.primaryColor : Colors.grey,
            child: Icon(
              hasPermission ? Icons.done : Icons.question_mark_rounded,
              color: AppColor.cardColor,
              size: 20,
            ),
          ),
        ),
        _buildVerticalDivider(),
      ],
    );
  }

  Widget _buildDateInfo({
    required String label,
    required String dateTime,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          Text(
            label,
            style: AppStyle.small_text_grey.copyWith(color: color),
          ),
          customSpacerWidth(width: 5),
          Icon(
            Icons.access_time,
            color: color.withOpacity(0.5),
            size: 15,
          ),
          customSpacerWidth(width: 5),
          Text(
            formatDate(dateTime),
            style: AppStyle.small_text_grey.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Positioned(
      left: 13,
      top: 45,
      child: Container(
        height: 146,
        width: 1,
        color: AppColor.normalTextColor.withOpacity(0.2),
      ),
    );
  }
}

String formatDate(String? timestamp) {
  if (timestamp == null || timestamp.isEmpty) return "Invalid Date";
  try {
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('dd MMM yy').format(dateTime);
  } catch (_) {
    return "Invalid Date";
  }
}
