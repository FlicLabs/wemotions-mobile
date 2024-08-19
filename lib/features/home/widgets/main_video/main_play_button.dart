import 'package:socialverse/export.dart';

class MainPlayButton extends StatelessWidget {
  const MainPlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (_, __, ___) {
        return __.videoController(__.index)!.value.isInitialized
            ? __.videoController(__.index)!.value.isPlaying
                ? shrink
                : Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 65,
                    ),
                  )
            : shrink;
      },
    );
  }
}
