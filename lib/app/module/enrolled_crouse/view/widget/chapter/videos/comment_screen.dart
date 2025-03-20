import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/error_message.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/chapter_details_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/comment_controller.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/dimensions.dart';
import '../../../../../profile/controller/profile_controller.dart';
import '../../../../controller/my_crouse_controller.dart';
import '../../../../models/comment_model.dart';

class CommentsScreen extends GetView<CommentController> {
  CommentsScreen({super.key});

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final myCourseController = Get.find<MyCourseController>();
    final profileController = Get.find<ProfileController>();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Comments",
            style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
          ),
          leading: IconButton(
            onPressed: () {
              
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColor.primaryColor.withOpacity(0.2),
                child: Obx(() {
                  if (controller.isCommentLoading.isTrue) {
                    return const Center(child: CupertinoActivityIndicator());
                  }

                  final comments = controller.commentModel.value.comments ?? [];
                  return comments.isEmpty
                      ? Center(
                    child: Text(
                      "No comments found!",
                      style: AppStyle.normal_text_grey,
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return _buildCommentTile(
                          author: profileController.profileModel.value?.data?.name ?? "Unknown",
                          text: comment.comment ?? "No comment",
                          replies: comment.replies ?? [],
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            _buildCommentInput(myCourseController),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput(MyCourseController myCourseController) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14, bottom: 12, top: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
        ),
        child: TextField(
          controller: _commentController,
          decoration: InputDecoration(
            hintText: 'Add a comment',
            hintStyle: AppStyle.normal_text_black.copyWith(color: AppColor.hintColor),
            suffixIcon: Obx(() => IconButton(
              onPressed: () async {
                final comment = _commentController.text.trim();
                if (comment.isNotEmpty) {
                  controller.isCommentLoading.value = true;
                  try {
                    await controller.addComment(
                      Get.find<MyCourseController>().courseId.value,
                      comment,
                    );
                    _commentController.clear();
                  } catch (error) {
                    showErrorMessage(message: "Failed to add comment");
                  } finally {
                    controller.isCommentLoading.value = false;
                  }
                }
              },
              icon: controller.isCommentLoading.isTrue
                  ? const CupertinoActivityIndicator()
                  : const Icon(Icons.send),
            )),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentTile({
    required String author,
    required String text,
    required List<Replies> replies,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, color: AppColor.hintColor.withOpacity(0.5)),
              const SizedBox(width: 4),
              Text(
                "$author (You)",
                style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 26.0),
            child: Text(text, style: AppStyle.small_text),
          ),
          if (replies.isNotEmpty) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Replies',
                style: AppStyle.small_text.copyWith(color: AppColor.primaryColor),
              ),
            ),
            ...replies.map((reply) => Padding(
              padding: const EdgeInsets.only(left: 30, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle, color: AppColor.hintColor.withOpacity(0.5)),
                      const SizedBox(width: 4),
                      Text(
                        "Author",
                        style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Text(
                      reply.reply ?? "No reply",
                      style: AppStyle.small_text.copyWith(color: AppColor.normalTextColor),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }
}

Future<bool> _onWillPop() async {
  Get.find<CourseDetailsController>().getChapterDetails(Get.find<MyCourseController>().lessonId.value);
  Get.back(canPop: false);
  return false;
}

class DragIndicator extends StatelessWidget {
  const DragIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
