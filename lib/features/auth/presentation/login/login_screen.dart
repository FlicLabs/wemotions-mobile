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
    
    return Consumer<AuthProvider>(
      builder: (_, auth, __) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                auth.emailError = null;
                auth.passwordError = null;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, size: 28, color: Colors.black87),
              splashRadius: 24,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextButton(
                  onPressed: () {
                    auth.emailError = null;
                    auth.passwordError = null;
                    Navigator.pop(context);
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  child: Text(
                    'Sign Up',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: AppTextStyle.normalSemiBold28Black.copyWith(
                        color: Theme.of(context).focusColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Join the conversation and connect with your community",
                      style: AppTextStyle.subheadlineMedium.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    SizedBox(height: 24),
                    Form(
                      key: auth.loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextLabel("Email or Username"),
                          AuthTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Enter your email or username',
                            controller: auth.email,
                          ),
                          if (auth.emailError != null) _buildErrorMessage(auth.emailError!),
                          SizedBox(height: 20),

                          _buildTextLabel("Password"),
                          AuthTextFormField(
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: '*********',
                            obscureText: auth.obscureText,
                            controller: auth.password,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                auth.obscureText = !auth.obscureText;
                              },
                              child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: auth.obscureText
                                    ? Icon(Icons.visibility_off, key: ValueKey(1))
                                    : Icon(Icons.visibility, key: ValueKey(2)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                auth.passwordError = 'Please enter your password';
                                return '';
                              } else {
                                if (auth.incorrectPassword == true) {
                                  auth.passwordError = 'Credentials don\'t match';
                                  return '';
                                }
                                auth.passwordError = null;
                                return null;
                              }
                            },
                          ),
                          if (auth.passwordError != null) _buildErrorMessage(auth.passwordError!),
                          SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isKeyboardShowing ? 10 : 40),

                    // Login Button with Loading Indicator
                    AuthButtonWithColor(
                      onTap: () async {
                        if (auth.loginFormKey.currentState!.validate()) {
                          auth.setLoading(true);
                          await auth.login(
                            email: auth.email.text,
                            password: auth.password.text,
                          );
                          profile.fetchProfile(username: prefs_username!);
                          auth.setLoading(false);
                        }
                      },
                      isGradient: auth.email.text.isNotEmpty && auth.password.text.isNotEmpty,
                      title: auth.isLoading ? null : 'Continue',
                      child: auth.isLoading
                          ? SizedBox(height: 24, width: 24, child: CircularProgressIndicator())
                          : null,
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 32),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Label for input fields
  Widget _buildTextLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyle.labelMedium.copyWith(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Error Message Widget
  Widget _buildErrorMessage(String error) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.red.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.error_outline_rounded, color: Colors.red.shade600, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                error,
                style: TextStyle(color: Colors.red.shade800, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
