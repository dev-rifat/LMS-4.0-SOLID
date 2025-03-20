import 'package:get/get.dart';
import '../../../global/services/services.dart';
import '../controller/auth_controller.dart';
import '../repository/auth_repository.dart';
import '../services/auth_services.dart';

class AuthBindings extends Bindings{
  @override
  void dependencies() {
    AuthApiService authApiService =Get.put(AuthApiService(Get.find<ApiService>()));
    AuthRepository authRepository =Get.put(AuthImplement(authApiService));
    Get.put(AuthController(authRepository));
  }
}