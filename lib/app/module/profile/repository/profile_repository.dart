import 'dart:developer';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/src/streamed_response.dart';
import 'package:image_picker/image_picker.dart';
import '../model/profile_model.dart';
import '../services/profile_services.dart';

abstract class ProfileRepository {
  Future<Response?> changePassword({required String currentPassword, required String newPassword,required String confirmPass});
  Future<Response?> updatedProfile({required String name, required String email, required String phoneNumber});
  Future<ProfileModel?> getProfile();
  Future<StreamedResponse?> changeProfileImage({required XFile image});
}

class ProfileImplement implements ProfileRepository {
  final ProfileApiService  _apiService;
  ProfileImplement(this._apiService);

  @override
  Future<Response?> changePassword({required String currentPassword, required String newPassword,required String confirmPass}) async {
    try {
      final response = await _apiService.changePassword( currentPassword,  newPassword, confirmPass);

      return response;
    } catch (e) {
      log("ProfileRepository changePassword Error: $e");
      return null;
    }
  }

  @override
  Future<Response?> updatedProfile({required String name, required String email, required String phoneNumber}) async {
    try {
      return await _apiService.updatedProfile( name,email,phoneNumber);
    } catch (e) {
      log("ProfileRepository updatedProfile Error: $e");
    }
    return null;
  }

    @override
  Future<ProfileModel?> getProfile() async {
    try {
      Response? response= await _apiService.getProfile();
      return ProfileModel.fromJson(response?.body);
    } catch (e) {
      log("ProfileRepository getProfile Error: $e");
    }
    return null;
  }


  @override
  Future<StreamedResponse?> changeProfileImage({required XFile image}) async {
    try {
      return await _apiService.changeProfileImage(image);
    } catch (e) {
      log("ProfileRepository changeProfileImage Error: $e");
    }
    return null;
  }



}
