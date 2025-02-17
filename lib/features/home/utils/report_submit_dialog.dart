import 'package:socialverse/export.dart';

class ReportSubmitDialog extends StatelessWidget {
  const ReportSubmitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkmark icon inside a circular container
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA858F4),
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              "Your Report Has Been\nSubmitted",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Subtitle
            Text(
              "We appreciate your feedback.\nWe'll notify you if any further\ninformation is needed.",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColorDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Continue Button
            SizedBox(
              width: 200,
              child: AuthButtonWithColor(
                title: "Continue",
                onTap: () => Navigator.of(context).pop(),
                isGradient: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

