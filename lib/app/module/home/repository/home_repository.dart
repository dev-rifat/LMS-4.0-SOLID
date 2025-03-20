import 'dart:developer';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_0_3/app/module/home/services/home_services.dart';
import '../models/category_with_product_model.dart';
import '../models/catrgory_model.dart';
import '../models/cource_details_model.dart';
import '../models/cource_list_model.dart';
import '../models/cuopon_list_model.dart';
import '../models/feture_class_list_model.dart';
import '../models/payment_history.dart';
import '../models/search_model.dart';

abstract class HomeRepository{
 Future<CategoriesModel?> getCategory();
 Future<CourseListModel?> getCourse();
 Future<CouponListModel?> getCouponList();
 Future<SearchModel?> getSearchList(String query);
 Future<FeatureClassesListModel?> getFeatureClassList();
 Future<CourseDetailsModel?> getCourseDetailsList(String id);
 Future<CategoryWithProduct?> getCategoryWithCourse(String id);
 Future<PaymentHistoryModel?> getPaymentHistoryList();
}



class HomeImplement implements HomeRepository{
final  HomeApiService _homeApiService;
   HomeImplement(this._homeApiService);

  @override
  Future<CategoriesModel?> getCategory() async{
    try{
      Response? response=await  _homeApiService.getCategory();
      print("getCategory: ${response?.body}");
      if(response?.statusCode==200){
        return CategoriesModel.fromJson(response?.body);
      }
    }catch(e){
      log("getCategory error $e");
    }
    return null;
  }


  @override
  Future<PaymentHistoryModel?> getPaymentHistoryList() async{
    try{
      Response? response=await  _homeApiService.getPaymentHistoryList();
      print("getPaymentHistoryList: ${response?.body}");
      if(response?.statusCode==200){
        return PaymentHistoryModel.fromJson(response?.body);
      }
    }catch(e){
      log("getCategory error $e");
    }
    return null;
  }

   @override
  Future<CategoryWithProduct?> getCategoryWithCourse(String id) async{
    try{
      Response? response=await  _homeApiService.getCategoryWithCourse(id);
      print("getCategoryWithCourse: ${response?.body}");
      if(response?.statusCode==200){
        return CategoryWithProduct.fromJson(response?.body);
      }
    }catch(e){
      log("getCategory error $e");
    }
    return null;
  }




   @override
  Future<CourseListModel?> getCourse() async{
    Response? response=await  _homeApiService.getCourse();
    print("getCourse: ${response?.body}");

    if(response?.statusCode==200){
      return CourseListModel.fromJson(response?.body);
    }
    return null;
  }

  @override
  Future<CourseDetailsModel?> getCourseDetailsList(String id) async{
    Response? response=await  _homeApiService.getCourseDetailsList(id);
    print("getCourseDetailsList: ${response?.body}");
    if(response?.statusCode==200){
      return CourseDetailsModel.fromJson(response?.body);
    }
    return null;
  }



   @override
  Future<FeatureClassesListModel?> getFeatureClassList() async{
    Response? response=await  _homeApiService.getFeatureClassList();
    print("getFeatureClassList: ${response?.body}");

    if(response?.statusCode==200){
      return FeatureClassesListModel.fromJson(response?.body);
    }
    return null;
  }



   @override
  Future<CouponListModel?> getCouponList() async{
    Response? response=await  _homeApiService.getCouponList();
    print("getCouponList: ${response?.body}");

    if(response?.statusCode==200){
      return CouponListModel.fromJson(response?.body);
    }
    return null;
  }



@override
Future<SearchModel?> getSearchList(String query) async{
  Response? response=await  _homeApiService.getSearchList(query);
  print("getSearchList: ${response?.body}");

  if(response?.statusCode==200){
    return SearchModel.fromJson(response?.body);
  }
  return null;
}



}