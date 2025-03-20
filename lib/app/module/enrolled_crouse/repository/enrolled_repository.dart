import 'dart:developer';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../../global/view/widget/error_message.dart';
import '../models/certificate_model.dart';
import '../models/chapter_details.dart';
import '../models/chpater_list_model.dart';
import '../models/comment_model.dart';
import '../models/lesson_model.dart';
import '../models/modules_model.dart';
import '../models/my_crouse_modle.dart';
import '../models/question_model.dart';
import '../services/enrolled_services.dart';

abstract class EnrolledDataSource{
  Future<MyCourseModel?> getMyCourse();
  Future<ChapterListModel?> getChapter(String id);
  Future<ChapterDetailsModel?> getChapterDetails(String id);
  Future<CommentModel?> getMyComment(String id);
  Future addVideoStatus(String id);
  Future addComment(String id,String comment);
  Future addCourse(String id,String coupon,String price);
  Future<LessonModel?> getLesson(String id);
  Future<ModuleModel?> getModules(String id);
  Future addPaypalPayemnt(Map<String, dynamic> variable);
  Future<QuestionModel?> getQuestion(String id);
  Future<CertificateModel?> myCertificate();
  Future<Response> submitQuestion({required int examId, required int userId, required List answer});
}

class EnrolledImplement implements EnrolledDataSource{
final  EnrolledApiService _enrolledApiService;
EnrolledImplement(this._enrolledApiService);



@override
Future<MyCourseModel?> getMyCourse() async{
  try{
    Response? response=await  _enrolledApiService.getMyCourse();
    print(response?.body);
    if(response?.statusCode==200 && response !=null){
      return MyCourseModel.fromJson(response.body);
    }
  }catch(e){
    log("getMyCourse error $e");
  }
  return null;
}


@override
Future<ModuleModel?> getModules(String id) async{
  try{
    Response? response=await  _enrolledApiService.getModules(id);
    print("getModules: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
      return ModuleModel.fromJson(response.body);
    }
  }catch(e){
    log("getModules error $e");
  }
  return null;
}



@override
Future<ChapterListModel?> getChapter(String id) async{
  try{
    Response? response=await  _enrolledApiService.getChapter(id);
    print("getChapter: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
      return ChapterListModel.fromJson(response.body);
    }
  }catch(e){
    log("getChapter error $e");
  }
  return null;
}




@override
Future<ChapterDetailsModel?> getChapterDetails(String id) async{
  try{
    Response? response=await  _enrolledApiService.getChapterDetails(id);
    log("getChapterDetails: ${response?.body}");

    if(response?.statusCode==200 && response !=null){
      return ChapterDetailsModel.fromJson(response.body);
    }
  }catch(e){
    log("getChapterDetails error $e");
  }
  return null;
}




@override
Future<CommentModel?> getMyComment(String id) async{
  try{
    Response? response=await  _enrolledApiService.getMyComment(id);
    if(response?.statusCode==200 && response !=null){
      return CommentModel.fromJson(response.body);
    }
  }catch(e){
    log("getMyComment error $e");
  }
  return null;
}

@override
Future<LessonModel?> getLesson(String id) async{
  try{
    Response? response=await  _enrolledApiService.getLesson(id);
    print("getLesson: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
      return LessonModel.fromJson(response.body);
    }
  }catch(e){
    log("getMyComment error $e");
  }
  return null;
}
@override
Future<QuestionModel?> getQuestion(String id) async{
  try{
    Response? response=await  _enrolledApiService.getQuestion(id);
    if(response?.statusCode==200 && response !=null && response.body["exam"] !=null){
      return QuestionModel.fromJson(response.body);
    }else{
      return QuestionModel();
    }
  }catch(e){
    log("getQuestion error $e");
  }
  return null;
}

@override
Future<CertificateModel?> myCertificate() async{
  try{
    Response? response=await  _enrolledApiService.myCertificate();
    print("myCertificate: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
      return CertificateModel.fromJson(response.body);
    }
  }catch(e){
    log("myCertificate error $e");
  }
  return null;
}

@override
Future addPaypalPayemnt(Map<String, dynamic> variable) async{
  print("addPaypalPayemnt_called");
  try{
    return await  _enrolledApiService.addPaypalPayment(variable);

  }catch(e){
    log("addPaypalPayemnt error $e");
  }
  return null;
}



@override
Future addVideoStatus(String id) async{
  try{
    Response? response=await  _enrolledApiService.addVideoStatus(id);
    print("addVideoStatus: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
     return response.body;
   }
  }catch(e){
    log("addVideoStatus error $e");
  }
  return null;
}

@override
Future<Response> addComment(String id, String comment) async {
  try {
    Response? response = await _enrolledApiService.addComment(id, comment);
    if (response != null && (response.statusCode == 200||response.statusCode == 201)) {
      return response; // Return the full Response object
    } else {
      throw Exception("Failed to add comment: ${response?.body}");
    }
  } catch (e) {
    log("addComment error: $e");
    rethrow; // Rethrow the exception to be handled by the caller
  }
}

@override
Future addCourse(String id,String coupon,String price) async{
  try{
    Response? response=await  _enrolledApiService.addCourse(id,coupon,price);
    print("addCourse: ${response?.body}");
    if(response?.statusCode==200 && response !=null){
     return response.body;
   }else{
      showErrorMessage(message: response?.body["error"]);
      showErrorMessage(message: response?.body["message:"]);

    }
  }catch(e){
    log("addCourse error $e");
  }
  return null;
}










@override
Future<Response> submitQuestion({required int examId, required int userId, required List answer}) async {
  try {
    Response? response=await  _enrolledApiService.submitQuestion( examId, userId, answer);
    if (response != null && (response.statusCode == 200||response.statusCode == 201)) {
      return response; // Return the full Response object
    } else {
      throw Exception("Failed to add submitQuestion: ${response?.body}");
    }
  } catch (e) {
    log("submitQuestion error: $e");
    rethrow; // Rethrow the exception to be handled by the caller
  }
}







}


