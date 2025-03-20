import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_style.dart';
import '../../../../../utils/dimensions.dart';
import '../widget/custom_network_image.dart';


class CourseImage extends StatelessWidget {
  final String imageUrl;

  const CourseImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3.0,
        height: MediaQuery.of(context).size.height / 7.9,
        child: CustomNetworkImage(
          imgUrl: imageUrl,
          isRectangleImg: true,
          borderRadius: 6,
        ),
      ),
    );
  }
}

class CourseDetails extends StatelessWidget {
  final String title;
  final String chapterCount;
  final String expiryDate;

  const CourseDetails({
    super.key,
    required this.title,
    required this.chapterCount,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = expiryDate.isNotEmpty
        ? DateFormat('d MMM yyyy').format(DateTime.parse(expiryDate))
        : "No Expiry";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyle.mid_large_text.copyWith(
            color: AppColor.normalTextColor,
            fontSize: Dimensions.fontSizeDefault + 1,
          ),
        ),
        const SizedBox(height: 4),
        InfoRow(icon: Icons.play_circle_outline, label: chapterCount),
        const SizedBox(height: 4),
        InfoRow(
          icon: Icons.date_range,
          label: "Expires on: $formattedDate",
          textColor: AppColor.primaryOrange,
        ),
      ],
    );
  }


}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? textColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.hintColor, size: 18),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyle.mid_large_text.copyWith(
              color: textColor ?? AppColor.hintColor,
              fontSize: Dimensions.fontSizeDefault - 1,
            ),
          ),
        ),
      ],
    );
  }
}
