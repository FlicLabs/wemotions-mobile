import 'package:socialverse/export.dart';

class PasswordScreen extends StatelessWidget {
  static const String routeName = '/create-password';
  const PasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => PasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create your password',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: __.passwordFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          obscureText: __.obscureText,
                          controller: __.password,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              __.obscureText = !__.obscureText;
                            },
                            child: AuthObscureIcon(),
                          ),
                          validator: (String? v) {
                            if (v == null || v.isEmpty) {
                              return 'Please enter your password';
                            } else if (!v.isValidPassword) {
                              return 'Please enter a valid password';
                            } else {
                              return null;
                            }
                          }),
                      height20,
                      AuthButton(
                        title: 'Continue',
                        onTap: () {
                          if (__.passwordFK.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                              NameScreen.routeName,
                            );
                          }
                        },
                      ),
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
