import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/routes/app_pages.dart';
import 'package:lms_0_3/utils/theme.dart';
import 'app/global/bindings/global_bindings.dart';
import 'init_ app.dart';


void main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialBinding: GlobalBindings(),
      locale: const Locale("en", "US"),
      fallbackLocale: const Locale("en", "US"),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
