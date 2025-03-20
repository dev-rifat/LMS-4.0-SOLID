import 'package:get/get.dart';
import 'package:lms_0_3/app/module/home/controller/home_controller.dart';
import '../repository/home_repository.dart';

class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeController(Get.find<HomeRepository>()));
  }
}