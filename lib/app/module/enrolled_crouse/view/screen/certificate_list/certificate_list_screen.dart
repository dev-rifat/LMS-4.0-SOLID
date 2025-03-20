import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_0_3/app/global/utils/app_container.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:lms_0_3/utils/app_color.dart';
import 'package:lms_0_3/utils/app_style.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../utils/api_endpoints.dart';
import '../../../controller/my_crouse_controller.dart';

class CertificationListScreen extends GetView<MyCourseController> {
  const CertificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Certificates",
          style: AppStyle.mid_large_text.copyWith(color: AppColor.normalTextColor),
        ),
      ),
      body: Obx(() {
        if (controller.isCertificateLoading.isTrue) {
          return loadingIndicator();
        }

        final certificates = controller.certificateModel?.data;
        if (certificates == null || certificates.isEmpty) {
          return Center(
            child: Text("No certificate found!", style: AppStyle.normal_text_grey),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: certificates.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) => _buildCertificateItem(certificates[index]),
          ),
        );
      }),
    );
  }

  Widget _buildCertificateItem(dynamic certificate) {
    final title = certificate.title ?? "Unknown Title";
    final certificateUrl = certificate.certificate?.toString() ?? "";

    return Container(
      decoration: ContainerDecorationHelper.containerDecoration().copyWith(
        color: AppColor.primaryColor.withOpacity(0.3),
      ),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        trailing: IconButton(
          onPressed: certificateUrl.isNotEmpty ? () => _launchUrl(certificateUrl) : null,
          icon: Icon(Icons.file_download_outlined, color: AppColor.primaryColor),
        ),
      ),
    );
  }
}

Future<void> _launchUrl(String url) async {
  if (url.isEmpty) {
    Get.snackbar("Error", "Invalid certificate URL", backgroundColor: Colors.red);
    return;
  }

  final Uri uri = Uri.parse("${Api.downloadCertificate}$url");
  if (!await launchUrl(uri)) {
    Get.snackbar("Error", "Could not open certificate", backgroundColor: Colors.red);
  }
}
