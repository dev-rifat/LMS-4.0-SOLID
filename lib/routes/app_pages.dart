import 'package:get/get.dart';
import '../app/global/view/screen/unauthenticated.dart';
import '../app/module/add_to_cart/view/screen/wishlist_screen.dart';
import '../app/module/auth/view/screen/forgot_password.dart';
import '../app/module/auth/view/screen/sign_in.dart';
import '../app/module/auth/view/screen/sign_up.dart';
import '../app/module/enrolled_crouse/view/screen/chapter/chapter.dart';
import '../app/module/enrolled_crouse/view/screen/chapter/chapter_details.dart';
import '../app/module/enrolled_crouse/view/widget/lesson_list/lesson.dart';
import '../app/module/enrolled_crouse/view/widget/chapter/videos/comment_screen.dart';
import '../app/module/enrolled_crouse/view/widget/quiz/quiz.dart';
import '../app/module/home/view/screen/search_screen.dart';
import '../app/module/home/view/widget/category_with_product.dart';
import '../app/module/home/view/widget/details/payment_history.dart';
import '../app/module/main/drawer_main/drawer_screen.dart';
import '../app/module/notification/view/screen/notification.dart';
import '../app/module/profile/view/screen/change_password.dart';
import '../app/module/profile/view/screen/edit_profile.dart';
import '../module/starting/view/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;
  static final routes = [


      GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => const SplashScreen(),
      ),


    GetPage(
      name: _Paths.SEARCH_SCREEN,
      page: () => const SearchScreen(),
    ),

    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpScreen(),
    ),


      GetPage(
        name: _Paths.MAIN,
        page: () => const ZoomMainDrawer(),
      ),



    GetPage(
      name: _Paths.CHAPTER_DETAILS,
      page: () => ChapterDetails(),
    ),  GetPage(
      name: _Paths.CHAPTER_SCREEN,
      page: () => ChapterListScreen(),
    ),

    GetPage(
      name: _Paths.NO_INTERNET_SCREEN,
      page: () => const Unauthenticated(),

    ),


  GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () =>  ForgotPasswordScreen(),

    ),


    GetPage(
      name: _Paths.CATEGORY_WITH_PRODUCT,
      page: () => const CategoryWithProduct(),
    ),
  GetPage(
      name: _Paths.QUIZE_SCREEN,
      page: () => const QuizScreen(),
    ),


    GetPage(
      name: _Paths.COMMENT_SCREEN,
      page: () =>  CommentsScreen(),
    ),
  GetPage(
      name: _Paths.PAYMENT_HISTORY_SCREEN,
      page: () =>  const PaymentHistoryScreen(),
    ),


    GetPage(
      name: _Paths.SIGN_IN,
      transition: Transition.native,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: _Paths.CHNAGE_PASSWORD,
      transition: Transition.native,
      page: () => ChangePassword(),
    ),
    GetPage(
      name: _Paths.FAVORITE,
      transition: Transition.native,
      page: () => AddToCartScreen(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SCREEN,
      transition: Transition.size,
      page: () => const NotificationScreen(),
    ),

    GetPage(
      name: _Paths.EDIT_PROFILE_SCREEN,
      page: () =>  const EditProfileScreen(),
    ),

  ];
}
