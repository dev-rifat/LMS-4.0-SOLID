import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_0_3/network/network_client.dart';


class ApiService {
  final NetworkClient _restApiService;

  ApiService(this._restApiService);


  Future<Response?> getRequest(String endpoint) async {
    return await _restApiService.getRequest(endpoint);
  }

  Future<Response?> postRequest({required String apiEndpoint, required Map<String, dynamic> variable}) async {
    return await _restApiService.postRequest(apiEndpoint, variable);
  }

  Future<Response?> putRequest({required String apiEndpoint,Map<String, dynamic>? variable}) async {
    return await _restApiService.put(apiEndpoint, variable);
  }
}
