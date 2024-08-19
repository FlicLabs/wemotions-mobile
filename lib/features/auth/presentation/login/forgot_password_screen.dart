import 'package:socialverse/export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = '/forgot-password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return CupertinoPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ForgotPasswordScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Consumer<AuthProvider>(
        builder: (_, __, ____) {
          return SafeArea(
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: __.emailFK,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAsset.icon,
                            height: 180,
                            width: cs().width(context) / 2,
                            color: Theme.of(context).indicatorColor,
                          ),
                          Text(
                            "Please enter your registered email\nwe'll send further instructions on that.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          height40,
                          AuthTextFormField(
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'Email',
                            controller: __.email,
                            validator: (String? v) {
                              if (v!.isValidEmail) {
                                return null;
                              } else {
                                return 'Please enter your email';
                              }
                            },
                          ),
                          height40,
                          if (!__.isLoading) ...[
                            AuthButton(
                              title: 'Send',
                              onTap: () async {
                                if (__.emailFK.currentState!.validate()) {
                                  await __.reset();
                                }
                              },
                            ),
                          ],
                          if (__.isLoading) ...[
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: const CustomProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
