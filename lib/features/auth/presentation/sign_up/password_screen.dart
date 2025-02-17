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
      builder: (context, authProvider, _) {
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: authProvider.passwordFK,
                  child: Column(
                    children: [
                      AuthTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Password',
                        obscureText: authProvider.obscureText,
                        controller: authProvider.password,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            authProvider.togglePasswordVisibility();
                          },
                          child: AuthObscureIcon(),
                        ),
                        validator: (String? v) {
                          if (v == null || v.isEmpty) {
                            return 'Please enter your password';
                          } else if (!v.isValidPassword) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                      ),
                      height20,
                      AuthButton(
                        title: 'Continue',
                        onTap: () {
                          if (authProvider.passwordFK.currentState!.validate()) {
                            Navigator.of(context).pushNamed(NameScreen.routeName);
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
