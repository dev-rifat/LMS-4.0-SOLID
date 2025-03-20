import 'package:get/get.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../global/view/widget/error_message.dart';
import '../models/chapter_details.dart';
import '../repository/enrolled_repository.dart';

class CourseDetailsController extends GetxController with StateMixin {
  final EnrolledDataSource _enrolledRepository;
  CourseDetailsController(this._enrolledRepository);

  ChapterDetailsModel? chapterDetailsModel;
  RxBool isLeadingVideoStatus = false.obs;

  Future getChapterDetails(String id) async {
    change(null, status: RxStatus.loading());
    try {
      chapterDetailsModel = await _enrolledRepository.getChapterDetails(id);
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      showErrorMessage(message: "Error loading chapter details: $e");
    }
  }

  Future<void> addVideoStatus(String id) async {
    isLeadingVideoStatus(true);
    try {
      Response response = await _enrolledRepository.addVideoStatus(id);
      if (response.hasError) {
        showErrorMessage(message: response.bodyString.toString());
      } else {
        getChapterDetails(Get.find<MyCourseController>().chapterDetailsId.value);
      }
    } catch (e) {
      showErrorMessage(message: "Error adding video status: $e");
    } finally {
      isLeadingVideoStatus(false);
    }
  }
}
