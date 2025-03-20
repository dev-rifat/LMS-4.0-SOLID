import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/cutom_component/margin_layout.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/chapter_details_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/my_crouse_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/quiz_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/enrolled_crouse_bindings/courseDetailsBindings.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/lesson_model.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/view/widget/quiz/quiz.dart';
import 'package:lms_0_3/routes/app_pages.dart';
import 'package:lms_0_3/utils/app_color.dart';
import '../../../../../../utils/app_layout.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/utils/app_container.dart';
import '../../../controller/comment_controller.dart';
import '../../../controller/tabbar_controller.dart';
import '../../../enrolled_crouse_bindings/comment_bindings.dart';

class LessonWithQuizScreen extends StatefulWidget {
  final String id;
  const LessonWithQuizScreen({super.key, required this.id});

  @override
  State<LessonWithQuizScreen> createState() => _LessonWithQuizScreenState();
}

class _LessonWithQuizScreenState extends State<LessonWithQuizScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final MyCourseController _courseController = Get.find<MyCourseController>();
  final QuizController _quizController = Get.find<QuizController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Lessons",
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
        actions: [_commentButton()],
      ),
      body: Obx(() => _courseController.isLessonChapter.isTrue
          ? loadingIndicator()
          : Padding(
        padding: marginLayout.copyWith(top: 0),
        child: Column(
          children: [
            _tabbarItem(_tabController),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [_buildLesson(), _buildQuiz()],
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _commentButton() {
    return IconButton(
      onPressed: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CommentBindings().dependencies();
          Get.toNamed(Routes.COMMENT_SCREEN);
          Get.find<CommentController>()
              .getMyComment(_courseController.courseId.value);
        });
      },
      icon: const Icon(Icons.message_outlined, color: Colors.black),
    );
  }

  Widget _buildLesson() {
    return Obx(() {
      if (_courseController.isLessonChapter.isTrue) return loadingIndicator();

      final lessons = _courseController.lessonModel?.lessons ?? [];
      if (lessons.isEmpty) {
        return  Center(
          child: Text("No lesson found!", style: AppStyle.normal_text_grey),
        );
      }

      return ListView.separated(
        itemCount: lessons.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return GestureDetector(
            onTap: () => _lessonDetailsRoute(lesson),
            child: Container(
              width: double.infinity,
              decoration: ContainerDecorationHelper.containerDecoration()
                  .copyWith(color: AppColor.primaryColor.withOpacity(0.3)),
              padding: const EdgeInsets.all(8),
              height: AppLayout.getHeight(90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.play_circle_outline,
                          color: AppColor.primaryColor),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Lesson-${lesson.number ?? ''}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.normal_text_grey.copyWith(
                            color: AppColor.primaryColor,
                            fontSize: Dimensions.fontSizeDefault,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lesson.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.normal_text.copyWith(
                      color: AppColor.normalTextColor,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildQuiz() {
    return Obx(() {
      if (_quizController.isQuestionLoading.isTrue) return loadingIndicator();

      final attempts = _quizController.questionModel?.attempts;
      final scores = attempts?.scores ?? [];

      return scores.isNotEmpty ? _withScore() : _startQuizButton();
    });
  }

  Widget _startQuizButton() {
    return Center(
      child: InkWell(
        onTap: () {
          _quizController.getQuestion(widget.id);
          Get.to(() => QuizScreen());
        },
        child: Container(
          width: AppLayout.getWidth(100),
          height: AppLayout.getHeight(48),
          decoration: ContainerDecorationHelper.containerDecoration().copyWith(
              color: AppColor.normalTextColor,
              borderRadius: BorderRadius.circular(50)),
          child:  Center(
            child: Text(
              "Let's go",
              style: AppStyle.normal_text_grey.copyWith(color: AppColor.cardColor),
            ),
          ),
        ),
      ),
    );
  }

  Widget _withScore() {
    final attemptCount = _quizController.questionModel?.attempts?.attemptCount ?? 0;
    final canRetake = attemptCount == 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Your Score 🎉",
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.successColor,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.fontSizeDoubleLarge - 5)),
        Text(_getScore(),
            style: AppStyle.mid_large_text.copyWith(
                color: AppColor.pendingTextColor,
                fontSize: Dimensions.fontSizeDoubleLarge - 5,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        InkWell(
          onTap: canRetake
              ? () {
            _quizController.getQuestion(widget.id);
            Get.to(() => QuizScreen());
          }
              : null,
          child: Container(
            width: AppLayout.getHeight(100),
            decoration: ContainerDecorationHelper.containerDecoration().copyWith(
                color: canRetake ? AppColor.normalTextColor : Colors.transparent,
                borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _getText(),
                  style: AppStyle.normal_text_grey.copyWith(color: AppColor.cardColor),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getText() {
    final attemptCount = _quizController.questionModel?.attempts?.attemptCount ?? 0;
    return attemptCount == 1 ? "Improved" : "Let's go";
  }

  String _getScore() {
    final scores = _quizController.questionModel?.attempts?.scores ?? [];
    if (scores.isEmpty) return "";
    return scores.length > 1 ? "${scores.first} ➜ ${scores[1]}" : scores.first.toString();
  }

  void _lessonDetailsRoute(Lessons lesson) {
    CourseDetailsBindings().dependencies();
    final courseDetailsController = Get.find<CourseDetailsController>();
    final myCourseController = Get.find<MyCourseController>();
    final tabControllerX = Get.find<TabControllerX>();

    courseDetailsController.getChapterDetails(lesson.id.toString());
    myCourseController.lessonId.value = lesson.id.toString();
    tabControllerX.tabController.index = 0;

    Get.toNamed(Routes.CHAPTER_DETAILS);
  }
}




_tabbarItem(TabController tabController) {
  return SizedBox(
    height: AppLayout.getHeight(40),
    child: TabBar(
      labelColor: AppColor.cardColor,
      controller: tabController,
      unselectedLabelColor: AppColor.normalTextColor,
      unselectedLabelStyle: AppStyle.normal_text
          .copyWith(fontSize: Dimensions.fontSizeDefault + 1),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColor.primaryColor,
      ),
      indicatorPadding: EdgeInsets.zero,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: AppStyle.normal_text
          .copyWith(fontSize: Dimensions.fontSizeDefault + 1),
      tabs: [
        Tab(text: "Lessons"),
        Tab(text: "Quiz"),
      ],
    ),
  );
}




