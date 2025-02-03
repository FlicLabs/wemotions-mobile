import 'package:socialverse/export.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardShowing = MediaQuery.of(context).viewInsets.vertical > 0;
    final profile = Provider.of<ProfileProvider>(context);
    return Consumer<AuthProvider>(builder: (_, __, ___) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 5),
            child: AppBar(
              toolbarHeight: 80,
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  __.emailError = null;
                  __.passwordError = null;
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        __.emailError = null;
                        __.passwordError = null;
                        Navigator.pop(context);
                        Navigator.pushNamed(context, SignUpScreen.routeName);
                      },
                      child: Text(
                        'Sign up',
                        style: AppTextStyle.normalRegular14.copyWith(
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: Container(
            height: cs.height(context),
            width: cs.width(context),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 24, right: 24),
                        child: Form(
                          key: __.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login",
                                style: AppTextStyle.normalSemiBold28Black
                                    .copyWith(
                                        color: Theme.of(context).focusColor),
                              ),
                              height8,
                              Text(
                                "Login to join the conversation and connect with your community",
                                style: AppTextStyle.subheadlineMedium.copyWith(
                                    color: Theme.of(context).primaryColorDark),
                              ),
                              height24,
                              Text(
                                "Email or username",
                                style: AppTextStyle.labelMedium.copyWith(
                                    color: Theme.of(context).indicatorColor),
                              ),
                              height8,
                              AuthTextFormField(
                                keyboardType: TextInputType.emailAddress,
                                hintText: 'Bryan_Reichert15@hotmail.com ',
                                controller: __.email,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    __.emailError =
                                        'Please enter your email or username';
                                    return '';
                                  }
                                  __.emailError = null;
                                  return null; // No error
                                },
                              ),
                              // Display error message if exists
                              if (__.emailError != null) ...[
                                height8,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.red.shade600,
                                      size: 20,
                                    ),
                                    width5,
                                    Center(
                                      child: Text(
                                        __.emailError!,
                                        style: TextStyle(
                                            color: Colors.red.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              height20,
                              Text("Password"),
                              height8,
                              AuthTextFormField(
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                hintText: '*********',
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
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    __.passwordError =
                                        'Please enter your password';
                                    return '';
                                  } else {
                                    if (__.incorrectPassword == true) {
                                      __.passwordError =
                                          'Oh no! Your credentials don\'t match!';
                                      return '';
                                    }
                                    __.passwordError = null;
                                    return null; // No error
                                  }
                                },
                              ),
                              if (__.passwordError != null) ...[
                                height8,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      color: Colors.red.shade600,
                                      size: 20,
                                    ),
                                    width5,
                                    Center(
                                      child: Text(
                                        __.passwordError!,
                                        style: TextStyle(
                                            color: Colors.red.shade600),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  ),
                                ),
                              ),
                              // height20,
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Divider(
                              //         color: Colors.grey.shade400,
                              //       ),
                              //     ),
                              //     width20,
                              //     Text(
                              //       'OR',
                              //       style: TextStyle(
                              //         fontSize: 18,
                              //         fontWeight: FontWeight.w200,
                              //         color: Theme.of(context).indicatorColor,
                              //         fontFamily: 'sofia',
                              //       ),
                              //     ),
                              //     width20,
                              //     Expanded(
                              //       child: Divider(
                              //         color: Colors.grey.shade400,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // height20,
                              // if (Platform.isIOS) ...[
                              //   SocialButton(
                              //     title: 'Sign in with Apple',
                              //     icon: Icons.apple,
                              //     onTap: () async {
                              //       await __.signInWithApple();
                              //       profile.fetchProfile(
                              //           username: prefs_username!);
                              //     },
                              //   )
                              // ],
                              // if (Platform.isAndroid) ...[
                              //   SocialButton(
                              //     title: 'Sign in with Google',
                              //     icon: UniconsLine.google,
                              //     onTap: () async {
                              //       await __.signInWithGoogle();
                              //       profile.fetchProfile(
                              //         username: prefs_username!,
                              //       );
                              //     },
                              //   )
                              // ]
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // isKeyboardShowing ? shrink : LoginNav()
                  Padding(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 32, bottom: 32),
                    child: Column(
                      children: [
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
                          AuthButtonWithColor(
                            onTap: () async {
                              if (__.loginFormKey.currentState!.validate()) {
                                await __.login(
                                  email: __.email.text,
                                  password: __.password.text,
                                );
                                profile.fetchProfile(
                                  username: prefs_username!,
                                );
                              }
                            },
                            isGradient: __.email.text.isNotEmpty &&
                                __.password.text.isNotEmpty,
                            title: 'Continue',
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
