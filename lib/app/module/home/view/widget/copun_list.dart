import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';
import '../../../../global/view/widget/loading_effect/shimmer.dart';
import '../../controller/home_controller.dart';


class BuildCoupon extends GetView<HomeController> {
  final List<Color> cardColors = [
    AppColor.primaryColor,
    AppColor.primaryOrange,
    AppColor.normalTextColor,
    AppColor.primaryBlue,
  ];

  static const String title = "Surprise for you";

  BuildCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.isCouponLoading.isTrue) {
      return ShimmerListEffect(
        itemHeight: 80,
        itemWidth: MediaQuery.of(context).size.width / 1.1,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        itemCardHeight: 80,
        borderRadius: BorderRadius.circular(5),
        scrollDirection: Axis.horizontal,
      );
    }

    final coupons = controller.couponListModel?.value.coupons;
    if (coupons == null || coupons.isEmpty) {
      return const SizedBox.shrink(); // Return an empty widget if no coupons
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: PageView.builder(
        itemCount: coupons.length,
        itemBuilder: (context, index) {
          final subtitle = coupons[index].title ?? "";
          Color cardColor = cardColors[index % cardColors.length];

          return _buildCard(context, title, subtitle, cardColor);
        },
      ),
    );
  }

  Widget _buildCard(
      BuildContext context, String title, String subtitle, Color color) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(8),
          horizontal: 16,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                AppImages.appbarLine,
                fit: BoxFit.cover,
                cacheColorFilter: true, // Caches the SVG for better performance
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppStyle.mid_large_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeMid - 5,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppStyle.title_text.copyWith(
                    color: AppColor.cardColor,
                    fontSize: Dimensions.fontSizeMid,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
