import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/chapter_details.dart';
import '../../../../../../../utils/api_endpoints.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../global/utils/app_container.dart';
import '../../../../../../global/view/widget/custom_network_image.dart';
import '../../../../../../global/view/widget/custom_spacer.dart';
import '../../../../../../global/view/widget/error_message.dart';
import '../../../../../../global/view/widget/warning_message.dart';
import '../../../../controller/chapter_details_controller.dart';
import '../videos/video_player_dev.dart';

class VideosWidget extends GetView<CourseDetailsController> {
  const VideosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<Videos>? videos = controller.chapterDetailsModel?.data?.videos??[];

    if (videos.isEmpty) {
      return _noVideosAvailable();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          Videos video = videos[index];
          final videoUrl = video.videoUrl ?? "";
          final hasPermission = video.status == "1" || index == 0;
          return GestureDetector(
            onTap: () => _handleVideoTap(context, videoUrl, video.title, hasPermission),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Column(
                children: [
                  _videoRow(video, hasPermission,index),
                  _expansionTile(index, videos, hasPermission),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _noVideosAvailable() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
      child: Center(
        child: Text(
          "Video not found!",
          style: AppStyle.normal_text_grey,
        ),
      ),
    );
  }

  void _handleVideoTap(BuildContext context, String videoUrl, String? title, bool hasPermission) {
    if (videoUrl.isNotEmpty && hasPermission) {
      print("url:: $videoUrl");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoPayerDev(
            videoUrl: Api.videoPublicKey + videoUrl,
            title: title ?? "No Title",
          ),
        ),
      );


    } else {
      showErrorMessage(message: "Video not available here!");
    }
  }

  Widget _videoRow(Videos video, bool hasPermission,int index) {
    return Container(
      decoration: ContainerDecorationHelper.containerDecoration().copyWith(color: AppColor.primaryColor.withOpacity(0.2)),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageLayout(
            video.thumbnail??"",
            hasPermission,

          ),
          customSpacerWidth(width: 4),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpacerHeight(height: 5),

                  Text(
                    video.title?.isNotEmpty == true ? video.title! : "No Title",
                    maxLines: 2,
                    style: AppStyle.normal_text_black.copyWith(
                      color: hasPermission
                          ? AppColor.primaryColor
                          : AppColor.hintColor,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _videoDurationBadge(video.duration.toString(), hasPermission),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoDurationBadge(String? duration, bool hasPermission) {
    return Container(
      decoration: ContainerDecorationHelper.containerDecoration().copyWith(color: hasPermission ? Colors.black : Colors.grey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          duration?.isNotEmpty == true ? duration! : "0.00",
          maxLines: 1,
          style: AppStyle.normal_text_black.copyWith(
            color: AppColor.cardColor,
            overflow: TextOverflow.ellipsis,
            fontSize: 10,
          ),
        ),
      ),
    );
  }

  Widget _expansionTile(int index, List<Videos> videos, bool hasPermission) {
    if (!hasPermission) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
          color: AppColor.hintColor.withOpacity(0.09),

          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)) ),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.zero,
        backgroundColor: AppColor.hintColor.withOpacity(0.09),
        title: Text(
          'View..',
          style: AppStyle.small_text.copyWith(color: AppColor.primaryColor),
        ),
        children: [
         _completedButton(index, videos),
        ],
      ),
    );
  }

  Widget _completedButton(int index, List<Videos> videos) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: GestureDetector(
        onTap: () {
          if (index + 1 < videos.length) {
            final nextData = videos[index + 1];
            controller.addVideoStatus(nextData.id.toString());
          } else {
            showWarningMessage(message: "No next video exists!");
          }
        },
        child: Container(
          width: double.infinity,
          height: 38,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
            child: Text(
              "Completed",
              style: AppStyle.normal_text.copyWith(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageLayout(String imgUrl, bool isPermission) {
    return SizedBox(
      height: 90,
      width: 100,
      child: Opacity(
        opacity: isPermission ? 0.9 : 0.3,
        child: CustomNetworkImage(
          imgUrl: imgUrl.isNotEmpty ? imgUrl : "assets/images/placeholder.png",
          isRectangleImg: true,
          isModule: true,
          borderRadius: 5,
        ),
      ),
    );
  }
}
