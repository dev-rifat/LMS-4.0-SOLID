import 'dart:convert';

import 'package:get/get.dart';
import 'package:lms_0_3/app/global/services/services.dart';
import 'package:lms_0_3/utils/api_endpoints.dart';

class EnrolledApiService {
 final ApiService _apiService;
 EnrolledApiService(this._apiService);


 Future<Response?> getMyCourse() async{
   Response? response=await _apiService.getRequest(Api.myCourse);
   return response;
 }
 Future<Response?> getChapter(String id ) async{
   Response? response=await _apiService.getRequest(Api.chapterList+id);
   return response;
 }

 Future<Response?> getModules(String id) async{
   print("getModules_id: $id");
   Response? response=await _apiService.getRequest(Api.modules+id);
   return response;
 }

 Future<Response?> getChapterDetails(String id ) async{
   Response? response=await _apiService.getRequest(Api.lessonWithDetails+id);
   return response;
 }


 Future<Response?> getMyComment(String id ) async{
   Response? response=await _apiService.getRequest(Api.myComment+id);
   return response;
 }

 Future<Response?> getLesson(String id ) async{
   Response? response=await _apiService.getRequest(Api.lesson+id);
   return response;
 }

 Future<Response?> getQuestion(String id ) async{
   Response? response=await _apiService.getRequest(Api.question+id);
   print("getQuestion:::::: ${response?.body}");
   return response;
 }

 Future<Response?> addPaypalPayment(Map<String, dynamic> variable) async {
   print("variable_paypal: $variable");

   // Extracting data dynamically
   final Map<String, dynamic> formattedRequestData = {
     "onSuccess": {
       "payerID": variable["payerID"],
       "paymentId": variable["paymentId"],
       "token": variable["token"],
       "status": variable["status"],
       "data": {
         "id": variable["data"]["id"],
         "intent": variable["data"]["intent"],
         "state": variable["data"]["state"],
         "cart": variable["data"]["cart"],
         "payer": {
           "payment_method": variable["data"]["payer"]["payment_method"],
           "status": variable["data"]["payer"]["status"],
           "payer_info": {
             "email": variable["data"]["payer"]["payer_info"]["email"],
             "first_name": variable["data"]["payer"]["payer_info"]["first_name"],
             "last_name": variable["data"]["payer"]["payer_info"]["last_name"],
             "payer_id": variable["data"]["payer"]["payer_info"]["payer_id"],
             "shipping_address": {
               "recipient_name": variable["data"]["payer"]["payer_info"]["shipping_address"]["recipient_name"],
               "line1": variable["data"]["payer"]["payer_info"]["shipping_address"]["line1"],
               "city": variable["data"]["payer"]["payer_info"]["shipping_address"]["city"],
               "state": variable["data"]["payer"]["payer_info"]["shipping_address"]["state"],
               "postal_code": variable["data"]["payer"]["payer_info"]["shipping_address"]["postal_code"],
               "country_code": variable["data"]["payer"]["payer_info"]["shipping_address"]["country_code"]
             }
           }
         },
         "transactions": List<Map<String, dynamic>>.from(variable["data"]["transactions"].map((transaction) => {
           "amount": {
             "total": transaction["amount"]["total"],
             "currency": transaction["amount"]["currency"],
             "details": transaction["amount"]["details"]
           },
           "payee": {
             "merchant_id": transaction["payee"]["merchant_id"],
             "email": transaction["payee"]["email"]
           },
           "description": transaction["description"],
           "item_list": {
             "items": List<Map<String, dynamic>>.from(transaction["item_list"]["items"].map((item) => {
               "name": item["name"].toString(),  // Ensure it's a string
               "price": item["price"],
               "currency": item["currency"],
               "tax": item["tax"],
               "quantity": item["quantity"],
               "image_url": item["image_url"] ?? ""
             })),
             "shipping_address": {
               "recipient_name": transaction["item_list"]["shipping_address"]["recipient_name"],
               "line1": transaction["item_list"]["shipping_address"]["line1"],
               "city": transaction["item_list"]["shipping_address"]["city"]
             }
           }
         }))
       }
     }
   };

   print("formattedRequestData: $formattedRequestData");

   Response? response = await _apiService.postRequest(apiEndpoint: Api.addPaymentPaypal, variable: formattedRequestData);
   return response;
 }

 Future<Response?> addVideoStatus(String id ) async{
   Map<String, dynamic> variable = {
     "course_video_id": id,
   };
   Response? response=await _apiService.putRequest(apiEndpoint: Api.chapterDetails+id,variable:variable);
   return response;
 }
 Future<Response?> addComment(String id,String comment) async{
   Map<String, dynamic> variable = {
     "course_id": id,
     "comment": comment,
   };
   Response? response=await _apiService.postRequest(apiEndpoint: Api.addComment,variable:variable);
   return response;
 }

 Future<Response?> addCourse(String id,String coupon,String price) async{
   Map<String, dynamic> variable = {
     "course_id": id,
     "coupon": coupon,
     "price": price
   };
   Response? response=await _apiService.postRequest(apiEndpoint: Api.addCourse,variable:variable);
   return response;
 }

 Future submitQuestion(int examId,int userId,List answer) async{
  Map<String, Object> variable = {
      "exam_id": examId,
      "user_id": userId,
      "answers": answer
  };
   Response? response=await _apiService.postRequest(apiEndpoint: Api.submitQuestion,variable:variable);
   return response;
 }

 Future<Response?> myCertificate() async{
   Response? response=await _apiService.getRequest(Api.myCertificate);
   return response;
 }
}
