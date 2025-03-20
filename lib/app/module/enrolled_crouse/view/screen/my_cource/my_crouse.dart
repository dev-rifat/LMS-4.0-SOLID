import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/my_crouse_modle.dart';
import '../../../../../../enum.dart';
import '../../../../../../routes/app_pages.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/view/screen/custom_card.dart';
import '../../../../../global/view/screen/unauthenticated.dart';
import '../../../../../global/view/widget/warning_message.dart';
import '../../../controller/my_crouse_controller.dart';
import '../../../enrolled_crouse_bindings/enrolled_bindings.dart';

class PurchasedCoursesPage extends GetView<MyCourseController> {
  const PurchasedCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject dependencies
    EnrolledBindings().dependencies();

    // Check authentication
    if (GetStorage().read(AppString.ACCESS_TOKEN) == null) {
      return const Unauthenticated();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "My Courses",
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: RefreshIndicator(
          onRefresh: controller.getMyCourse,
          backgroundColor: AppColor.cardColor,
          color: AppColor.primaryColor,
          child: controller.obx(
            (state) => _buildCourseList(),
            onLoading: loadingIndicator(),
            onEmpty: _buildEmptyState(),
          ),
        ),
      ),
    );
  }

  Widget _buildCourseList() {
    final enrollments = controller.myCourseModel.value.enrollments;

    if (enrollments == null || enrollments.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      itemCount: enrollments.length,
      itemBuilder: (context, index) {
        Enrollments data = enrollments[index];
        return CourseCard(
          data: data,
          isCompactView: MediaQuery.of(context).size.width < 600,
          onTap: () => _handleCourseTap(data),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Courses found!", style: AppStyle.normal_text_grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleCourseTap(Enrollments data) {
    if (data.course?.title == null && data.course?.thumbnail == null || data.enrollmentStatus == CourseStatus.Expired.name||  data.enrollmentStatus==null) {
      showWarningMessage(message: "🙁 Sorry, Invalid course!");
    } else {
      if (data.enrollmentStatus == CourseStatus.Success.name) {
        Get.toNamed(Routes.CHAPTER_SCREEN);
        ///Module screen
        controller.getModules(data.course?.id?.toString() ?? "");
        Get.find<MyCourseController>().courseId.value=data.course?.id?.toString() ?? "";
      }
    }
  }
}

class CourseCard extends StatelessWidget {
  final Enrollments data;
  final bool isCompactView;
  final VoidCallback onTap;

  const CourseCard({
    super.key,
    required this.data,
    required this.isCompactView,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final course = data.course;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shadowColor: AppColor.cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseImage(imageUrl: course?.thumbnail ?? ""),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CourseDetails(
                    title: course?.title ?? "Unknown Title",
                    chapterCount: course?.level?.toString() ?? "0",
                    expiryDate: data.expire ?? "",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
