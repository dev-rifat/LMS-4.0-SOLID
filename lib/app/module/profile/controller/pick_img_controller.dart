import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_0_3/app/module/profile/controller/profile_controller.dart';

import '../../../../utils/app_string.dart';
import '../../../global/view/widget/error_message.dart';
import '../../../global/view/widget/success_message.dart';


class PickedFileFormStorage {
  var pickedImage = Rx<XFile?>(null);
  var filePath ="".obs;

  //picked file form storage here


  Future<void> pickImageForProfile(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);


    if (image != null) {
      // Check image size
      File imageFile = File(image.path);
      int fileSizeInBytes = await imageFile.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024); // Convert bytes to MB

      if (fileSizeInMB <= 1) {
        // Image meets size requirement
        pickedImage.value = image;
        filePath.value =image.path;
        await Get.find<ProfileController>().changeImageImage(image: image);
      } else {
        // Inform user about size requirement
        showErrorMessage(message: AppString.text_jpeg_format_not_support);
      }


    }

  }


  toastMessage(bool status) {
    return status == false
        ? showSuccessMessage(
        message: AppString.text_file_upload_update_successfully)
        : showErrorMessage(message: AppString.text_file_upload_file);
  }
}