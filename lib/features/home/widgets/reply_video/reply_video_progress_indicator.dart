import 'package:socialverse/export.dart';

class ReplyVideoProgressIndicator extends StatelessWidget {
  const ReplyVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReplyProvider>(
      builder: (_, replyProvider, ___) {
        final videoController = replyProvider.videoController(replyProvider.index);

        if (videoController == null || !videoController.value.isInitialized) {
          return const SizedBox.shrink();
        }

        return Positioned(
          bottom: 0,
          child: SizedBox(
            height: 9.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                _buildVideoProgressIndicator(context, videoController),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoProgressIndicator(BuildContext context, VideoPlayerController controller) {
    return VideoProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: VideoProgressColors(
        bufferedColor: Colors.white.withOpacity(0.5),
        backgroundColor: Colors.white.withOpacity(0.2),
        playedColor: Theme.of(context).hintColor,
      ),
    );
  }
}
