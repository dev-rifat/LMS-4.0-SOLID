import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_layout.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../global/view/widget/custom_spacer.dart';
import '../../../../global/view/widget/cutom_component/custom_app_buttom.dart';
import '../../../../global/view/widget/cutom_component/cutom_input_field.dart';
import '../../../../global/view/widget/input_note.dart';
import '../../controller/profile_controller.dart';

class TextFieldLayout extends GetView<ProfileController> {
  TextFieldLayout({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userTextFieldLayout(
            hintText: AppString.text_first_name.tr,
            titleText: AppString.text_first_name.tr,
            controller: controller.editFirstNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.fieldIsRequired;
              } else {
                return null;
              }
            },
          ),
          userTextFieldLayout(
            titleText: AppString.text_last_name.tr,
            controller: controller.editLastNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.fieldIsRequired;
              } else {
                return null;
              }
            },
          ),
          userTextFieldLayout(
            titleText: AppString.text_phone.tr,
            controller: controller.editPhoneController,
            readOnly: true,
            textInputType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return AppString.fieldIsRequired;
              } else {
                return null;
              }
            },
          ),
          IgnorePointer(
            ignoring: true,
            child: userTextFieldLayout(
              titleText: "Email",

              controller: controller.emailController,
              readOnly: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppString.fieldIsRequired;
                } else {
                  return null;
                }
              },
            ),
          ),
          customSpacerHeight(height: 20),
          Obx(
            () => _buttonLayout(),
          ),
          customSpacerHeight(height: 80),
        ],
      ),
    );
  }

  _buttonLayout() {
    if (Get.find<ProfileController>().isUpdateProfileLoading.isTrue) {
      return loadingIndicator();
    }
    return Row(
      children: [
        Expanded(
          child: CustomAppButton(
            buttonColor: AppColor.cardColor,
            btnBorderColor: AppColor.primaryColor,
            buttonTextColor: AppColor.primaryColor,
            text: "Cancel",
            buttonRadius: 8,
            onPressed: () => Get.back(canPop: false),
          ),
        ),
        customSpacerWidth(width: 12),
        Expanded(
          child: CustomAppButton(
            buttonColor: AppColor.primaryColor,
            text: "Save",
            buttonRadius: 8,
            onPressed: () {
              Get.find<ProfileController>().updatedProfile(
                  "${controller.editFirstNameController.text} ${controller.editLastNameController.text}",
                  controller.emailController.text,
                  controller.editPhoneController.text);
            },
          ),
        ),
      ],
    );
  }
}

Widget userTextFieldLayout(
    {required titleText,
    required TextEditingController controller,
    bool readOnly = false,
    String? hintText,
    int? maxLength,
    bool? isNoteFieldVisible = false,
    String? Function(String?)? validator,
    TextInputType? textInputType}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$titleText",
        style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      customSpacerHeight(height: 12),
      isNoteFieldVisible != false
          ? InputNote(
              controller: Get.find<ProfileController>().editBioController,
              hintText: AppString.text_bio.tr,
            )
          : CustomInputField(
              hitText: hintText ?? titleText,
              controller: controller,
              validator: validator,
              errorBorderColor: Colors.red,
              hintStyle: AppStyle.normal_text_black.copyWith(
                color:  AppColor.hintColor,
                fontSize: Dimensions.fontSizeDefault + 1,
              ),
              borderColor: AppColor.hintColor,
              textInputType: textInputType,
            ),
      customSpacerHeight(height: 12),
    ],
  );
}

userEditContactField() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Phone",
        style: AppStyle.mid_large_text.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 2),
      ),
      customSpacerHeight(height: 12),
      IntlPhoneField(
        controller:
            TextEditingController(), // You can use your own controller here
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              left: AppLayout.getWidth(16),
              right: AppLayout.getWidth(20),
              top: AppLayout.getHeight(16),
              bottom: AppLayout.getHeight(16)),
          hintText: "Enter number",
          focusColor: AppColor.primaryColor,
          hintStyle: AppStyle.mid_large_text.copyWith(
              color: AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault + 1),
          filled: false,
          fillColor: AppColor.backgroundColor,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 0.0, color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.hintColor),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 0.0, color: AppColor.primaryColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
          ),
        ),

        onChanged: (phone) {
          Get.find<ProfileController>().editPhoneController.text =
              phone.completeNumber;
        },
      ),
    ],
  );
}
