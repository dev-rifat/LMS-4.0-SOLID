import 'package:get/get.dart';
import 'package:lms_0_3/app/module/profile/controller/profile_controller.dart';
import 'package:lms_0_3/app/module/profile/repository/profile_repository.dart';
import 'package:lms_0_3/app/module/profile/services/profile_services.dart';
import '../../../global/services/services.dart';


class ProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController(Get.find<ProfileRepository>()));
  }
}