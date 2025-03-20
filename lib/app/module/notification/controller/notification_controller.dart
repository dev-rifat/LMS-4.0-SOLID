import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../utils/app_string.dart';
import '../models/notification_model.dart';
import '../repository/notification_repository.dart';

class NotificationController extends GetxController with StateMixin {
  final NotificationRepository _notificationRepository;
  NotificationController(this._notificationRepository);

  NotificationModel? notificationModel;

  Future getNotification() async {
    change(null, status: RxStatus.loading());
    try {
      notificationModel = await _notificationRepository.getNotification();
    } catch (e) {
      log("getNotification $e");
    }
    change(null, status: RxStatus.success());
  }

  @override
  void onInit() {
    if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
      getNotification();
    }
    super.onInit();
  }
}
