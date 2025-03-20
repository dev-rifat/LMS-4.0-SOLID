import 'package:flutter/material.dart';
import 'package:lms_0_3/app/global/view/widget/loading_effect/shimmer.dart';
import '../custom_build_title_text.dart';
import '../cutom_component/margin_layout.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  // Method to create a ShimmerListEffect with configurable parameters
  Widget _buildShimmerListEffect({
    required double itemHeight,
    required double itemWidth,
    required int itemCount,
    required Axis scrollDirection,
    EdgeInsets? padding,
  }) {
    return ShimmerListEffect(
      itemHeight: itemHeight,
      itemWidth: itemWidth,
      itemCount: itemCount,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      itemCardHeight: itemHeight,
      borderRadius: BorderRadius.circular(5),
      scrollDirection: scrollDirection,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: marginLayout.copyWith(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerListEffect(
            itemHeight: 80,
            itemWidth: screenWidth / 1.1,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
          const SizedBox(height: 12),
          buildText("Feature classes:"),
          _buildShimmerListEffect(
            itemHeight: 200,
            itemWidth: screenWidth / 1.1,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
          buildText("Latest bundle:"),
          const SizedBox(height: 12),
          _buildShimmerListEffect(
            itemHeight: 250,
            itemWidth: 200,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}
