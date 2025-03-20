import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_0_3/utils/app_color.dart';
import 'package:lms_0_3/utils/dimensions.dart';

import '../../../../../utils/app_style.dart';

class SearchWidget extends StatelessWidget {
  final bool readOnly;
  final Function? onTap;
  final void Function(String)? onChanged;

  const SearchWidget({
    super.key,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Card(
        color: AppColor.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        child: TextField(
          cursorColor: AppColor.normalTextColor,
          onChanged: onChanged,
          onTap: onTap != null ? () => onTap!() : null, // Safely handle onTap
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: "",
            //What are you going find?
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: AppColor.hintColor,
            ),
            hintStyle: AppStyle.normal_text_black.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: AppColor.hintColor,
            ),
            disabledBorder: _outlineInputBorder,
            enabledBorder: _outlineInputBorder,
            focusedBorder: _outlineInputBorder,
          ),
        ),
      ),
    );
  }
}

const OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide.none,
);
