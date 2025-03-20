import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/repository/enrolled_repository.dart';
import '../../enrolled_crouse/controller/my_crouse_controller.dart';


class EnrolledBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(MyCourseController(Get.find<EnrolledDataSource>()));
  }
}