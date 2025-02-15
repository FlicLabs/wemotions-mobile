import 'package:socialverse/export.dart';

class MainVideoProgressIndicator extends StatelessWidget {
  const MainVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<VideoProvider, VideoPlayerController?>(
      selector: (_, provider) => provider.videoController(provider.index),
      builder: (_, videoController, __) {
        if (videoController == null || !videoController.value.isInitialized) {
          return const SizedBox.shrink();
        }

        final videoValue = videoController.value;
        final duration = videoValue.duration;

        // Hide the progress bar for very short videos.
        if (duration <= const Duration(seconds: 20)) {
          return const SizedBox.shrink();
        }

        return Positioned(
          bottom: -1,
          child: SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width,
            child: VideoProgressIndicator(
              videoController,
              allowScrubbing: true,
              colors: VideoProgressColors(
                bufferedColor: Colors.white,
                backgroundColor: Colors.white,
                playedColor: Theme.of(context).hintColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
