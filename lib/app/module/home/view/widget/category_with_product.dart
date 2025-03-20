import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import '../../../../../utils/api_endpoints.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_network_image.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../add_to_cart/controller/wishlist_controller.dart';
import '../../../add_to_cart/hive/hive_object.dart';
import '../../controller/home_controller.dart';
import 'package:hive/hive.dart';
import 'details/crouse_details.dart';

class CategoryWithProduct extends GetView<HomeController> {
  const CategoryWithProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Obx(() {
          final categoryName = controller.isSelectCategoryName.value;
          return Text(
            categoryName.isNotEmpty ? categoryName : "Category",
            style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
          );
        }),
      ),
      body: const SearchListWidget(),
    );
  }
}

class SearchListWidget extends GetView<HomeController> {
  const SearchListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth * 0.02;
    final double titleFontSize = screenWidth * 0.034;
    final double priceFontSize = screenWidth * 0.035;
    final double timeIconSize = screenWidth * 0.037;
    final double timeTextSize = screenWidth * 0.030;

    return Obx(() {
      if (controller.isCategoryWithLoading.isTrue) {
        return loadingIndicator();
      }
      final data = controller.categoryWithProduct?.data;
      if (data == null || data.isEmpty) {
        return  Center(child: Text("No data available here!",style: AppStyle.normal_text_grey,));
      }
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1 / 1.5,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              _buildCard(padding, titleFontSize, priceFontSize, timeIconSize, timeTextSize, index),
              _addCardItem(index),
              _buildFreeTag(data[index].type ?? ""),
            ],
          );
        },
      );
    });
  }

  Widget _buildCard(double padding, double titleFontSize, double priceFontSize, double timeIconSize, double timeTextSize, int index) {
    final product = controller.categoryWithProduct?.data?[index];
    if (product == null) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => const CourseDetailsPage(),
          ),
        );
        controller.getCourseDetailsList(id: product.id?.toString() ?? "");
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: AppColor.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              width: 200,
              height: 150,
              child: CustomNetworkImage(
                imgUrl: product.thumbnail ?? "",
                isRectangleImg: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? "No Title",
                    maxLines: 1,
                    style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: titleFontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${AppString.text_usa_currency} ${(product.discountPrice ?? product.price) ?? "0.00"}",
                    style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: priceFontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: timeIconSize,
                        color: AppColor.normalTextColor.withOpacity(0.7),
                      ),
                      customSpacerWidth(width: padding * 0.5),
                      Text(
                        "${product.duration ?? "0"} m",
                        style: AppStyle.normal_text_black.copyWith(
                          color: AppColor.normalTextColor.withOpacity(0.7),
                          fontSize: timeTextSize,
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
    );
  }

  Widget _addCardItem(int index) {
    final product = controller.categoryWithProduct?.data?[index];
    if (product == null) return const SizedBox.shrink();

    final wishlistBox = Hive.box<AddToCartItem>(wishListTableKey);
    final exists = RxBool(wishlistBox.values.any((item) => item.id == product.id));

    return Obx(() => Positioned(
      right: 8,
      bottom: 8,
      child: GestureDetector(
        onTap: () {
          final wishlistController = Get.find<WishlistController>();
          if (exists.value) {
            wishlistController.deleteItem(product.id ?? 0);
          } else {
            wishlistController.addItem(
              id: product.id ?? 0,
              name: product.title ?? "Unknown",
              rent: product.price ?? "0.00",
              bedroom: product.duration.toString() ?? "0",
              img: product.thumbnail ?? "",
            );
          }
          exists.value = wishlistBox.values.any((item) => item.id == product.id);
        },
        child: Icon(
          exists.value ? Icons.done : Icons.add,
          color: AppColor.primaryColor,
        ),
      ),
    ));
  }

  Widget _buildFreeTag(String text) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Positioned(
      top: 4,
      right: 4,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            text,
            style: AppStyle.normal_text.copyWith(
              fontSize: Dimensions.fontSizeDefault - 2,
            ),
          ),
        ),
      ),
    );
  }
}

int getCrossAxisCount(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth >= 1200) {
    return 4; // Larger screens
  } else if (screenWidth >= 800) {
    return 3; // Medium screens (tablets, etc.)
  } else {
    return 2; // Smaller screens (phones)
  }
}
