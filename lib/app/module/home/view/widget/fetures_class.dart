import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/utils/app_color.dart';
import 'package:lms_0_3/utils/dimensions.dart';
import '../../../../global/view/widget/custom_network_image.dart';
import '../../../../global/view/widget/loading_effect/shimmer.dart';
import '../../controller/home_controller.dart';

class FeatureClass extends GetView<HomeController> {
  FeatureClass({super.key});

  // Initialize the FeatureController using GetX
  final FeatureController _controller = Get.put(FeatureController());

  // Widget for the dot indicator
  Widget _buildDotIndicator(int index) {
    return Obx(() {
      final isActive = _controller.currentPage.value == index;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        width: isActive ? 24.0 : 8.0, // Changes size when active
        height: 8.0,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primaryColor : AppColor.hintColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isFeatureClassLoading.isTrue) {
      return ShimmerListEffect(
        itemHeight: 200,
        itemWidth: MediaQuery.of(context).size.width / 1.1,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        itemCardHeight: 200,
        borderRadius: BorderRadius.circular(5),
        scrollDirection: Axis.horizontal,
      );
    }

    final apps = controller.featureClassesListModel?.apps;

    // Store image URLs in a list for better readability
    final List<String> imageUrls = [
      apps?.image1 ?? "",
      apps?.image2 ?? "",
      apps?.image3 ?? "",
      apps?.image4 ?? "",
    ];

    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller.pageController,
            itemCount: imageUrls.length,
            onPageChanged: _controller.onPageChanged,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                child: CustomNetworkImage(
                  imgUrl: imageUrls[index],
                  isRectangleImg: true,
                  isAppSetting: true,
                   borderRadius: 10,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imageUrls.length,
                (index) => _buildDotIndicator(index),
          ),
        ),
      ],
    );
  }
}


class FeatureController extends GetxController {
  final PageController pageController = PageController();
  var currentPage = 0.obs;
  List<String> imageUrls = [];
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final apps = Get.find<HomeController>().featureClassesListModel?.apps;
    imageUrls = [
      apps?.image1 ?? "",
      apps?.image2 ?? "",
      apps?.image3 ?? "",
      apps?.image4 ?? "",
    ];

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        int nextPage = (currentPage.value + 1) % imageUrls.length;
        pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        currentPage.value = nextPage;
      }
    });
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer to prevent memory leaks
    pageController.dispose();
    super.onClose();
  }
}
