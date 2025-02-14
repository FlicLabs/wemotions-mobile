import 'package:socialverse/export.dart';

class DiscardDialog extends StatelessWidget {
  const DiscardDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CameraProvider _cameraProvider = Provider.of<CameraProvider>(context);
    final theme = Theme.of(context);
    final focusColor = theme.focusColor;
    final backgroundColor = theme.colorScheme.background;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 31),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Discard the last clip?',
              style: _dialogTextStyle(focusColor),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCancelButton(context, focusColor),
                const SizedBox(width: 16),
                _buildDiscardButton(context, _cameraProvider),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _dialogTextStyle(Color color) {
    return TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildCancelButton(BuildContext context, Color textColor) {
    return Expanded(
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('Cancel', style: TextStyle(color: textColor)),
      ),
    );
  }

  Widget _buildDiscardButton(BuildContext context, CameraProvider cameraProvider) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade700, // Consistent discard color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          cameraProvider.resetValues();
          Navigator.of(context).pop();
        },
        child: const Text('Discard', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
