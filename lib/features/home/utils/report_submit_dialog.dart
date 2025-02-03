import 'package:socialverse/export.dart';

import '../widgets/report/button_with_color.dart';

class ReportSubmitDialog extends StatelessWidget {
  const ReportSubmitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      backgroundColor: Theme.of(context).canvasColor,
      child: Container(
        width: 334,
        padding: EdgeInsets.all(20), // Padding inside the dialog
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure minimal size
          children: [
            // Checkmark icon inside the circle
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA858F4), // Circle background color
              ),
              child: Icon(
                Icons.check_rounded, // Checkmark icon
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20), // Space between icon and text

            // Title
            Text(
              "Your Report Has Been",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),Text(
              "Submitted",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10), // Space between title and subtitle

            // Subtitle
            Text(
              "We appreciate your feedback. We'll",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColorDark,
              ),
              textAlign: TextAlign.center,
            ),Text(
              " notify you if any further information is",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColorDark,
              ),
              textAlign: TextAlign.center,
            ),Text(
              "needed.",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColorDark,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),
            Container(width:200,child: ButtonWithColor(title: "Continue", onTap: (){Navigator.of(context).pop();}, isGradient: true)),
          ],
        ),
      ),
    );
  }
}
