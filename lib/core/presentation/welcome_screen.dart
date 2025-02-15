import 'package:socialverse/export.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => const WelcomeScreen(),
    );
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => fetchFeed()); // Ensure fetchFeed runs after build
  }

  Future<void> fetchFeed() async {
    try {
      final home = Provider.of<HomeProvider>(context, listen: false);
      final token = await _getToken(); // Fetch token properly
      if (token != null) {
        await home.createIsolate(token: token);
      }
    } catch (e) {
      debugPrint("Error fetching feed: $e");
    }
  }

  Future<String?> _getToken() async {
    // Fetch token from SharedPreferences, API, or Provider
    return prefs?.getString('authToken');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false, // Prevent back navigation
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Swipe Up',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Curated customized video feed which does not maximize its extraction of you, but the empowerment of you',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                      ),
                      Center(
                        child: Image.asset(AppAsset.vible, height: 515),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TransparentButton(
                    title: 'Get Empowered',
                    onTap: () async {
                      await prefs?.setBool('onboard', true); // Ensure data is saved
                      if (mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          BottomNavBar.routeName,
                          (route) => false,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
