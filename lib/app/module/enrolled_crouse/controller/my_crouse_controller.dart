import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/global/view/widget/error_message.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/repository/enrolled_repository.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/logger.dart';
import '../../../global/view/widget/success_message.dart';
import '../../add_to_cart/controller/wishlist_controller.dart';
import '../../home/controller/home_controller.dart';
import '../models/certificate_model.dart';
import '../models/chpater_list_model.dart';
import '../models/lesson_model.dart';
import '../models/modules_model.dart';
import '../models/my_crouse_modle.dart';

class MyCourseController extends GetxController with StateMixin {
  final EnrolledDataSource _enrolledRepository;
  MyCourseController(this._enrolledRepository);

  Rx<MyCourseModel> myCourseModel = MyCourseModel().obs;
  ChapterListModel? chapterListModel;
  LessonModel? lessonModel;
  CertificateModel? certificateModel;
  ModuleModel? moduleModel;
  RxString lessonId = "".obs;
  final isAddCourseLoading = false.obs;
  final isAddPaymentLoading = false.obs;
  final isEnrolCourse = false.obs;
  final isLoadingMyCourse = false.obs;
  final isLoadingChapter = false.obs;
  final isLessonChapter = false.obs;
  final isCertificateLoading = false.obs;
  final isModuleLoading = false.obs;

  RxString courseId = "".obs;
  RxString chapterDetailsId = "".obs;

  Future getMyCourse() async {
    change(null, status: RxStatus.loading());
    try {
      myCourseModel.value =
          await _enrolledRepository.getMyCourse() ?? MyCourseModel();
    } catch (e) {
      log("getMyCourse : $e");
      showErrorMessage(message: "Error fetching course data: $e");
    }
    change(null, status: RxStatus.success());
  }

  Future getLesson(String id) async {
    isLessonChapter(true);
    try {
      lessonModel = await _enrolledRepository.getLesson(id);
    } catch (e) {
      log("getLesson : $e");
      showErrorMessage(message: "Error fetching lesson data: $e");
    } finally {
      isLessonChapter(false);
    }
  }

  Future myCertificate() async {
    isCertificateLoading(true);
    try {
      certificateModel = await _enrolledRepository.myCertificate();
    } catch (e) {
      log("myCertificate : $e");
      showErrorMessage(message: "Error fetching certificate data: $e");
    } finally {
      isCertificateLoading(false);
    }
  }

  Future getModules(String id) async {
    isModuleLoading(true);
    try {
      moduleModel = await _enrolledRepository.getModules(id);
    } catch (e) {
      log("getModules : $e");
      showErrorMessage(message: "Error fetching modules data: $e");
    } finally {
      isModuleLoading(false);
    }
  }

  Future<void> addPaypalPayment(Map<String, dynamic> variable) async {
    isAddPaymentLoading(true);
    try {
      Response response = await _enrolledRepository.addPaypalPayemnt(variable);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.find<MyCourseController>().getMyCourse();
        Get.find<HomeController>().getCourseList();
        showSuccessMessage(message: response.body["message"] ?? "Payment successful");
      } else {
        showErrorMessage(message: response.body["error"] ?? "Payment failed");
      }
    } catch (e) {
      log("addPaypalPayment : $e");
      showErrorMessage(message: "Error during payment processing: $e");
    } finally {
      isAddPaymentLoading(false);
    }
  }

  Future<void> addCourse(String id, String coupon, String price) async {
    isAddCourseLoading(true);
    try {
      Response response = await _enrolledRepository.addCourse(id, coupon, price);
      if (response.hasError) {
        showErrorMessage(message: response.body["error"]);
        isEnrolCourse(true);
      } else {
        logSuccessMessage(logName: "addCourse", response: response);
        showSuccessMessage(message: response.body["message"]);
        Get.find<WishlistController>().deleteItem(int.parse(id));
        getMyCourse();
        Get.back(canPop: false);
      }
    } catch (e) {
      log("addCourse : $e");
    } finally {
      isAddCourseLoading(false);
    }
  }

  @override
  void onInit() {
    if (GetStorage().read(AppString.ACCESS_TOKEN) != null) {
      getMyCourse();
    }
    super.onInit();
  }
}
