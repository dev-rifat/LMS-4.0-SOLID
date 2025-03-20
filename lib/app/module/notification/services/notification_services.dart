import 'package:get/get.dart';
import 'package:lms_0_3/app/global/services/services.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';

class NotificationApiService {
 final ApiService _apiService;
 NotificationApiService(this._apiService);

 Future<Response?> getNotification() async{
   Response? response=await _apiService.getRequest(Api.notification);
   return response;
  }

}

