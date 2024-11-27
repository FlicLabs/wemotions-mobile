import 'package:socialverse/export.dart';

class HomeVideoProgressIndicator extends StatelessWidget {
  const HomeVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        return Positioned(
          bottom: -1,
          child: SizedBox(
            height: 9.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                //ui changes when replies are fetched.

                VideoProgressIndicator(
                  __.videoController(__.index)!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    bufferedColor: Colors.white,
                    backgroundColor: Colors.white,
                    playedColor: Theme.of(context).hintColor,
                  ),
                )
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
                //         __
                //             .videoController(__.index)!
                //             .seekTo(Duration(milliseconds: value.toInt()));
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
            ),
          ),
        );
      },
    );
  }
}
