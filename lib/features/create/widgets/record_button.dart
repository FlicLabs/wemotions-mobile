// RecordButton.dart
import 'package:socialverse/export.dart';

class RecordButton extends StatefulWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, __, ___) {
        return GestureDetector(
          onTap: () async {
            if (__ .isVideoRecord) {
              await __.stopRecording();
            }
          },
          child: CircularPercentIndicator(
            radius: 35,
            lineWidth: 4.0,
            backgroundColor:
                __.isRecordStart ? Colors.white : Theme.of(context).hintColor,
            percent: __.recordPercentage,
            progressColor: const Color(0xFFA858F4),
            animation: true,
            addAutomaticKeepAlive: true,
            animationDuration: 1000,
            animateFromLastPercent: true,
            center: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 86,
                  width: 86,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.transparent,
                        Colors.white10,
                        Colors.white12,
                        Colors.white38,
                      ],
                      stops: [0.5, 0.6, 0.7, 1.0],
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    shape:
                        __.isRecordStart ? BoxShape.circle : BoxShape.rectangle,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}