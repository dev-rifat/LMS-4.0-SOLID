import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/my_crouse_controller.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/logger.dart';
import '../../../global/view/widget/error_message.dart';
import '../../../global/view/widget/success_message.dart';
import '../models/question_model.dart';
import '../repository/enrolled_repository.dart';
import '../view/widget/quiz/quiz_result.dart';

class QuizController extends GetxController {
  final EnrolledDataSource _enrolledRepository;
  QuizController(this._enrolledRepository);
  final isQuestionLoading = false.obs;
  final isQuestionSubLoading = false.obs;

  QuestionModel? questionModel;

  RxInt currentQuestionIndex = 0.obs;
  RxInt selectedAnswer = (-1).obs;
  RxList<Map<String, int>> answers = <Map<String, int>>[].obs;

  void nextQuestion() {
    // Get the question list
    List<Questions>? questionList = questionModel?.exam?.questions;

    // Ensure that the question list is not null or empty
    if (questionList == null || questionList.isEmpty) return;

    // Get the current question based on the index
    Questions currentQuestion = questionList[currentQuestionIndex.value];

    // Check if the selected answer is within bounds
    if (selectedAnswer.value >= 0 &&
        selectedAnswer.value < (currentQuestion.options?.length ?? 0)) {
      // Add the selected answer to the list of answers
      answers.add({
        "question_id": currentQuestion.id ?? 0,
        "selected_option": currentQuestion.options?[selectedAnswer.value].id ?? 0,
      });
    }

    // Check if the current index is valid and if we can move to the next question
    if (currentQuestionIndex.value < questionList.length - 1) {
      // Reset selected answer before moving to the next question
      selectedAnswer.value = -1;

      // Update the index to move to the next question
      currentQuestionIndex.value++;
    } else {
      // If it's the last question, show the results
      Get.off(() => const QuizResultScreen());
    }
  }



  Future getQuestion(String id) async {
    isQuestionLoading(true);
    try {
      questionModel = await _enrolledRepository.getQuestion(id);
    } catch (e) {
      log("getQuestion error: $e");
    } finally {
      isQuestionLoading(false);
    }
  }

  Future submitQuestion(int examId, List answer) async {
    isQuestionSubLoading(true);
    int userId = int.parse(GetStorage().read(AppString.ID_STORE).toString());
    try {
      Response response = await _enrolledRepository.submitQuestion(
        userId: userId,
        examId: examId,
        answer: answer,
      );
      if (response.hasError) {
        showErrorMessage(message: response.body["error"]);
      } else {
        logSuccessMessage(logName: "submitQuestion", response: response);
        showSuccessMessage(message: response.body["message"]);
        Get.back(canPop: false);
        Get.find<QuizController>().questionModel?.exam?.questions?.clear();
        getQuestion(Get.find<MyCourseController>().chapterDetailsId.value);
        currentQuestionIndex(0);
        selectedAnswer(-1);
      }
    } catch (e) {
      log("submitQuestion error: $e");
    } finally {
      isQuestionSubLoading(false);
    }
  }

  void resetQuiz() {
    currentQuestionIndex.value = 0;
    selectedAnswer.value = -1;
    answers.clear();
  }
}
