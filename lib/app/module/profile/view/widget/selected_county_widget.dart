import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';



TextStyle get countyTextStyle {
  return const TextStyle(fontSize: 16, color: AppColor.normalTextColor);
}
BorderRadius get countyFieldRadius {
  return BorderRadius.only(
    topLeft: Radius.circular(Dimensions.radiusMid),
    topRight: Radius.circular(Dimensions.radiusMid),
  );
}
InputDecoration get countryDecoration {
  return InputDecoration(
      hintText: AppString.text_search,
      isDense: true,
      focusedBorder:
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      border:
      const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)));
}

Widget countyField(
    {context,
      onAction,
      String? Function(String?)? validator,
      required TextEditingController controller}) {
  return Card(
    color:Colors.transparent,
    elevation: 0,

    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColor.hintColor),
      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
    ),

    shadowColor: Colors.grey.withOpacity(0.2),
    child: SizedBox(
      height: AppLayout.getHeight(58),
      child: TextFormField(
        validator: validator,
        controller: controller,
        readOnly: true,
        onTap: () => onAction(),
        decoration: InputDecoration(
          hintText: AppString.text_select_county.tr,
          hintStyle:AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
             ),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined,color: AppColor.hintColor,),
          focusColor: Theme.of(context).primaryColor,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(
                  Dimensions.radiusDefault + 7)),
        ),
      ),
    ),
  );

}

RoundedRectangleBorder get cardStyle {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusMid));
}