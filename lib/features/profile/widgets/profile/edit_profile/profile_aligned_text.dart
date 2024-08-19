import 'package:socialverse/export.dart';

class ProfileAlignedText extends StatelessWidget {
  final String title;
  const ProfileAlignedText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w200,
          color: Theme.of(context).indicatorColor,
          fontFamily: 'sofia',
        ),
      ),
    );
  }
}
