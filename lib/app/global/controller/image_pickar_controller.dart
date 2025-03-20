import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_string.dart';
import '../view/widget/error_message.dart';


class PickImageController extends GetxController {
  var pickedImage = Rx<XFile?>(null);

  //picked file form storage here
  Future<void> pickImage(ImageSource source) async {
    // permission check for device form storage
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      if (image.path.length > 500.toInt()) {
        showErrorMessage(
          message: AppString.text_error.tr,
        );
      }
      pickedImage.value = image;
    }
  }
}
