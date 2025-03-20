import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../utils/api_endpoints.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_layout.dart';
import '../../../../../../../utils/app_style.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../global/view/widget/custom_alert_dialog.dart';
import '../../../../../../global/view/widget/custom_spacer.dart';
import '../../../../../../global/view/widget/error_message.dart';
import '../../../../controller/chapter_details_controller.dart';


class DownloadFile extends GetView<CourseDetailsController> {
  const DownloadFile({super.key});

  @override
  Widget build(BuildContext context) {
    final files = controller.chapterDetailsModel?.data?.files;

    if (files == null || files.isEmpty) {
      return Center(
        child: Text(
          "No file found!",
          style: AppStyle.normal_text_grey,
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
            itemCount: files.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = files[index];
              return _buildDocumentCard(
                fileName: data.title ?? "Unknown",
                url: data.file,
                index: index,
                date: controller.chapterDetailsModel?.data?.createdAt ?? "",
              );
            },
          ),
        ),
      );
    }
  }


  /// Builds each document card displaying document name, date, and download icon.
  Widget _buildDocumentCard(
      {required String date, required String fileName, String? url,required int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        height: AppLayout.getHeight(80),

        width: double.infinity,
        child: Card(
          elevation: 0,
          color: AppColor.hintColor.withOpacity(0.09),
          shape: roundedRectangleBorder.copyWith(
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            children: [
              _buildDocumentIcon(),
              customSpacerWidth(width: 8),
              _buildDocumentInfo(date: date, fileName: fileName,index: index),
              customSpacerWidth(width: 4),
              _buildDownloadIcon(url),
              customSpacerWidth(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the document icon in the card.
  Widget _buildDocumentIcon() {
    return SizedBox(
      height: double.infinity,
      width: 70,
      child: Card(
        elevation: 0,
        color: AppColor.primaryColor,
        shape: roundedRectangleBorder.copyWith(
            borderRadius: BorderRadius.circular(7)),
        child: const Icon(
          CupertinoIcons.doc_text,
          color: AppColor.cardColor,
          size: 28,
        ),
      ),
    );
  }

  /// Builds the document info section with file name and date.
  Widget _buildDocumentInfo({required String fileName, required String date,required int index}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          customSpacerHeight(height: 6),
          Text(
            fileName,
            maxLines: 1,
            style: AppStyle.normal_text_black
                .copyWith(overflow: TextOverflow.ellipsis),
          ),
          customSpacerHeight(height: 6),
          Text(
            formatDate(date: date, format: "dd MMM, yyyy"),
            maxLines: 1,
            style: AppStyle.normal_text.copyWith(
              color: AppColor.hintColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the download icon in the document card.
  Widget _buildDownloadIcon(String? url) {
    return InkWell(
      onTap: () {
        if (url == null || url.isEmpty) {
          showErrorMessage(message: "Invalid document");
        } else {
          _launchUrl(Api.documentDownloadKey + url);
        }
      },
      child: Icon(
        Icons.file_download_outlined,
        color: AppColor.hintColor.withOpacity(0.6),
        size: 28,
      ),
    );
  }
}

Future<void> _launchUrl(String pdfUrl) async {
  final Uri url = Uri.parse(pdfUrl);

  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
