import 'export.dart';

class WeMotions extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const WeMotions({Key? key, this.initialLink}) : super(key: key);

  @override
  State<WeMotions> createState() => _WeMotionsState();
}

class _WeMotionsState extends State<WeMotions> {
  @override
  void initState() {
    super.initState();
    fetchSubverse();
    fetchFeed();
    fetchProfile();
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

  initNotifications() {
    Provider.of<NotificationProvider>(context, listen: false).initialize();
  }

  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Consumer<ThemeProvider>(
      builder: (_, __, ___) {
        return MaterialApp(
          themeMode: __.selectedThemeMode,
          theme: theme.getTheme(),
          darkTheme: Constants.darkTheme,
          navigatorKey: navKey,
          scaffoldMessengerKey: rootKey,
          title: 'WeMotions',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: onboard == false
              ? WelcomeScreen.routeName
              : BottomNavBar.routeName,
          routes: {
            BottomNavBar.routeName: (context) {
              return BottomNavBar(initialLink: widget.initialLink);
            }
          },
        );
      },
    );
  }
}
