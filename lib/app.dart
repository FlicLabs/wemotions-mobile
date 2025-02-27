
import 'package:socialverse/core/presentation/welcome_screen.dart';

import 'core/configs/route_generator/custom_router.dart';
import 'core/widgets/bottom_nav_bar.dart';
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
    fetchSubverse();
    initNotifications();
    fetchActivity();
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


    // await home.getVotings();




    print("=======================");
    print(reply.posts.map((e) => e.username).toList());

  }


  fetchProfile() async {
    if (prefs_username == null || prefs_username != '') {
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      await profile.fetchProfile(username: prefs_username!);
    }
  }

  fetchSubverse() async {
    final subverse = Provider.of<SearchProvider>(context, listen: false);
    await subverse.getSubversePosts();
  }

  fetchActivity() async {
    if (logged_in!) {
      await Provider.of<NotificationProvider>(context, listen: false)
          .fetchActivity();

    }
  }

  initNotifications() async{
    await Provider.of<NotificationProvider>(context, listen: false).initialize();

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
          // initialRoute: logged_in! ? BottomNavBar.routeName : WelcomeScreen.routeName,
          initialRoute: BottomNavBar.routeName,

          // home: WelcomeScreen(),
          routes: {
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
          BottomNavBar.routeName:(context) => BottomNavBar()},
        );
      },
    );
  }
}
