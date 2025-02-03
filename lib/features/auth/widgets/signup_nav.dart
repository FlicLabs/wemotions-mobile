import 'package:socialverse/export.dart';

class SignUpNav extends StatelessWidget {
  const SignUpNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: 'sofia',
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              // Navigator.of(context).pushNamed(
              //   LoginScreen.routeName,
              // );
            },
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'sofia',
              ),
            ),
          )
        ],
      ),
    );
  }
}
