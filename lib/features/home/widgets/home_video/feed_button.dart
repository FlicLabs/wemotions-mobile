import 'package:socialverse/export.dart';

class FeedButton extends StatelessWidget {
  const FeedButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.textColor,
    required this.buttonColor,
    required this.isSelected,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final Color textColor;
  final Color buttonColor;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontFamily: 'sofia',
              ),
            ),
            SizedBox(height: 3),
            if (isSelected)
              Container(
                height: 2.8,
                width: 28,
                color: Colors.white,
              )
          ],
        ),
      ),
    );
  }
}
