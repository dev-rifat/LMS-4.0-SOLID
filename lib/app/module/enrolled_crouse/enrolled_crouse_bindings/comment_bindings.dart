import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/repository/enrolled_repository.dart';
import '../controller/comment_controller.dart';


class CommentBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CommentController(Get.find<EnrolledDataSource>()));
  }
}