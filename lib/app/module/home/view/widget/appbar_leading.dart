import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/images.dart';

class AppBarInfoLeading extends StatelessWidget {
  const AppBarInfoLeading({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            ZoomDrawer.of(context)?.toggle();
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              AppImages.menu,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rise",
              style: AppStyle.title_text.copyWith(
                color: AppColor.cardColor,
                fontSize: Dimensions.fontSizeLarge,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Let's start learning!",
              style: AppStyle.normal_text.copyWith(color: AppColor.cardColor),
            ),
          ],
        ),
      ],
    );
  }
}

