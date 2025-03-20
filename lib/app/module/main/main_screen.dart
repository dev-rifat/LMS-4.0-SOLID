import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_string.dart';
import '../../../utils/app_style.dart';
import '../../../utils/dimensions.dart';
import '../../global/view/widget/custom_dialog_layout.dart';
import '../add_to_cart/view/screen/wishlist_screen.dart';
import '../enrolled_crouse/view/screen/my_cource/my_crouse.dart';
import '../home/view/screen/home_screen.dart';
import '../notification/view/screen/notification.dart';

class MainScreen extends StatefulWidget {
  final int? routeIndex;
  const MainScreen({Key? key, this.routeIndex = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.routeIndex ?? 0;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    AddToCartScreen(),
    const NotificationScreen(),
    const PurchasedCoursesPage(),
  ];

  void _onBottomNavItemTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: _screens[currentIndex],
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.hintColor.withOpacity(0.8),
      type: BottomNavigationBarType.fixed,
      selectedFontSize: Dimensions.fontSizeDefault - 1,
      unselectedFontSize: Dimensions.fontSizeDefault - 1,
      showUnselectedLabels: true,
      items: _getBottomNavigationBarItems(),
      elevation: 3,
      backgroundColor: AppColor.backgroundColor,
      currentIndex: currentIndex,
      onTap: _onBottomNavItemTap,
    );
  }

  List<BottomNavigationBarItem> _getBottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        activeIcon: Icon(CupertinoIcons.house_fill),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_outlined),
        activeIcon: Icon(Icons.shopping_cart_rounded),
        label: "Cart",
      ),
      BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bell),
        activeIcon: Icon(CupertinoIcons.bell_fill),
        label: "Notification",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.my_library_books_outlined),
        activeIcon: Icon(Icons.my_library_books_rounded),
        label: "My course",
      ),
    ];
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showCustomDialogWithResult(context);
  }

  Future<bool> showCustomDialogWithResult(BuildContext context) async {
    bool shouldLogout = false;
    showCustomDialog(
      context: context,
      titleText: "Are you sure?",
      iconWidget: const Icon(Icons.logout, color: AppColor.errorColor, size: 34),
      titleTextStyle: AppStyle.normal_text_black
          .copyWith(color: AppColor.normalTextColor, fontSize: 22),
      descriptionTextStyle: AppStyle.normal_text_black
          .copyWith(color: AppColor.normalTextColor.withOpacity(0.8)),
      btnWidget: _btnLayout((logoutConfirmed) {
        shouldLogout = logoutConfirmed;
      }),
      descriptionText: "Are you sure you want to exit the app?",
    );
    return shouldLogout;
  }

  Widget _btnLayout(Function(bool) onLogoutConfirmed) {
    return Row(
      children: [
        const Spacer(),
        TextButton(
          onPressed: () {
            onLogoutConfirmed(false);
            Get.back();
          },
          child: Text(
            AppString.text_cancel.tr,
            style: AppStyle.normal_text_black.copyWith(
                color: AppColor.normalTextColor, fontWeight: FontWeight.w600),
          ),
        ),
        TextButton(
          onPressed: () {
            onLogoutConfirmed(true);
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
          child: Text(
            "Yes",
            style: AppStyle.normal_text_black.copyWith(
                color: AppColor.errorColor, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
