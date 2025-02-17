// RecordButton.dart
import 'package:socialverse/export.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraProvider>(
      builder: (_, cameraProvider, __) {
        return GestureDetector(
          onTap: () async {
            if (cameraProvider.isVideoRecord) {
              await cameraProvider.stopRecording();
            }
          },
          child: CircularPercentIndicator(
            radius: 35,
            lineWidth: 4.0,
            backgroundColor: cameraProvider.isRecordStart
                ? Colors.white
                : Theme.of(context).hintColor,
            percent: cameraProvider.recordPercentage,
            progressColor: const Color(0xFFA858F4),
            animation: true,
            addAutomaticKeepAlive: true,
            animationDuration: 1000,
            animateFromLastPercent: true,
            center: Stack(
              alignment: Alignment.center,
              children: [
                _buildOuterRing(),
                _buildInnerCircle(),
                _buildRecordingIndicator(cameraProvider.isRecordStart, context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOuterRing() {
    return Container(
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
    );
  }

  Widget _buildInnerCircle() {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRecordingIndicator(bool isRecording, BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        shape: isRecording ? BoxShape.circle : BoxShape.rectangle,
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
