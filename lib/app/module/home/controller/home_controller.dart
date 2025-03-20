import 'dart:developer';
import 'package:get/get.dart';
import 'package:lms_0_3/app/module/home/models/catrgory_model.dart';
import '../models/category_with_product_model.dart';
import '../models/cource_details_model.dart';
import '../models/cource_list_model.dart';
import '../models/cuopon_list_model.dart';
import '../models/feture_class_list_model.dart';
import '../models/payment_history.dart';
import '../models/search_model.dart';
import '../models/user_coupon_model.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController with StateMixin {
  final HomeRepository _homeRepository;
  HomeController(this._homeRepository);

  @override
  void onInit() async {
    await getCategory();
    await getFeatureClassList();
    await getCourseList();
    super.onInit();
  }

  RxBool isFeatureClassLoading = false.obs;
  RxBool isLatestBundleLoading = false.obs;
  RxBool isCategoryWithLoading = false.obs;
  RxBool isCouponLoading = false.obs;
  RxBool isUserCouponLoading = false.obs;
  RxBool isUseCoupon = false.obs;
  RxBool isAddCourseLoading = false.obs;
  RxBool isEnrolCourse = false.obs;
  RxBool isPaymentHistoryLoading = false.obs;
  RxInt isSelectCategory = 0.obs;
  String viewAllString = "Search";
  RxString isSelectCategoryId = "1".obs;
  RxString isSelectCategoryName = "".obs;

  CourseListModel? courseListModel;
  CategoriesModel? categoriesModel;
  Rx<CouponListModel>? couponListModel;
  FeatureClassesListModel? featureClassesListModel;
  SearchModel? searchModel;
  CourseDetailsModel? courseDetailsModel;
  UserCouponModel? userCouponModel;
  PaymentHistoryModel? paymentHistoryModel;
  CategoryWithProduct? categoryWithProduct;


  Future getCategory() async {
    change(null, status: RxStatus.loading());
    try{
      categoriesModel = await _homeRepository.getCategory();

    }catch(e){
      log("getCategory: $e");
    }
    change(null, status: RxStatus.success());
  }

  Future getPaymentHistoryList() async {
    isPaymentHistoryLoading(true);
    try{
      paymentHistoryModel = await _homeRepository.getPaymentHistoryList();

    }catch(e){
      log("getPaymentHistoryList: $e");
    }
    isPaymentHistoryLoading(false);

  }
   Future getCategoryWithCourse(String id) async {
     isCategoryWithLoading(true);
    try{
      categoryWithProduct = await _homeRepository.getCategoryWithCourse(id);

    }catch(e){
      log("getCategoryWithCourse: $e");
    }
     isCategoryWithLoading(false);
  }


  Future getCouponList() async {
    change(null, status: RxStatus.loading());
    try{
      couponListModel?.value =
          (await _homeRepository.getCouponList()) ?? CouponListModel();
    }catch(e){
      log("getCouponList: $e");
    }


    change(null, status: RxStatus.success());
  }

  Future getSearchList({String? query}) async {
    change(null, status: RxStatus.loading());

    try{
      searchModel = (await _homeRepository.getSearchList(query ?? ""));

    }catch(e){
      log("getSearchList: $e");
    }
    change(null, status: RxStatus.success());
  }

  Future getCourseDetailsList({required String id}) async {


    change(null, status: RxStatus.loading());
    try{
      courseDetailsModel = (await _homeRepository.getCourseDetailsList(id));

    }catch(e){
      log("getCourseDetailsList: $e");
    }
    change(null, status: RxStatus.success());
  }

  Future getCourseList() async {
    change(null, status: RxStatus.loading());
    try{
      courseListModel = (await _homeRepository.getCourse());

    }catch(e){
      log("getCourseList: $e");
    }
    change(null, status: RxStatus.success());
  }

  Future getFeatureClassList() async {
    change(null, status: RxStatus.loading());
    try{
      featureClassesListModel = (await _homeRepository.getFeatureClassList());

    }catch(e){
      log("getFeatureClassList: $e");
    }
    change(null, status: RxStatus.success());
  }

}
