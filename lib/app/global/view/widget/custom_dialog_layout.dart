import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';

void showCustomDialog(
    {required BuildContext context,
      String? titleText = "",
      String? descriptionText = "",
      String? btnText = "",
      Widget? widgetTitleText,
      Widget? body,
      Widget? btnWidget,
      IconData? icon,
      Color? iconColor,
      Widget? iconWidget,
      TextStyle? titleTextStyle,
      TextStyle? descriptionTextStyle,
      Function? onPressed,
      TextStyle? btnCancelTextStyle,
      TextStyle? btnSaveTextStyle}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                iconWidget ??
                    Center(
                        child: Icon(
                          icon ?? Icons.delete_outline,
                          size: 30,
                          color: iconColor ?? AppColor.errorColor,
                        )),
                const SizedBox(
                  height: 16,
                ),
                widgetTitleText ??
                    Center(
                      child: Text(
                        titleText!,
                        textAlign: TextAlign.center,
                        style: titleTextStyle ??
                            const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                const SizedBox(
                  height: 18,
                ),
                body ??
                    Text(
                      descriptionText!,
                      textAlign: TextAlign.center,
                      style: descriptionTextStyle ??
                          TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                    ),
                const SizedBox(
                  height: 20,
                ),
                btnWidget ??
                    _btnLayout(context, btnCancelTextStyle, onPressed,
                        btnSaveTextStyle, btnText)
              ],
            ),
          ),
        ),
      );
    },
  );
}

_btnLayout(context, btnCancelTextStyle, onPressed, btnSaveTextStyle, btnText) {
  return Row(
    children: [
      const Spacer(),
      TextButton(
        onPressed: () {
          // Close the dialog
          Navigator.of(context).pop();
        },
        child: Text(
          'Cancel',
          style: btnCancelTextStyle ?? const TextStyle(),
        ),
      ),
      TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          btnText ?? 'Save',
          style: btnSaveTextStyle ?? const TextStyle(color: Colors.blue),
        ),
      ),
    ],
  );
}

dialogLoader() {
  return const Padding(
    padding: EdgeInsets.all(12.0),
    child: Center(
      child: CupertinoActivityIndicator(
        radius: 12,
        color: AppColor.primaryColor,
      ),
    ),
  );
}