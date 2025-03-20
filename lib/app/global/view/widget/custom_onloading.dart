import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_color.dart';

Widget onLoading({Color? color, double isSize = 1}) {
  return Center(
    child: CupertinoActivityIndicator(
      animating: true,
      radius: Checkbox.width * isSize,
      color: color ?? AppColor.primaryColor,
    ),
  );
}

Widget loadingIndicator() => const Center(
      child: CupertinoActivityIndicator(
        color: AppColor.primaryColor,
        radius: 18,
      ),
    );
