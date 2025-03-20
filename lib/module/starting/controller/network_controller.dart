import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app/global/view/screen/netwotk_error_screen.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_string.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  var isConnected = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    checkInitialConnection();
    _listenToConnectivityChanges();

    // Trigger navigation based on connection status
    ever<bool>(isConnected, (connected) {
      connected ? _navigateToNextScreen() : Get.to(()=>NetworkErrorScreen());
    });
  }

  void checkInitialConnection() async {
    isConnected.value = !(await Connectivity().checkConnectivity()).contains(ConnectivityResult.none);
  }

  void _listenToConnectivityChanges() {
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((results) {
      isConnected.value = !results.contains(ConnectivityResult.none);
      _showSnackbar(
        isConnected.value ? "Online! You are now connected." : "No Internet. Please check your connection.",
        isConnected.value ? Colors.green : Colors.red,
      );
    });
  }

  void _showSnackbar(String message, Color color) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offAllNamed(box.hasData(AppString.ACCESS_TOKEN) ? Routes.MAIN : Routes.SIGN_IN);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
