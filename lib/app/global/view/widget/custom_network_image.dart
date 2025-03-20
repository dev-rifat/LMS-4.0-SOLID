import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/api_endpoints.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final String? errorImg;
  final double height;
  final double? borderRadius;
  final bool isProfileImg;
  final Color? borderColor;
  final bool isRectangleImg;
  final bool isAppSetting;
  final bool isModule;
  final bool isQuiz;
  final BorderRadius? customBorderRadius;

  const CustomNetworkImage({
    super.key,
    this.height = 32,
    required this.imgUrl,
    this.borderRadius,
    this.isProfileImg = false,
    this.isAppSetting = false,
    this.isQuiz = false,
    this.isModule = false,
    this.borderColor,
    this.customBorderRadius,
    this.errorImg,
    this.isRectangleImg = false,
  });


  @override
  Widget build(BuildContext context) {
    // Helper function to build the image URL
    String buildURL() {
      if (isAppSetting == true) {
        return "${Api.BASE_URL.replaceAll("/api", "")}${Api.imagePublicKey.replaceAll("course_thumbnails", "app")}$imgUrl";
      } else if (isProfileImg == true) {
        return "${Api.BASE_URL.replaceAll("/api", "")}${Api.imagePublicKey.replaceAll("course_thumbnails", "/images/users/")}$imgUrl";
      } else if (isModule == true) {
        return "${Api.BASE_URL.replaceAll("/api", "")}${Api.imagePublicKey.replaceAll("course_thumbnails", "/modules/")}$imgUrl";
      } else if (isQuiz == true) {
        return "${Api.BASE_URL.replaceAll("/api", "/")}$imgUrl";
      } else {
        return "${Api.BASE_URL.replaceAll("/api", "")}${Api.imagePublicKey}$imgUrl";
      }
    }


    if (!isRectangleImg) {
      return _buildCircleAvatar(
        buildURL(),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: buildURL(),
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorImage(),
        imageBuilder: (context, imageProvider) => _buildRectangleImage(imageProvider),
      );
    }
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            customBorderRadius ?? BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: AssetImage(errorImg ?? AppImages.placeholder),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(child: CupertinoActivityIndicator()),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            customBorderRadius ?? BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: AssetImage(errorImg ?? AppImages.placeholder),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildRectangleImage(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: customBorderRadius ?? BorderRadius.circular(borderRadius ?? 0),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildCircleAvatar(String imgKey) {
    final radius = height;
    return CircleAvatar(
      radius: radius + 2.5,
      backgroundColor: borderColor ?? AppColor.primaryColor,
      child: CircleAvatar(
        radius: radius + 2,
        backgroundColor: borderColor ?? AppColor.cardColor,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: AppColor.cardColor,
          child: CachedNetworkImage(
            imageUrl: imgKey,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => _buildCircleErrorImage(),
            imageBuilder: (context, imageProvider) =>
                _buildCircleImage(imageProvider),
          ),
        ),
      ),
    );
  }

  Widget _buildCircleErrorImage() {
    return CircleAvatar(
      backgroundColor: AppColor.hintColor.withOpacity(0.5),
      radius: height,
      child: const Icon(
        Icons.person,
        color: AppColor.cardColor,
      ),
    );
  }

  Widget _buildCircleImage(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
