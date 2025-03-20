import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/module/home/models/cource_details_model.dart' as dlt;
import '../../../../../../utils/api_endpoints.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_string.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/view/widget/custom_network_image.dart';
import '../../../../../global/view/widget/cutom_component/custom_app_buttom.dart';
import '../../../../../global/view/widget/cutom_component/custom_title_text.dart';
import '../../../../../global/view/widget/cutom_component/expened_label_text.dart';
import '../../../../add_to_cart/controller/wishlist_controller.dart';
import '../../../../add_to_cart/hive/hive_object.dart';
import '../../../../enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../../enrolled_crouse/view/screen/my_cource/my_crouse.dart';
import '../../../controller/home_controller.dart';
import 'enroll_now.dart';

class CourseDetailsPage extends GetView<HomeController> {
  const CourseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Details',
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
      ),
      body: controller.obx(
            (state) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCourseImage(context),
                    const SizedBox(height: 16),
                    _buildCourseTitle(),
                    const SizedBox(height: 8),
                    _buildInstructorName(),
                    const SizedBox(height: 16),
                    _buildCourseDescription(),
                    const SizedBox(height: 16),
                    _buildCourseDetailsRow(Icons.access_time, 'Duration',
                        '${controller.courseDetailsModel?.data?.duration ?? "N/A"} m'),
                    const SizedBox(height: 16),
                    _buildCourseDetailsRow(Icons.label_important_outline, 'Level',
                        controller.courseDetailsModel?.data?.level ?? "N/A"),
                    const SizedBox(height: 16),
                    _buildPriceSection(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomButtons(),
            const SizedBox(height: 8),
          ],
        ),
        onLoading:loadingIndicator(),
      ),
    );
  }

  Widget _buildCourseImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      child: CustomNetworkImage(
        imgUrl: controller.courseDetailsModel?.data?.thumbnail ?? "",
        isRectangleImg: true,
        borderRadius: 6,
      ),
    );
  }

  Widget _buildCourseTitle() {
    return Text(
      controller.courseDetailsModel?.data?.title ?? "No Title Available",
      style: AppStyle.normal_text_grey.copyWith(
        color: AppColor.normalTextColor,
        fontSize: Dimensions.fontSizeMid,
      ),
    );
  }

  Widget _buildInstructorName() {
    final courseData = controller.courseDetailsModel?.data;
    final status = courseData?.status ?? "Unknown";
    final type = courseData?.type ?? "Unknown";

    return Row(
      children: [
        Icon(Icons.circle,
            color: status == "Active"
                ? AppColor.successColor
                : AppColor.errorColor,
            size: 12),
        const SizedBox(width: 8),
        Text("$status - $type", style: AppStyle.normal_text),
      ],
    );
  }

  Widget _buildCourseDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCustomTitleText(text: "Description", isHoldSeeMoreText: true),
        const SizedBox(height: 8),
        ExpendableLabelWidget(
          text: controller.courseDetailsModel?.data?.description ??
              "No description available.",
        ),
      ],
    );
  }

  Widget _buildCourseDetailsRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Text('$label: $value', style: AppStyle.normal_text),
      ],
    );
  }

  Widget _buildPriceSection() {
    final courseData = controller.courseDetailsModel?.data;
    final price = courseData?.price ?? "N/A";
    final discountPrice = courseData?.discountPrice;

    return Row(
      children: [
        const Icon(Icons.monetization_on_outlined, size: 18),
        const SizedBox(width: 3),
        if (discountPrice != null)...[
          Text(
            '${AppString.text_usa_currency} $price',
            style: AppStyle.normal_text.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.hintColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: 6),
        ],

        Text(
          '${AppString.text_usa_currency} ${discountPrice ?? price}',
          style: AppStyle.normal_text.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    dlt.Data? courseData = controller.courseDetailsModel?.data;
    dlt.CourseDetailsModel? data = controller.courseDetailsModel;
    final itemId = courseData?.id;
    final wishlistBox = Hive.box<AddToCartItem>(wishListTableKey);
    final exists = RxBool(wishlistBox.values.any((item) => item.id == itemId));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (controller.courseDetailsModel?.isEnrollerd != true)...[
            Expanded(
              child: Obx(() => CustomAppButton(
                buttonColor: exists.value
                    ? AppColor.cardColor
                    : AppColor.primaryColor,
                btnBorderColor: AppColor.primaryColor,
                buttonTextColor: exists.value
                    ? AppColor.primaryColor
                    : AppColor.cardColor,
                text: exists.value ? "Cart Added" : "Add to Cart",
                buttonRadius: 8,
                onPressed: () {
                  if (exists.value) {
                    Get.find<WishlistController>()
                        .deleteItem(itemId ?? 0);
                  } else {
                    Get.find<WishlistController>().addItem(
                      id: courseData?.id ?? 0,
                      name: courseData?.title ?? "",
                      rent: courseData?.price ?? "",
                      bedroom: courseData?.duration.toString() ?? "",
                      img: courseData?.thumbnail ?? "",
                    );
                  }
                  exists.value = wishlistBox.values
                      .any((item) => item.id == itemId);
                },
              )),
            ),
            SizedBox(width: 8,)
      ],

          if (GetStorage().read(AppString.ACCESS_TOKEN) != null)
            Expanded(
              child: Obx(() {
                final isLoading = Get.find<MyCourseController>().isAddCourseLoading.isTrue;

                return isLoading
                    ? loadingIndicator()
                    : CustomAppButton(
                  buttonColor: AppColor.primaryOrange,
                  text: controller.courseDetailsModel?.isEnrollerd == true
                      ? "Enrolled"
                      : "Enroll Now",
                  buttonRadius: 8,
                  onPressed: () => _handleEnrollButton(data?? dlt.CourseDetailsModel()),
                );
              }),
            ),
        ],
      ),
    );
  }

  void _handleEnrollButton( dlt.CourseDetailsModel courseData) {
    if (courseData.isEnrollerd == true) {
      Get.to(() => const PurchasedCoursesPage());
      Get.find<MyCourseController>().getMyCourse();
    } else if (courseData.data?.type?.toLowerCase() == "free") {
      Get.find<MyCourseController>()
          .addCourse(
        courseData.data?.id?.toString() ?? "0",
        "",
        _getPrice(),
      )
          .then((_) => controller.getCourseDetailsList(
        id: courseData.data?.id?.toString() ?? "",
      ));
    } else {
      Get.to(() => EnrollNowPage(
        addCourseInfo: AddCourseInfo(
          id: "${courseData.data?.id ?? 0}",
          coupon: "",
          price: _getPrice(),
          title: courseData.data?.title ?? "",
        ),
      ));
     // Get.find<HomeController>().getCouponList();
    }
  }

  String _getPrice() {
    final courseData = controller.courseDetailsModel?.data;
    return courseData?.discountPrice ?? courseData?.price ?? "";
  }
}
