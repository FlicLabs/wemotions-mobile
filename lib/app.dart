import 'export.dart';

class HolyVible extends StatelessWidget {
  final PendingDynamicLinkData? initialLink;
  const HolyVible({Key? key, this.initialLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),
        ChangeNotifierProvider(create: (_) => CommentProvider()),
        ChangeNotifierProvider(create: (_) => CameraProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => UserProfileProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => CreateSubverseProvider()),
        ChangeNotifierProvider(create: (_) => EditSubverseProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileProvider()),
        ChangeNotifierProvider(create: (_) => AccountProvider()),
        ChangeNotifierProvider(create: (_) => InviteProvider()),
        ChangeNotifierProvider(create: (_) => QrCodeProvider()),
        ChangeNotifierProvider(create: (_) => ExitProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => SpectrumProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, __, ___) {
          return MaterialApp(
            themeMode: __.selectedThemeMode,
            theme: theme.getTheme(),
            darkTheme: Constants.darkTheme,
            navigatorKey: navKey,
            scaffoldMessengerKey: rootKey,
            title: 'Holy Vible',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: CustomRouter.onGenerateRoute,
            initialRoute: onboard == false
                ? WelcomeScreen.routeName
                : SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) {
                return SplashScreen(initialLink: initialLink);
              }
            },
          );
        },
      ),
    );
  }
}
