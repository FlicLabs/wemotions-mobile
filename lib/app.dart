import 'export.dart';

class WeMotions extends StatefulWidget {
  const WeMotions({Key? key}) : super(key: key);

  @override
  State<WeMotions> createState() => _WeMotionsState();
}

class _WeMotionsState extends State<WeMotions> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.wait([
      fetchFeed(),
      fetchProfile(),
      fetchSubverse(),
      fetchActivity(),
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        'Theme Provider: ${context.read<ThemeProvider>().getTheme()}');
  }

  Future<void> fetchFeed() async {
    final home = context.read<HomeProvider>();
    final reply = context.read<ReplyProvider>();

    await home.createIsolate(token: token);
    await home.getVotings();

    home.fetchingReplies = true;
    if (home.posts.isNotEmpty) {
      await home.createReplyIsolate(0, token: token);
      reply.posts = home.posts[0].sublist(1);

      for (int i = 1; i < home.posts.length; i++) {
        await home.createReplyIsolate(i, token: token);
      }
    }
  }

  Future<void> fetchProfile() async {
    if (prefs_username?.isNotEmpty == true) {
      await context.read<ProfileProvider>().fetchProfile(username: prefs_username!);
    }
  }

  Future<void> fetchSubverse() async {
    if (logged_in ?? false) {
      await context.read<SearchProvider>().getSubversePosts();
    }
  }

  Future<void> fetchActivity() async {
    if (logged_in ?? false) {
      await context.read<NotificationProvider>().fetchActivity();
    }
  }

  void initNotifications() {
    context.read<NotificationProvider>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) {
        return MaterialApp(
          themeMode: themeProvider.selectedThemeMode,
          theme: themeProvider.getTheme(),
          darkTheme: Constants.darkTheme,
          navigatorKey: navKey,
          scaffoldMessengerKey: rootKey,
          title: 'WeMotions',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: BottomNavBar.routeName,
          routes: {BottomNavBar.routeName: (context) => const BottomNavBar()},
        );
      },
    );
  }
}

