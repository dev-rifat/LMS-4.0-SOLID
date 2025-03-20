import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
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
import 'details/crouse_details.dart';

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

    return Expanded(
      child: controller.obx(
          (state){
            if(controller.searchModel?.courses ==null){
              return Center(child: Text("No data available here!",style: AppStyle.normal_text_grey,));
            }
            return  GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(context),
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1 / 1.5,
              ),
              itemCount: controller.searchModel?.courses?.length ?? 0,
              itemBuilder: (context, index) {

                return Stack(
                  children: [
                    _buildCard(padding, titleFontSize, priceFontSize,
                        timeIconSize, timeTextSize, index),
                    _addCardItem(index),
                    _buildFreeTag(
                        controller.searchModel?.courses?[index].type),
                  ],
                );

              },
            );
          },

          onLoading: loadingIndicator()
      ),
    );
  }

  Widget _buildCard(double padding, double titleFontSize, double priceFontSize,
      double timeIconSize, double timeTextSize, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            Get.context!,
            MaterialPageRoute(
              builder: (context) => const CourseDetailsPage(),
            ));

        controller.getCourseDetailsList(
            id: controller.searchModel?.courses?[index].id.toString() ?? "");
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
                imgUrl: controller.searchModel?.courses?[index].thumbnail ?? "",
                isRectangleImg: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.searchModel?.courses?[index].title ?? "",
                    maxLines: 1,
                    style: AppStyle.normal_text_grey.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: titleFontSize,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  controller.searchModel?.courses?[index].discountPrice == null
                      ? Text(
                          "${AppString.text_usa_currency} ${controller.searchModel?.courses?[index].price ?? ""}",
                          style: AppStyle.normal_text_grey.copyWith(
                            color: AppColor.primaryColor,
                            fontSize: priceFontSize,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : Text(
                          "${AppString.text_usa_currency} ${controller.searchModel?.courses?[index].discountPrice ?? ""}",
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
                        "${controller.searchModel?.courses?[index].duration ?? ""} m",
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

  _addCardItem(index) {
    final dataItem = controller.searchModel?.courses?[index];

    final wishlistBox = Hive.box<AddToCartItem>(wishListTableKey);
    final exists =
        RxBool(wishlistBox.values.any((item) => item.id == dataItem?.id));

    return Obx(() => Positioned(
          right: 8,
          bottom: 8,
          child: GestureDetector(
            onTap: () {
              if (exists.value) {
                Get.find<WishlistController>().deleteItem(dataItem?.id ?? 0);
              } else {
                Get.find<WishlistController>().addItem(
                  id: controller.searchModel?.courses?[index].id ?? 0,
                  name: controller.searchModel?.courses?[index].title ?? "",
                  rent: controller.searchModel?.courses?[index].price ?? "",
                  bedroom:
                      controller.searchModel?.courses?[index].duration.toString() ?? "",
                  img: controller.searchModel?.courses?[index].thumbnail ?? "",
                );
              }
              exists.value =
                  wishlistBox.values.any((item) => item.id == dataItem?.id);
            },
            child: Icon(
              exists.value ? Icons.done : Icons.add,
              color: AppColor.primaryColor,
            ),
          ),
        ));
  }

  Widget _buildFreeTag(text) {
    return Positioned(
      top: 4,
      right: 4,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            text ?? "",
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
