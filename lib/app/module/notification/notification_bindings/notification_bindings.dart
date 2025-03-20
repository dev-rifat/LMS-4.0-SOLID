import 'package:get/get.dart';
import 'package:lms_0_3/app/module/notification/controller/notification_controller.dart';
import 'package:lms_0_3/app/module/notification/repository/notification_repository.dart';
import 'package:lms_0_3/app/module/notification/services/notification_services.dart';
import '../../../global/services/services.dart';


class NotificationBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController(Get.find<NotificationRepository>()));

  }
}