part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const MAIN = _Paths.MAIN;
  static const FAVORITE = _Paths.FAVORITE;
  static const PROFILE = _Paths.PROFILE;
  static const VIEW_ALL = _Paths.VIEW_ALL;
  static const SEARCH_SCREEN = _Paths.SEARCH_SCREEN;
  static const NOTIFICATION_SCREEN = _Paths.NOTIFICATION_SCREEN;
  static const MY_CART_SCREEN = _Paths.MY_CART_SCREEN;
  static const PAYMENT_METHOD_SCREEN = _Paths.PAYMENT_METHOD_SCREEN;
  static const ADD_PAYMENT_METHOD = _Paths.ADD_PAYMENT_METHOD;
  static const MY_REVIEW = _Paths.MY_REVIEW;
  static const WRITE_REVIEW_SCREEN = _Paths.WRITE_REVIEW_SCREEN;
  static const MY_PRIFILE = _Paths.MY_PRIFILE;
  static const EDIT_PROFILE_SCREEN = _Paths.EDIT_PROFILE_SCREEN;
  static const CHNAGE_PASSWORD = _Paths.CHNAGE_PASSWORD;
  static const SELECT_PAY_METHOD = _Paths.SELECT_PAY_METHOD;
  static const NO_INTERNET_SCREEN = _Paths.NO_INTERNET_SCREEN;
  static const PAYMENT_HISTORY_SCREEN = _Paths.PAYMENT_HISTORY_SCREEN;
  static const CATEGORY_WITH_PRODUCT = _Paths.CATEGORY_WITH_PRODUCT;
  static const CHAPTER_DETAILS = _Paths.CHAPTER_DETAILS;
  static const CHAPTER_SCREEN = _Paths.CHAPTER_SCREEN;
  static const COMMENT_SCREEN = _Paths.COMMENT_SCREEN;
  static const LESSON_SCREEN = _Paths.LESSON_SCREEN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const QUIZE_SCREEN = _Paths.QUIZE_SCREEN;


}

abstract class _Paths {
  _Paths._();

  static const SPLASH_SCREEN = '/splash-screen';
  static const SIGN_IN = '/signIn-screen';
  static const SIGN_UP = '/signUp-screen';
  static const MAIN = "/main_screen";
  static const FAVORITE = "/favorite_screen";
  static const PROFILE = "/profile_screen";
  static const CHNAGE_PASSWORD = "/change_pass_view_screen";
  static const VIEW_ALL = "/view_all_screen";
  static const SEARCH_SCREEN = "/search_screen";
  static const PAYMENT_HISTORY_SCREEN = "/payment_history_screen";
  static const NOTIFICATION_SCREEN = "/notification_screen";
  static const MY_CART_SCREEN = "/my_cart_screen";
  static const PAYMENT_METHOD_SCREEN= "/payment_method_screen_v";
  static const ADD_PAYMENT_METHOD= "/add_payment_method_screen";
  static const MY_REVIEW= "/my_review_screen";
  static const WRITE_REVIEW_SCREEN= "/write_review_screen";
  static const MY_PRIFILE= "/my_profile_screen";
  static const EDIT_PROFILE_SCREEN= "/edit_profile_screen";
  static const SELECT_PAY_METHOD= "/select_pay_method_screen";
  static const NO_INTERNET_SCREEN= "/no_internet_method_screen";
  static const LESSON_SCREEN= "/lesson_screen";
  static const FORGOT_PASSWORD= "/forgot_password_screen";
  static const CATEGORY_WITH_PRODUCT= "/category_with_screen";
  static const CHAPTER_DETAILS= "/chapter_details_with_screen";
  static const CHAPTER_SCREEN= "/chapter_screen_with_screen";
  static const COMMENT_SCREEN= "/comment_screen_with_screen";
  static const QUIZE_SCREEN= "/quiz_screen";

}
