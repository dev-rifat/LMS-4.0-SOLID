import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_alert_dialog.dart';
import '../../../../global/view/widget/custom_network_image.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home/view/widget/details/crouse_details.dart';
import '../../controller/wishlist_controller.dart';
import '../../hive/hive_object.dart';

class AddToCartScreen extends StatelessWidget {
  AddToCartScreen({super.key});
  final WishlistController controller = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "My cart",
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSearchLayout(context),
            customSpacerHeight(height: 14),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: controller.wishlistBox.listenable(),
                builder: (context, Box<AddToCartItem> box, _) {
                  if (box.isEmpty) {
                    return  Center(
                      child: Text(
                        'No items in Cart.',
                        style: AppStyle.normal_text_grey,
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final item = box.getAt(index);
                      return _buildCartItem(item);
                    },
                    separatorBuilder: (context, index) => customSpacerHeight(height: 12),
                  );
                },
              ),
            ),
            customSpacerHeight(height: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(AddToCartItem? item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              Get.context!,
              MaterialPageRoute(
                builder: (context) => const CourseDetailsPage(),
              ));

          Get.find<HomeController>().getCourseDetailsList(
              id: "${item?.id}");
        },
        child: Card(
          elevation: 0,
          shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(4),
          ),
          color: AppColor.cardColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemImage(item?.img),
              customSpacerWidth(width: 6),
              Expanded(child: _buildItemDetails(item)),
              _buildDeleteButton(item?.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemImage(String? imgUrl) {
    return Container(
      color: Colors.transparent,
      width: 120,
      height: 110,
      child: CustomNetworkImage(
        imgUrl: "/${imgUrl ?? ""}",
        isRectangleImg: true,
        borderRadius: 4,
      ),
    );
  }

  Widget _buildItemDetails(AddToCartItem? item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item?.name ?? "",
            maxLines: 1,
            style: AppStyle.normal_text_grey.copyWith(
              color: AppColor.normalTextColor,
              fontSize: Dimensions.fontSizeDefault + 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${AppString.text_usa_currency} ${item?.price ?? ""}",
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
                size: 17,
                color: AppColor.normalTextColor.withOpacity(0.7),
              ),
              customSpacerWidth(width: 4),
              Text(
                "${item?.time ?? ""} m",
                style: AppStyle.normal_text_black.copyWith(
                  color: AppColor.normalTextColor.withOpacity(0.7),
                  fontSize: Dimensions.fontSizeDefault - 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(int? itemId) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
         onTap: () => controller.deleteItem(itemId ?? 0),

        child: const Icon(
          Icons.done,
          color: AppColor.primaryColor,
        ),
      ),
    );



  }

  Widget _buildSearchLayout(BuildContext context) {
    return GestureDetector(

      onTap: () {
        Get.toNamed(Routes.SEARCH_SCREEN);
        Get.find<HomeController>().getSearchList();

      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: AppColor.hintColor.withOpacity(0.2),
          shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.search,
                  color: AppColor.normalTextColor,
                ),
                customSpacerWidth(width: 8),
                Text(
                  "Search",
                  style: AppStyle.normal_text_black.copyWith(
                    fontSize: Dimensions.fontSizeDefault + 2,
                    color: AppColor.normalTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
