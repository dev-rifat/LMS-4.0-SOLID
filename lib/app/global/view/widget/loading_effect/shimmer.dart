import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListEffect extends StatelessWidget {
  final double itemHeight;
  final double? itemCardHeight;
  final double itemWidth;
  final Widget? imageWidget;
  final Axis scrollDirection;
  final int itemCount;
  final EdgeInsetsGeometry padding;
  final Color baseColor;
  final Color highlightColor;
  final BorderRadiusGeometry borderRadius;

  const ShimmerListEffect({
    super.key,
    this.itemHeight = 40,
    this.itemWidth = 80,
    this.itemCardHeight,
    this.imageWidget,
    this.scrollDirection = Axis.horizontal,
    this.itemCount = 6,
    this.padding = const EdgeInsets.only(left: 12.0),
    this.baseColor = Colors.grey,
    this.highlightColor = Colors.grey,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: Shimmer.fromColors(
        baseColor: baseColor.withOpacity(0.3),
        highlightColor: highlightColor.withOpacity(0.1),
        child: ListView.builder(
          itemCount: itemCount,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: scrollDirection,
          itemBuilder: (context, index) => Padding(
            padding: padding,
            child: Container(
              width: itemWidth,
              height: itemCardHeight,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}