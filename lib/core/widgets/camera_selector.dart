import 'package:socialverse/export.dart';

class CameraModeSelector extends StatelessWidget {
  const CameraModeSelector({
    super.key,
    required this.nav,
  });

  final BottomNavBarProvider nav;

  void _onModeSelected(String mode) {
    HapticFeedback.mediumImpact();
    nav.selectedVideoUploadType = mode;
  }

  Widget _buildModeText(BuildContext context, String mode, double fontSize) {
    return GestureDetector(
      onTap: () => _onModeSelected(mode),
      child: Text(
        mode,
        style: TextStyle(
          color: nav.selectedVideoUploadType == mode
              ? Theme.of(context).focusColor
              : const Color(0xFF7C7C7C),
          fontSize: fontSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isHomeScreen = nav.currentPage == 0;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildModeText(context, "Video", isHomeScreen ? 38 : 13.5),
          if (isHomeScreen) ...[
            const SizedBox(width: 20),
            _buildModeText(context, "Reply", 38),
          ],
        ],
      ),
    );
  }
}
