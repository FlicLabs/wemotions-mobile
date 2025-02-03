import 'package:socialverse/export.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  const OnboardingScreen({super.key});

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (_, __, ___) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
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
            height: cs.height(context),
            width: cs.width(context),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: SvgPicture.asset(
                        AppAsset.onboardingHero,
                        height: 367,
                        width: 390,
                        // color: Theme.of(context).hintColor,
                      ),
                    ),
                    // height40,
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Start the Dialogue with",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).indicatorColor,
                              fontFamily: 'sofia',
                            ),
                          ),
                          Text(
                            "Voice & Video",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).indicatorColor,
                              fontFamily: 'sofia',
                            ),
                          ),
                        ],
                      ),
                    ),
                    height8,
                    Text(
                      "Kick off conversations by sharing your thoughts with voice or video. Move beyond text and express yourself in a way that truly connects. ",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).indicatorColor,
                        fontFamily: 'sofia',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    height30,
                    if (__.loggedInAuthStatus != AuthStatus.Authenticating) ...[
                      AuthButtonWithColor(
                        onTap: () async {
                          Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName);
                        },
                        title: 'Sign up',
                        isGradient: true,
                      ),
                    ],
                    height16,
                    if (__.loggedInAuthStatus == AuthStatus.Authenticating) ...[
                      SizedBox(
                        height: 45,
                        width: 45,
                        child: CustomProgressIndicator(),
                      )
                    ],
                    if (__.loggedInAuthStatus != AuthStatus.Authenticating) ...[
                      AuthButtonWithBorder(
                        onTap: () async {
                          Navigator.of(context)
                              .pushNamed(LoginScreen.routeName);
                        },
                        title: 'Login',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
