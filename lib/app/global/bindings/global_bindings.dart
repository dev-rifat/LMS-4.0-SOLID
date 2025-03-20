import 'package:get/get.dart';
import 'package:lms_0_3/app/global/services/services.dart';

import '../../../module/starting/controller/network_controller.dart';
import '../../../module/starting/view/splash_screen.dart';
import '../../../network/network_client.dart';
import '../../module/auth/repository/auth_repository.dart';
import '../../module/auth/services/auth_services.dart';
import '../../module/enrolled_crouse/repository/enrolled_repository.dart';
import '../../module/enrolled_crouse/services/enrolled_services.dart';
import '../../module/home/repository/home_repository.dart';
import '../../module/home/services/home_services.dart';
import '../../module/notification/repository/notification_repository.dart';
import '../../module/notification/services/notification_services.dart';
import '../../module/profile/repository/profile_repository.dart';
import '../../module/profile/services/profile_services.dart';



class GlobalBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(SplashController());
    ApiService apiService =  Get.put(ApiService(NetworkClient()),permanent: true);
    Get.put<AuthRepository>(AuthImplement(Get.put(AuthApiService(apiService))),permanent: true);
    Get.put<HomeRepository>(HomeImplement(Get.put(HomeApiService(apiService))),permanent: true);
    Get.put<NotificationRepository>(NotificationImplement(Get.put(NotificationApiService(apiService))),permanent: true);
    Get.put<EnrolledDataSource>(EnrolledImplement(Get.put(EnrolledApiService(apiService))),permanent: true);
    Get.put<ProfileRepository>(ProfileImplement(Get.put(ProfileApiService(apiService))),permanent: true);
  }
}