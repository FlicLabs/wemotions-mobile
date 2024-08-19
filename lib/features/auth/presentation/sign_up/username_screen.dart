import 'package:socialverse/export.dart';

class UsernameScreen extends StatelessWidget {
  static const String routeName = '/create-username';
  const UsernameScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => UsernameScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create your username',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: __.usernameFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.name,
                        hintText: 'Username',
                        autofocus: true,
                        controller: __.username,
                        validator: (String? v) {
                          if (v!.isNotEmpty) {
                            return null;
                          } else {
                            return 'Please enter your username';
                          }
                        },
                      ),
                      height20,
                      AuthButton(
                        title: 'Continue',
                        onTap: () {
                          if (__.usernameFK.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                              PasswordScreen.routeName,
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
