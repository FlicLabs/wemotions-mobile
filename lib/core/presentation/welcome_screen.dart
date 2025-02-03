import 'package:socialverse/export.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => WelcomeScreen(),
    );
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchFeed();
  }

  fetchFeed() async {
    final home = Provider.of<HomeProvider>(context, listen: false);
    await home.createIsolate(token: token);
    final theme = Provider.of<ThemeProvider>(context, listen: false);
    theme.setSelectedThemeMode(ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    print("${isDarkTheme}+++++++++++++");

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: [

              Image.asset('assets/images/imagePicker.png',
                fit: BoxFit.cover,),
              Positioned(
                  right: 10,
                  top: 50,
                  child: CustomTextButton(title: 'Log in', onTap: (){
                    goToLogIn(context);
                  }),
              ),
            ],
          ),
          bottomSheet: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 0, bottom: 40, right: 0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: Theme.of(context).canvasColor,
              ),
              child: SizedBox(
                height: cs.height(context)/2.3,
                width: cs.width(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0,left: 20,right:20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Think..Record..Engage",
                          style: AppTextStyle.ultraLarge,)
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              "Get Started with just a few quick taps. Jump right into engaging conversations and connect with others effortlessly,no delays or hassle.",style: AppTextStyle.bodyMedium,)),
                      height15,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TransparentButton(
                          title: 'Dive into WeMotions',
                          color: Constants.primaryColor,
                          isBorder: false,
                          textColor: Constants.lightPrimary,
                          onTap: () async {
                            prefs?.setBool('onboard', true);
                            goToHomeWithoutRegister(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,left: 8,right: 8),
                        child: CustomTransparentButton(
                          title: 'Sign up',
                          color: Theme.of(context).canvasColor,
                          textColor: Theme.of(context).indicatorColor,
                          // isBorder: true,
                          borderColor: Theme.of(context).indicatorColor,
                          onTap: () async {
                            // prefs?.setBool('onboard', true);
                            goToSignUp(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  goToSignUp(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  goToLogIn(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  goToHomeWithoutRegister(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(
      context,
      BottomNavBar.routeName,
          (route) => false,
    );
  }


}
