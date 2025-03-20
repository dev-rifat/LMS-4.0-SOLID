import 'package:get/get.dart';
import '../../../global/view/widget/error_message.dart';
import '../models/chapter_details.dart';
import '../models/comment_model.dart';
import '../repository/enrolled_repository.dart';
import 'my_crouse_controller.dart';

class CommentController extends GetxController with StateMixin {
  final EnrolledDataSource _enrolledRepository;
  CommentController(this._enrolledRepository);

  Rx<CommentModel> commentModel = CommentModel().obs;
  ChapterDetailsModel? chapterDetailsModel;
  RxBool isLoadingAdComment = false.obs;
  RxBool isCommentLoading = false.obs;

  Future getMyComment(String id) async {
    isCommentLoading(true);
    try {
      commentModel.value = await _enrolledRepository.getMyComment(id) ?? CommentModel();
    } catch (e) {
      showErrorMessage(message: "Error loading comment: $e");
    } finally {
      isCommentLoading(false);
    }
  }

  Future<void> addComment(String courseId, String comment) async {
    isLoadingAdComment(true);
    try {
      Response response = await _enrolledRepository.addComment(courseId, comment);
      if (response.hasError) {
        showErrorMessage(message: response.body['error'].toString());
      } else {
        // Refresh the comments after adding a new one
        getMyComment(Get.find<MyCourseController>().courseId.value);
      }
    } catch (e) {
      showErrorMessage(message: "Error adding comment: $e");
    } finally {
      isLoadingAdComment(false);
    }
  }
}
