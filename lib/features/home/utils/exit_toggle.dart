import 'package:socialverse/export.dart';

class ExitToggle extends StatelessWidget {
  const ExitToggle({super.key});

  @override
  Widget build(BuildContext context) {
     final video = Provider.of<VideoProvider>(context);
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: video.isViewMode ? ExitView() : shrink,
    );
  }
}
