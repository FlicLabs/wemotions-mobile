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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Swipe Up',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 30, color: Colors.black),
                        ),
                        height10,
                        Text(
                          'Curated customized video feed which does not maximize its extraction of you, but the empowerment of you',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: Colors.black),
                        ),
                        Center(
                          child: Image.asset(AppAsset.vible, height: 515),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TransparentButton(
                      title: 'Get Empowered',
                      onTap: () async {
                        prefs?.setBool('onboard', true);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          BottomNavBar.routeName,
                          (route) => false,
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
