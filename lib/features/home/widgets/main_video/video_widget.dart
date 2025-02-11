import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewPageArgs {
  final String videoUrl;
  final String thumbnailUrl;
  final String videoId;

  VideoViewPageArgs({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.videoId,
  });
}

class VideoViewPage extends StatefulWidget {
  static const routeName = '/video-view';
  final String videoUrl;
  final String thumbnailUrl;
  final String videoId;

  const VideoViewPage({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.videoId,
  });

  static Route route({required VideoViewPageArgs args}) {
    return MaterialPageRoute(
      builder: (_) => VideoViewPage(
        videoUrl: args.videoUrl,
        thumbnailUrl: args.thumbnailUrl,
        videoId: args.videoId,
      ),
    );
  }

  @override
  State<VideoViewPage> createState() => _VideoViewPageState();
}

class _VideoViewPageState extends State<VideoViewPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.network(widget.videoUrl);
    await _controller.initialize();
    setState(() {});
    _controller.play();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Hero(
              tag: 'video_${widget.videoId}',
              child: _controller.value.isInitialized
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isPlaying = !_isPlaying;
                    _isPlaying ? _controller.play() : _controller.pause();
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
                  : Image.network(
                widget.thumbnailUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}