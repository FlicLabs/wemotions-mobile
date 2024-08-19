import 'package:socialverse/export.dart';

class MainVideoProgressIndicator extends StatelessWidget {
  const MainVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (_, __, ___) {
        final Duration duration = __.videoController(__.index)!.value.duration;
        return Positioned(
          bottom: 0,
          child: SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width,
            child: duration > Duration(seconds: 20)
                ? Stack(
                    children: [
                      VideoProgressIndicator(
                        __.videoController(__.index)!,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          bufferedColor: Colors.white,
                          backgroundColor: Colors.white,
                          playedColor: Theme.of(context).hintColor,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 3.8),
                      //   child: SliderTheme(
                      //     data: SliderTheme.of(context).copyWith(
                      //       overlayShape: SliderComponentShape.noOverlay,
                      //       activeTrackColor: Theme.of(context).hintColor,
                      //       inactiveTrackColor: Colors.transparent,
                      //       thumbColor: Theme.of(context).hintColor,
                      //       trackShape: RectangularSliderTrackShape(),
                      //       thumbShape:
                      //           RoundSliderThumbShape(enabledThumbRadius: 5.0),
                      //     ),
                      //     child: Slider(
                      //       value: __
                      //           .videoController(__.index)!
                      //           .value
                      //           .position
                      //           .inMilliseconds
                      //           .toDouble(),
                      //       onChanged: (double value) {
                      //         __.videoController(__.index)!.seekTo(
                      //             Duration(milliseconds: value.toInt()));
                      //       },
                      //       min: 0.0,
                      //       max: __
                      //           .videoController(__.index)!
                      //           .value
                      //           .duration
                      //           .inMilliseconds
                      //           .toDouble(),
                      //       activeColor: Colors.transparent,
                      //       inactiveColor: Colors.transparent,
                      //       thumbColor: Theme.of(context).hintColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                : shrink,
          ),
        );
      },
    );
  }
}
