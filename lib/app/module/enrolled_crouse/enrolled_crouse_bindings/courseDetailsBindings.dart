import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/repository/enrolled_repository.dart';
import '../controller/chapter_details_controller.dart';
import '../controller/tabbar_controller.dart';


class CourseDetailsBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(CourseDetailsController(Get.find<EnrolledDataSource>()));
    Get.put(TabControllerX());
  }
}