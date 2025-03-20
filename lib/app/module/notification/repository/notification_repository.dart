import 'dart:developer';
import 'package:lms_0_3/app/module/notification/services/notification_services.dart';
import '../models/notification_model.dart';

abstract class NotificationRepository {
  Future<NotificationModel?> getNotification();
}

class NotificationImplement implements NotificationRepository {
  final NotificationApiService _notificationApiService;
  NotificationImplement(this._notificationApiService);

  @override
  Future<NotificationModel?> getNotification() async{
    try {
      final response = await _notificationApiService.getNotification();
      if (response?.statusCode == 200) {
        return NotificationModel.fromJson(response?.body);
      }else{
        return null;
      }
    } catch (e) {
      log("getNotification : $e");
    }
    return null;
  }
}

