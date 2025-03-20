import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/global/view/screen/unauthenticated.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/margin_layout.dart';
import 'package:lms_0_3/app/module/notification/notification_bindings/notification_bindings.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_string.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../../../enrolled_crouse/view/screen/my_cource/my_crouse.dart';
import '../../controller/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationBindings().dependencies();

    // Check if the user is authenticated
    if (GetStorage().read(AppString.ACCESS_TOKEN) == null) {
      return const Unauthenticated();
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "Notifications",
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        backgroundColor: AppColor.cardColor,
        color: AppColor.primaryColor,
        child: controller.obx((state){
          final notifications = controller.notificationModel?.notifications;

           if (notifications == null || notifications.isEmpty) {
            // Show a message when no notifications are available
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Text(
                      "No Notifications found!",
                      style: AppStyle.normal_text_grey,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Display notifications
            return Padding(
              padding: marginLayout,
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _buildNotificationCard(
                    context: context,
                    title: notification.type ?? "Unknown",
                    message: notification.comment ?? "No details available",
                    icon: Icons.school,
                  );
                },
              ),
            );
          }
        },onLoading: loadingIndicator())


        ,
      ),
    );
  }

  Future<void> _refreshPage() async {
    // Trigger a refresh in the controller
    await controller.getNotification();
  }

  Widget _buildNotificationCard({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PurchasedCoursesPage(),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0,
        color: AppColor.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: AppColor.primaryColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyle.title_text.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontSizeMid,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      message,
                      style: AppStyle.small_text_grey.copyWith(
                        color: AppColor.normalTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
