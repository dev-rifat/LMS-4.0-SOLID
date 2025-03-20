import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_network_image.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/custom_spacer.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/custom_app_buttom.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/question_model.dart';
import 'package:lms_0_3/utils/app_color.dart';
import 'package:lms_0_3/utils/app_layout.dart';
import '../../../../../global/utils/app_container.dart';
import '../../../controller/quiz_controller.dart';
import '../../../enrolled_crouse_bindings/quiz_bindings.dart';

class QuizScreen extends GetView<QuizController> {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz")),
      body: Obx(() {
        // Loading state check
        if (controller.isQuestionLoading.isTrue) {
          return loadingIndicator();
        }

        List<Questions>? questionList = controller.questionModel?.exam?.questions;

        // Check if the question list is null or empty
        if (questionList == null || questionList.isEmpty) {
          return const Center(child: Text("No questions available"));
        }

        int currentIndex = controller.currentQuestionIndex.value;

        // Ensure the current question index is valid
        if (currentIndex >= questionList.length) {
          return const Center(child: Text("Invalid question index"));
        }

        Questions questionData = questionList[currentIndex];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${currentIndex + 1}/${questionList.length}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: (currentIndex + 1) / questionList.length),
                const SizedBox(height: 20),
            
                // Question Text & Image
                _buildQuestion(questionData),
                const SizedBox(height: 20),
            
                // Answer Options
                Obx(() {
                  int selectedIndex = controller.selectedAnswer.value;
            
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: questionData.options?.length ?? 0,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          if (controller.selectedAnswer.value != index) {
                            controller.selectedAnswer.value = index;  // Ensure state updates correctly
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: ContainerDecorationHelper.containerDecoration().copyWith(
                            color: isSelected
                                ? AppColor.primaryColor
                                : AppColor.primaryColor.withOpacity(0.2),
                            border: Border.all(color: AppColor.primaryColor, width: 0.6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  questionData.options?[index].optionText ?? "",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: isSelected ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                              if (isSelected) const Icon(Icons.check_circle, color: Colors.white),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
            
                const SizedBox(height: 20),
            
                // Next or Finish Button
                Obx(() {
                  bool isLastQuestion = controller.currentQuestionIndex.value == questionList.length - 1;
            
                  return CustomAppButton(
                    text: isLastQuestion ? "Finish" : "Next",
                    onPressed: controller.selectedAnswer.value == -1
                        ? null
                        : controller.nextQuestion,
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
      }),
    );
  }

  // Question Text and Image Widget
  Widget _buildQuestion(Questions data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.questionText ?? "No question text available",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        customSpacerHeight(height: 6),
        if (data.questionImage != null && data.questionImage!.isNotEmpty)
          SizedBox(
            height: AppLayout.getHeight(300),
            width: double.infinity,
            child: CustomNetworkImage(
              imgUrl: data.questionImage!,
              isRectangleImg: true,
              borderRadius: 6,
              isQuiz: true,
            ),
          ),
      ],
    );
  }
}
