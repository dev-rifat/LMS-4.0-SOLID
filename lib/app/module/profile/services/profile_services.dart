import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_0_3/app/global/services/services.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';
import '../../../../utils/app_string.dart';
import 'package:http/http.dart' as http;

class ProfileApiService {
  final ApiService _apiService;
  ProfileApiService(this._apiService);

  Future<Response?> updatedProfile(String name, String email, String phoneNumber) async {
    Map<String, dynamic> variable =  {
    "name":name,
    "email": email,
    "phone_number":phoneNumber,
    "latitude": "",
    "longitude": ""};
    try {
      final response = await _apiService.postRequest(apiEndpoint: Api.updateProfile, variable: variable);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> changePassword(String currentPassword, String newPassword,String confirmPass) async {
    Map<String, dynamic> variable = {
      "old_password": currentPassword,
      "new_password": newPassword,
      "new_password_confirmation": confirmPass,
    };
    try {
      final response = await _apiService.postRequest(apiEndpoint: Api.changePassword, variable: variable);

      return response;
    } catch (e) {
      return null;
    }
  }




  Future<Response?> getProfile() async {
    try {
      final response = await _apiService.getRequest(Api.showProfile);
      return response;
    } catch (e) {
      return null;
    }
  }




  Future<http.StreamedResponse?> changeProfileImage(XFile image) async {
    try {
      var url = Uri.parse(Api.BASE_URL + Api.updateProfileImg);
      var headers = {
        'Authorization': 'Bearer ${GetStorage().read(AppString.ACCESS_TOKEN)}',
      };

      http.MultipartRequest request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      http.StreamedResponse response = await request.send();
      return response;
    } catch (e) {
      return null;
    }
  }

}

