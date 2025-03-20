import 'dart:developer';
import 'package:get/get_connect/http/src/response/response.dart';
import '../services/auth_services.dart';

abstract class AuthRepository {
  Future<Response?> login({required String phoneNumber, required String password});
  Future<Response?> signUp(
      {required String name,
      required String email,
      required String phoneNumber,
      required String password,
      required String confPassword});
  Future<Response?> forgotPassword({required String email});
}

class AuthImplement implements AuthRepository {
  final AuthApiService _apiService;
  AuthImplement(this._apiService);

  @override
  Future<Response?> login(
      {required String phoneNumber, required String password}) async {
    try {
      final response = await _apiService.signIn(phoneNumber, password);
      return response;
    } catch (e) {
      log("AuthRepository Login Error: $e");
      return null;
    }
  }

  @override
  Future<Response?> forgotPassword({required String email}) async {
    try {
      final response = await _apiService.forgotPassword(email);

      print("forgot_password: ${response?.body.toString()}");
      return response;
    } catch (e) {
      log("AuthRepository forgotPassword Error: $e");
      return null;
    }
  }



  @override
  Future<Response?> signUp(
      {required String name,
      required String email,
      required String phoneNumber,
      required String password,
      required String confPassword}) async {
    try {
      return await _apiService.signUp(
          name, email, phoneNumber, password, confPassword);
    } catch (e) {
      log("AuthRepository signup Error: $e");
    }
    return null;
  }
}
