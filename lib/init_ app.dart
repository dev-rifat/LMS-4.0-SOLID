import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';
import 'app/module/add_to_cart/hive/hive_object.dart';


Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
 initHive();
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));
}

Future initHive() async {
  // Initialize Hive and open a box
  await Hive.initFlutter();
  // Register the adapter for your custom object
  Hive.registerAdapter(AddToCartItemAdapter());
  // Open a box
  await Hive.openBox<AddToCartItem>(wishListTableKey);
}

