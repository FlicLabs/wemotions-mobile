import 'package:socialverse/export.dart';

class LoginNav extends StatelessWidget {
  const LoginNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: Colors.grey.shade200,
            ),
          ),
          height5,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).indicatorColor,
                  fontFamily: 'sofia',
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed(
                  //   UsernameScreen.routeName,
                  // );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).hintColor,
                    fontFamily: 'sofia',
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
