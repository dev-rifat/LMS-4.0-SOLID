import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../../../utils/api_endpoints.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_alert_dialog.dart';
import '../../../../global/view/widget/custom_network_image.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/loading_effect/shimmer.dart';
import '../../../add_to_cart/controller/wishlist_controller.dart';
import '../../../add_to_cart/hive/hive_object.dart';
import '../../controller/home_controller.dart';
import 'details/crouse_details.dart';


class LatestBundle extends GetView<HomeController> {
  const LatestBundle({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isLatestBundleLoading.isTrue) {
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
      height: 250,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: controller.courseListModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
         var data = controller.courseListModel?.data?[index];
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CourseDetailsPage(),
                      ));

                  controller.getCourseDetailsList(
                      id: controller.courseListModel?.data?[index].id
                          .toString() ??
                          "");
                },
                child: SizedBox(
                  width: 200,
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
                            imgUrl: data?.thumbnail ?? "",
                            isRectangleImg: true,
                            borderRadius: 6,
                          ),
                        ),
                        customSpacerWidth(width: 6),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.title ?? "",
                                maxLines: 1,
                                style: AppStyle.normal_text_grey.copyWith(
                                  color: AppColor.normalTextColor,
                                  fontSize: Dimensions.fontSizeDefault,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${AppString.text_usa_currency} ${data?.discountPrice==null?data?.price:data?.discountPrice ?? ""}",
                                style: AppStyle.normal_text_grey.copyWith(
                                  color: AppColor.primaryColor,
                                  fontSize: Dimensions.fontSizeDefault - 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: AppColor.normalTextColor
                                        .withOpacity(0.7),
                                  ),
                                  customSpacerWidth(width: 4),
                                  Text(
                                    "${data?.duration ?? ""} m",
                                    style:
                                    AppStyle.normal_text_black.copyWith(
                                      color: AppColor.normalTextColor
                                          .withOpacity(0.7),
                                      fontSize:
                                      Dimensions.fontSizeDefault - 2,
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
              ),
              Positioned(
                  top: 4,
                  right: 4,
                  child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0, right: 6),
                        child: Text(
                          data?.type ?? "",
                          style: AppStyle.normal_text.copyWith(
                              fontSize: Dimensions.fontSizeDefault - 2),
                        ),
                      ))),
              _addCardItem(index)
            ],
          );
        },
      ),
    );
  }

  _addCardItem(index) {
    final dataItem = controller.courseListModel?.data?[index];

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
              id: controller.courseListModel?.data?[index].id ?? 0,
              name: controller.courseListModel?.data?[index].title ?? "",
              rent: controller.courseListModel?.data?[index].price ?? "",
              bedroom:
              controller.courseListModel?.data?[index].duration.toString() ?? "",
              img: controller.courseListModel?.data?[index].thumbnail ?? "",
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
}
