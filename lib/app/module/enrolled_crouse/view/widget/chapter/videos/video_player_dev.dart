import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:lms_0_3/app/global/view/widget/custom_onloading.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../../../../../utils/app_color.dart';
import '../../../../../../../utils/app_style.dart';

class VideoPayerDev extends StatefulWidget {
  final String? videoUrl;
  final String? title;

  const VideoPayerDev({super.key, required this.videoUrl, required this.title});

  @override
  State<VideoPayerDev> createState() => _VideoPayerDevState();
}

class _VideoPayerDevState extends State<VideoPayerDev> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _validateAndPrepareVideo();
  }

  Future<void> _validateAndPrepareVideo() async {
    final videoUrl = widget.videoUrl;

    if (videoUrl == null || videoUrl.isEmpty || !Uri.parse(videoUrl).isAbsolute) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      return;
    }

    // Validate video URL in a separate isolate
    bool isValid = await compute(_validateVideoUrl, videoUrl);

    if (isValid) {
      _initializePlayer(videoUrl);
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  static Future<bool> _validateVideoUrl(String videoUrl) async {
    try {
      final response = await http.head(Uri.parse(videoUrl)).timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      debugPrint('Error validating video URL: $e');
      return false;
    }
  }

  void _initializePlayer(String videoUrl) async {
    try {
      VideoPlayerController controller = VideoPlayerController.network(videoUrl); // Changed to .network

      await controller.initialize();

      setState(() {
        _videoPlayerController = controller;
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: true,
          allowedScreenSleep: false,
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );
        _isLoading = false;
        _isError = false;
      });
    } catch (e) {
      debugPrint('Error initializing video player: $e');
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? 'Video Player', style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor)),
        ),
        body: Center(child: loadingIndicator()),
      );
    }

    if (_isError) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? 'Video Player', style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Invalid video URL.\nPlease check the URL or try again later.',
              style: AppStyle.normal_text.copyWith(color: AppColor.errorColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Video Player', style: AppStyle.normal_text_grey.copyWith(color: AppColor.normalTextColor, overflow: TextOverflow.ellipsis)),
      ),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(controller: _chewieController!),
      ),
    );
  }
}
