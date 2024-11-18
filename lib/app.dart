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
    fetchFeed();
    fetchProfile();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Move the theme provider dependency here
    print(
        'the theme provider data is: ${Provider.of<ThemeProvider>(context).getTheme()}');
  }

  fetchFeed() async {
    final home = Provider.of<HomeProvider>(context, listen: false);
    final reply = Provider.of<ReplyProvider>(context, listen: false);

    await home.createIsolate(token: token);
    await home.getVotings();
    home.fetchingReplies = true;
    await home.createReplyIsolate(0, token: token);
    reply.posts = home.posts[0].sublist(1);
    if (home.posts.length > 1) {
      await home.createReplyIsolate(1, token: token);
    }
    if (home.posts.length > 2) {
      await home.createReplyIsolate(2, token: token);
    }

    // reply.posts = home.posts[0].sublist(1);
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
          initialRoute: BottomNavBar.routeName,
          // onboard == false
          //     ? WelcomeScreen.routeName
          //     : BottomNavBar.routeName,
          routes: {BottomNavBar.routeName: (context) => BottomNavBar()},
        );
      },
    );
  }
}
