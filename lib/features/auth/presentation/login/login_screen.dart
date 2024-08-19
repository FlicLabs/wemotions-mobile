import 'package:socialverse/export.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    final profile = Provider.of<ProfileProvider>(context);
    return Consumer<AuthProvider>(builder: (_, __, ___) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.clear_sharp),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: cs().height(context),
            width: cs().width(context),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: __.loginFormKey,
                          child: Column(
                            children: [
                              Image.asset(
                                AppAsset.icon,
                                height: 180,
                                width: cs().width(context) / 2,
                                color: Theme.of(context).indicatorColor,
                              ),
                              AuthTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Username or email',
                                controller: __.email,
                                validator: (String? v) {
                                  if (v!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return 'Please enter your password';
                                  }
                                },
                              ),
                              height20,
                              AuthTextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                hintText: 'Password',
                                obscureText: __.obscureText,
                                controller: __.password,
                                onChanged: (value) {
                                  __.incorrectPassword = false;
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    __.obscureText = !__.obscureText;
                                  },
                                  child: AuthObscureIcon(),
                                ),
                                validator: (String? v) {
                                  if (v!.isNotEmpty) {
                                    if (__.incorrectPassword == true) {
                                      return 'Credentials don\'t match ';
                                    }
                                    return null;
                                  } else {
                                    return 'Please enter your password';
                                  }
                                },
                              ),
                              height10,
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ForgotPasswordScreen.routeName);
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Forgot Password?',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                              height40,
                              if (__.loggedInAuthStatus ==
                                  AuthStatus.Authenticating) ...[
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: CustomProgressIndicator(),
                                )
                              ],
                              if (__.loggedInAuthStatus !=
                                  AuthStatus.Authenticating) ...[
                                AuthButton(
                                  onTap: () async {
                                    if (__.loginFormKey.currentState!
                                        .validate()) {
                                      await __.login(
                                        email: __.email.text,
                                        password: __.password.text,
                                      );
                                      profile.fetchProfile(
                                        username: prefs_username!,
                                      );
                                    }
                                  },
                                  title: 'Login',
                                ),
                              ],
                              height20,
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  width20,
                                  Text(
                                    'OR',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                      color: Theme.of(context).indicatorColor,
                                      fontFamily: 'sofia',
                                    ),
                                  ),
                                  width20,
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                              height20,
                              if (Platform.isIOS) ...[
                                SocialButton(
                                  title: 'Sign in with Apple',
                                  icon: Icons.apple,
                                  onTap: () async {
                                    await __.signInWithApple();
                                    profile.fetchProfile(
                                        username: prefs_username!);
                                  },
                                )
                              ],
                              if (Platform.isAndroid) ...[
                                SocialButton(
                                  title: 'Sign in with Google',
                                  icon: UniconsLine.google,
                                  onTap: () async {
                                    await __.signInWithGoogle();
                                    profile.fetchProfile(
                                      username: prefs_username!,
                                    );
                                  },
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  isKeyboardShowing ? shrink : LoginNav()
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
