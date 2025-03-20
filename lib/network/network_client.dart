import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../utils/api_endpoints.dart';
import '../utils/app_string.dart';

String _getRequestUrl(String apiEndPoint) => Api.BASE_URL + apiEndPoint;

class NetworkClient extends GetConnect {

  Future<Response> getRequest(String apiEndPoint) async {
    return await get(_getRequestUrl(apiEndPoint), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
  }


  Future<Response> postRequest(String apiEndPoint,Map<String, dynamic> body) async {
    Response response = await post(_getRequestUrl(apiEndPoint), body, headers: {
      "Accept": "application/json; charset=UTF-8",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));

    return response;
  }

  Future<Response> putRequest(String apiEndPoint, dynamic body) async {
    Response response = await put(_getRequestUrl(apiEndPoint), body, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": GetStorage().read(AppString.ACCESS_TOKEN) != null
          ? "Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}"
          : ""
    }).timeout(const Duration(seconds: 15));
    return response;
  }
}
