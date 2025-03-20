import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/app/global/view/widget/custom_spacer.dart';
import 'package:lms_0_3/app/global/view/widget/error_message.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/controller/quiz_controller.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/enrolled_crouse_bindings/quiz_bindings.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/models/modules_model.dart';
import 'package:lms_0_3/app/module/enrolled_crouse/view/widget/lesson_list/lesson.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../utils/api_endpoints.dart';
import '../../../../../../utils/app_color.dart';
import '../../../../../../utils/app_style.dart';
import '../../../../../../utils/dimensions.dart';
import '../../../../../global/utils/app_container.dart';
import '../../../../../global/view/widget/custom_network_image.dart';
import '../../../controller/my_crouse_controller.dart';
class ChapterListScreen extends GetView<MyCourseController> {
  const ChapterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Modules",
          style: AppStyle.title_text.copyWith(fontSize: Dimensions.fontSizeMid),
        ),
      ),
      body: Obx(() {
        if (controller.isModuleLoading.isTrue) {
          return loadingIndicator();
        }

        final modules = controller.moduleModel?.modules;
        if (modules == null || modules.isEmpty) {
          return Center(
            child: Text(
              "No modules found!",
              style: AppStyle.normal_text_grey,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.builder(
            itemCount: modules.length,
            itemBuilder: (context, index) {
              Modules module = modules[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
                child: Container(
                  decoration: ContainerDecorationHelper.containerDecoration()
                      .copyWith(color: AppColor.primaryColor.withOpacity(0.2)),
                  child: GestureDetector(
                    onTap: () => _updatedRoute(module),
                    child: Row(
                      children: [
                        _imageLayout(module.thumbnail ?? ""),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  module.title ?? "No Title",
                                  maxLines: 2,
                                  style: AppStyle.normal_text_black.copyWith(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w800,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  module.description ?? "No Description Available",
                                  maxLines: 3,
                                  style: AppStyle.normal_text_black.copyWith(
                                    color: AppColor.normalTextColor,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.5,
                                  ),
                                ),
                                SizedBox(height: 7),
                                if (module.file != null) _downloadFile(module.file.toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _imageLayout(String imgUrl) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        child: SizedBox(
          height: 90,
          width: 100,
          child: CustomNetworkImage(
            imgUrl: imgUrl.isNotEmpty ? imgUrl : "assets/images/placeholder.png",
            isRectangleImg: true,
            isModule: true,
          ),
        ),
      ),
    );
  }

  _downloadFile(String file) {
    return InkWell(
      onTap: () => _launchUrl(file),
      child: Row(
        children: [
          const Icon(Icons.file_download, size: 17),
          customSpacerWidth(width: 4),
          const Text(
            "Module overview",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  _updatedRoute(Modules module) async {
    if (module.id != null) {
      try {
        QuizBindings().dependencies();

        controller.getLesson(module.id.toString());
        // Ensure QuizBindings are set correctly
        Get.find<QuizController>().getQuestion(module.id.toString() ?? "");
        controller.chapterDetailsId.value = module.id.toString();
        Get.to(() => LessonWithQuizScreen(id: module.id.toString()));
      } catch (e) {
        showErrorMessage(message: "Error while navigating: ${e.toString()}");
      }
    } else {
      showErrorMessage(message: "Invalid module!");
    }
  }
}

Future<void> _launchUrl(String url) async {
  if (url.isEmpty) {
    showErrorMessage(message: "Invalid URL");
    return;
  }

  final Uri uri = Uri.parse("${Api.documentDownloadKey}file/$url");
  if (!await launchUrl(uri)) {
    showErrorMessage(message: "Could not open the URL");
  }
}
