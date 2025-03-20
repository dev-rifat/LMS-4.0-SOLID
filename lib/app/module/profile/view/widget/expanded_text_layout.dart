import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';




class ExpandedText extends StatefulWidget {
  final String text;
  const ExpandedText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedText> createState() => _ExpandedTextState();
}

class _ExpandedTextState extends State<ExpandedText> {
  late String firstHalf;
  late String secondHalf;
  bool isExpanded = false;

  @override
  void initState() {
    if (widget.text.length > 100) {
      firstHalf = widget.text.substring(0, 100);
      secondHalf = widget.text.substring(101, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return secondHalf == ""
        ? RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.text,
            style: disTextStyle,
          ),
        ],
      ),
    )
        : RichText(

      text: TextSpan(
        children: [
          // half text layout here
          _halfText(),
          TextSpan(
            text: isExpanded ? " ${AppString.text_view_less.tr}" : " ...${AppString.text_view_more}",
            style: AppStyle.mid_large_text.copyWith(color: AppColor.primaryColor,fontSize: Dimensions.fontSizeDefault),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                setState(() {
                  isExpanded = !isExpanded;
                });

                //_readMoreText();
              },
          ),
        ],
      ),
    );
  }

  _halfText() {
    return  TextSpan(
      text: isExpanded ? widget.text : firstHalf,
      style: disTextStyle,
    );
  }
}
TextStyle get disTextStyle {
  return AppStyle.normal_text_black;

}