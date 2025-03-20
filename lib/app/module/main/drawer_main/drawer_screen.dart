import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import '../../../../utils/app_color.dart';
import '../../add_to_cart/controller/wishlist_controller.dart';
import '../../profile/profile_bindings/profiile_bindings.dart';
import '../main_screen.dart';
import 'menu_screen.dart';

class ZoomMainDrawer extends StatelessWidget {
  const ZoomMainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    _intApp();
    return  const ZoomDrawer(
      mainScreen: MainScreen(),
      menuScreen: DrawerMenuScreen(),
      menuBackgroundColor: AppColor.primaryColor,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      angle: 0.0,
    );
  }

  void _intApp() {
    Get.put(WishlistController(), permanent: true);
    ProfileBindings().dependencies();
  }
}
