import 'package:socialverse/export.dart';

class HomeVideoProgressIndicator extends StatelessWidget {
  const HomeVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, __, ___) {
        final controller = __.videoController(__.index);

        if (controller == null) {
          return Positioned(
            bottom: -1,
            child: SizedBox(
              height: 9.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  const LinearProgressIndicator(value: 0)
                ],
              ),
            ),
          );
        }
        if (!controller.value.isInitialized) {

          return Positioned(
            bottom: -1,
            child: SizedBox(
              height: 9.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  const LinearProgressIndicator(value: 0)
                ],
              ),
            ),
          );
        }

        return Positioned(
          bottom: -1,
          child: SizedBox(
            height: 9.5,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [


                VideoProgressIndicator(
                  __.videoController(__.index)!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    bufferedColor: Colors.white,
                    backgroundColor: Colors.white,
                    playedColor: Theme.of(context).hintColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
