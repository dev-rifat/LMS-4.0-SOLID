import 'package:get/get.dart';
import 'package:lms_0_3/app/global/services/services.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';

class HomeApiService{
 final ApiService _apiService;
  HomeApiService(this._apiService);

 Future<Response?> getCategory() async{
   Response? response=await _apiService.getRequest(Api.categoryList);
   return response;
  }




  Future<Response?> getCourse() async{
   Response? response=await _apiService.getRequest(Api.courseList);
   return response;
  }

    Future<Response?> getCouponList() async{
   Response? response=await _apiService.getRequest(Api.couponList);
   return response;
  }

  Future<Response?> getSearchList(String query) async{
   Response? response=await _apiService.getRequest("${Api.courseSearch}$query",);
   return response;
  }

  Future<Response?> getUserCoupon() async{
   Response? response=await _apiService.getRequest(Api.userCoupon,);
   return response;
  }

  Future<Response?> getCourseDetailsList(String id) async{
   Response? response=await _apiService.getRequest(Api.courseListDetails + id,);
   return response;
  }

  Future<Response?> getCategoryWithCourse(String id) async{
   Response? response=await _apiService.getRequest(Api.categoryWithList + id,);
   return response;
  }

 Future<Response?> getPaymentHistoryList() async{
   Response? response=await _apiService.getRequest(Api.paymentHistory,);
   return response;
 }
 Future<Response?> getFeatureClassList() async{
   Response? response=await _apiService.getRequest(Api.featureClass,);
   return response;
 }



 Future<Response?> addCourse(String id,String coupon,String price) async{
   Map<String, dynamic> variable = {
     "course_id": id,
     "coupon": coupon,
     "price": price
   };
   Response? response=await _apiService.postRequest(apiEndpoint: Api.paymentHistory,variable:variable );
   return response;
 }





}


