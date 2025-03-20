import 'package:get/get.dart';
import 'package:lms_0_3/app/global/services/services.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';

class AuthApiService {
  final ApiService _apiService;
  AuthApiService(this._apiService);

  Future<Response?> signUp(String name, String email, String phoneNumber,
      String password, String confPassword) async {
    Map<String, dynamic> variable = {
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      "password": password,
      "password_confirmation": confPassword,
    };

    try {
      final response = await _apiService.postRequest(
          apiEndpoint: Api.resister, variable: variable);
      return response;
    } catch (e) {
      return null;
    }
  }

  Future<Response?> signIn(String phoneNumber, String password) async {
    Map<String, dynamic> variable = {
      "email": phoneNumber,
      "password": password,
    };

    try {
      final response = await _apiService.postRequest(
          apiEndpoint: Api.login, variable: variable);
      return response;
    } catch (e) {
      return null;
    }
  }


  Future<Response?> forgotPassword(String email) async {
    Map<String, dynamic> variable = {
      "email": email,
    };

    try {
      final response = await _apiService.postRequest(
          apiEndpoint: Api.forgotPassword, variable: variable);
      return response;
    } catch (e) {
      print("forgotPassword: $e");
      return null;
    }
  }
}
