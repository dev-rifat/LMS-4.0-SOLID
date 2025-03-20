import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/my_crouse_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/enrolled_crouse_bindings/enrolled_bindings.dart';
import 'package:lms_0_3/app/module/home/home_bindings/home_bindings.dart';
import 'package:lms_0_3/utils/app_string.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../global/view/widget/custom_build_title_text.dart';
import '../../../../global/view/widget/loading_effect/home_loading.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../controller/home_controller.dart';
import '../widget/app_bar_section.dart';
import '../widget/category_list.dart';
import '../widget/copun_list.dart';
import '../widget/fetures_class.dart';
import '../widget/latest_bundle.dart';
import '../widget/my_cource_in_home.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBindings().dependencies();
    EnrolledBindings().dependencies();

    return  Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: RefreshIndicator(
            onRefresh: _refreshScreen,
            color: AppColor.primaryColor,
            backgroundColor: AppColor.cardColor,
            child: CustomScrollView(
              slivers: [sliverAppBar, _buildSliverContent(context)],

            ),
          ),
        );
  }

  SliverToBoxAdapter _buildSliverContent(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return SliverToBoxAdapter(
      child: controller.obx((state){
        if (controller.isCouponLoading.isFalse &&
            controller.isFeatureClassLoading.isFalse &&
            controller.isLatestBundleLoading.isFalse) {
          return _buildHomeContent(context);
        } else {
          return const Center(child: HomeLoadingWidget());
        }
      },onLoading: const Center(child: HomeLoadingWidget())
      )

    );
  }

  Padding _buildHomeContent(BuildContext context) {
    final hasAccessToken = GetStorage().read(AppString.ACCESS_TOKEN) != null;
    final hasEnrollments = Get.find<MyCourseController>()
            .myCourseModel
            .value
            .enrollments
            ?.isNotEmpty ??
        false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildCoupon(),
          _spacer(0),
          buildText("Categories:"),
          _spacer(12),
          const CategoryList(),
          _spacer(12),
          FeatureClass(),
          _spacer(12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildText("Courses:"),
              GestureDetector(
                onTap: () {
                  controller.viewAllString = "Courses";
                  Get.toNamed(Routes.SEARCH_SCREEN);
                  controller.getSearchList();
                },
                child: Text(
                  "See more",
                  style: AppStyle.normal_text_grey
                      .copyWith(color: AppColor.primaryColor, fontSize: 12),
                ),
              ),
            ],
          ),
          _spacer(12),
          const LatestBundle(),
          if (hasAccessToken && hasEnrollments) ...[
            _spacer(10),
            buildText("My course:"),
            _spacer(8),
            const MyCourseInHome(),
          ]
        ],
      ),
    );
  }

  Widget _spacer([double height = 8]) {
    return SizedBox(height: height);
  }
  Future<void> _refreshScreen() async {
    await controller.getCategory();
    await controller.getFeatureClassList();
    await controller.getCourseList();
    if(GetStorage().read(AppString.ACCESS_TOKEN) !=null){
    await  Get.find<MyCourseController>().getMyCourse();
    await  Get.find<ProfileController>().getProfile();

    }
  }
}
