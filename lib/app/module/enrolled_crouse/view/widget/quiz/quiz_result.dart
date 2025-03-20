import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/custom_app_buttom.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/question_model.dart';
import 'package:lms_0_3/utils/app_color.dart';
import '../../../controller/quiz_controller.dart';

class QuizResultScreen extends GetView<QuizController> {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.find<QuizController>();

    // Fetch questions safely
    List<Questions> questionList = controller.questionModel?.exam?.questions ?? [];
    if (questionList.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Answers"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Answers", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: questionList.length,
                itemBuilder: (context, index) {
                  Questions questionData = questionList[index];

                  // Find selected answer safely
                  Map<String, int>? selectedAnswer = controller.answers.firstWhereOrNull(
                        (answer) => answer["question_id"] == questionData.id,
                  );

                  String answerText = "Not Answered";
                  if (selectedAnswer != null) {
                    var selectedOption = questionData.options?.firstWhereOrNull(
                          (option) => option.id == selectedAnswer["selected_option"],
                    );
                    answerText = selectedOption?.optionText ?? "Unknown";
                  }

                  return Card(
                    color: AppColor.primaryColor.withOpacity(0.4),
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q${index + 1}: ${questionData.questionText ?? ""}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Your Answer: $answerText",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            Obx(() {
              return controller.isQuestionSubLoading.isTrue
                  ? loadingIndicator()
                  : CustomAppButton(
                text: "Submit",
                onPressed: () {
                  int examId = controller.questionModel?.exam?.id ?? 0;
                  controller.submitQuestion(examId, controller.answers);
                },
                buttonColor: AppColor.primaryColor,
                btnBorderColor: AppColor.primaryColor,
                buttonTextColor: AppColor.cardColor,
                buttonRadius: 8,
              );
            }),
          ],
        ),
      ),
    );
  }
}
