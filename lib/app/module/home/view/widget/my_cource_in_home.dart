import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_0_3/utils/app_layout.dart';
import '../../../../../enum.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/screen/custom_card.dart';
import '../../../../global/view/widget/custom_alert_dialog.dart';
import '../../../../global/view/widget/custom_network_image.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/loading_effect/shimmer.dart';
import '../../../../global/view/widget/warning_message.dart';
import '../../../enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../enrolled_crouse/models/my_crouse_modle.dart';


class MyCourseInHome extends GetView<MyCourseController> {
  const MyCourseInHome({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoadingMyCourse.isTrue) {
      return ShimmerListEffect(
        itemHeight: 250,
        itemWidth: 200,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        itemCardHeight: 250,
        borderRadius: BorderRadius.circular(5),
        scrollDirection: Axis.horizontal,
      );
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3.3,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.myCourseModel.value.enrollments?.length ?? 0,
        itemBuilder: (context, index) {
          Enrollments? data = controller.myCourseModel.value.enrollments?[index];
          if (data?.course?.title == null && data?.course?.thumbnail == null) {
            return _invalidCourse(data ?? Enrollments());
          }

          return Stack(
            children: [
              GestureDetector(
                onTap: ()=> _handleCourseTap(data??Enrollments()),
                child: SizedBox(
                  width: AppLayout.getWidth(200),
                  child: Card(
                    elevation: 0,
                    shape: roundedRectangleBorder.copyWith(
                        borderRadius: BorderRadius.circular(4)),
                    color: AppColor.cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: 200,
                          height: 150,
                          child: CustomNetworkImage(
                            imgUrl: data?.course?.thumbnail ?? "",
                            isRectangleImg: true,
                            borderRadius: 8,
                          ),
                        ),
                        customSpacerWidth(width: 6),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.course?.title ?? "",
                                maxLines: 1,
                                style: AppStyle.normal_text_grey.copyWith(
                                  color: AppColor.normalTextColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              customSpacerHeight(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 14,
                                    color:
                                        AppColor.primaryOrange.withOpacity(0.7),
                                  ),
                                  customSpacerWidth(width: 4),
                                  if (data?.expire != null)
                                    Text(
                                      DateFormat('d MMM yyyy').format(
                                          DateTime.parse(data?.expire ?? "")),
                                      style:
                                          AppStyle.normal_text_black.copyWith(
                                        color: AppColor.primaryOrange
                                            .withOpacity(0.7),
                                        fontSize:
                                            Dimensions.fontSizeDefault - 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                              ),
                              customSpacerHeight(height: 4),
                              InfoRow(icon: Icons.play_circle_outline, label: data?.course?.level?.toString() ?? "0",),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void _handleCourseTap(Enrollments data) {
  if (data.course?.title == null && data.course?.thumbnail == null ||
      data.enrollmentStatus == CourseStatus.Expired.name) {
    showWarningMessage(message: "🙁 Sorry, Invalid course!");
  } else {
    if (data.enrollmentStatus == CourseStatus.Success.name) {
      Get.toNamed(Routes.CHAPTER_SCREEN);

      ///Module screen
      Get.find<MyCourseController>().getModules(data.course?.id?.toString() ?? "");
    }
  }
}

Widget _invalidCourse(Enrollments data) {
  return GestureDetector(
    onTap: () {
      showWarningMessage(message: "🙁 Sorry, Invalid course!");
    },
    child: SizedBox(
      width: AppLayout.getWidth(200),
      child: Card(
        elevation: 0,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(4)),
        color: AppColor.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 200,
              height: 150,
              child: CustomNetworkImage(
                imgUrl: data.course?.thumbnail ?? "",
                isRectangleImg: true,
              ),
            ),
            customSpacerWidth(width: 6),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.course?.title ?? "Unknown Title",
                    maxLines: 1,
                    style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  customSpacerHeight(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: AppColor.primaryOrange.withOpacity(0.7),
                      ),
                      customSpacerWidth(width: 4),
                      if (data.expire != null)
                        Text(
                          DateFormat('d MMM yyyy')
                              .format(DateTime.parse(data.expire ?? "")),
                          style: AppStyle.normal_text_black.copyWith(
                            color: AppColor.primaryOrange.withOpacity(0.7),
                            fontSize: Dimensions.fontSizeDefault - 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


