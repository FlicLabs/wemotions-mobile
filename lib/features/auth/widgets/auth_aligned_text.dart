import 'package:socialverse/export.dart';

class AuthAlignedText extends StatelessWidget {
  final String title;
  const AuthAlignedText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w200,
          color: Colors.white,
          fontFamily: 'sofia',
        ),
      ),
    );
  }
}
