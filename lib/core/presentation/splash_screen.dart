import 'package:socialverse/export.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({Key? key, this.initialLink}) : super(key: key);

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => SplashScreen(),
    );
  }

  final PendingDynamicLinkData? initialLink;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchSubverse();
    fetchFeed();
    fetchProfile();
    connectToWebSocket();
    loadUserInfo();
  }

  fetchSubverse() async {
    final subverse = Provider.of<SearchProvider>(context, listen: false);
    await [
      subverse.getSubversePosts(id: subverse_id),
      subverse.getSubverseInfo(id: subverse_id),
    ];
  }

  fetchFeed() async {
    final home = Provider.of<HomeProvider>(context, listen: false);
    await home.createIsolate(token: token);
  }

  fetchProfile() async {
    if (prefs_username == null || prefs_username != '') {
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      await profile.fetchProfile(username: prefs_username!);
    }
  }

  connectToWebSocket() async {
    if (logged_in!) {
      if (gc_member!) {
        final chat = Provider.of<ChatProvider>(context, listen: false);
        await chat.connect(token!);
      }
    }
  }

  initNotifications() {
    Provider.of<NotificationProvider>(context, listen: false).initialize();
  }

  loadUserInfo() async {
    Future.delayed(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacementNamed(
        BottomNavBar.routeName,
        arguments: BottomNavBarArgs(initialLink: widget.initialLink),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.darkThemeBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: CustomTweenAnimation(
              begin: 0,
              end: 1,
              child: SizedBox(
                height: 250,
                width: 250,
                child: Image.asset(
                  AppAsset.icon,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
