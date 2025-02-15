import 'export.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

final rootKey = GlobalKey<ScaffoldMessengerState>();
final navKey = GlobalKey<NavigatorState>();

String? prefs_username;
String? prefs_email;
String? pincode;
String? token;
bool? logged_in;
ThemeMode? themeMode;
bool? onboard;
bool? gc_member;
bool? isFirstExit;
int subverse_id = 2;
int group_id = 1;
String? prefs_address;
String? prefs_network;
SharedPreferences? prefs;

const String appGroupId = 'group.vible';
const String iOSWidgetName = 'VibleWidgets';
const String androidWidgetName = 'VibleWidgets';

ThemeMode getThemeMode(String themeModeString) {
  switch (themeModeString) {
    case 'ThemeMode.light':
      return ThemeMode.light;
    case 'ThemeMode.dark':
      return ThemeMode.dark;
    case 'ThemeMode.system':
      return ThemeMode.system;
    default:
      return ThemeMode.system;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  HomeWidget.setAppGroupId(appGroupId);

  prefs = await SharedPreferences.getInstance();
  prefs_username = prefs?.getString('username') ?? '';
  prefs_email = prefs?.getString('email') ?? '';
  pincode = prefs?.getString('pincode') ?? '';
  onboard = prefs?.getBool('onboard') ?? false;
  isFirstExit = prefs?.getBool('exit') ?? false;
  token = prefs?.getString('token') ?? '';  // Removed unnecessary await
  logged_in = prefs?.getBool('logged_in') ?? false;
  gc_member = prefs?.getBool('gc_member') ?? false;

  NetworkDio.setDynamicHeader(endPoint: API.endpoint);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  String mode = prefs.getString('themeMode') ?? 'ThemeMode.system';
  themeMode = getThemeMode(mode);
  bool isDarkMode = mode == 'ThemeMode.dark';

  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  const MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _getProviders(),
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(
          isDarkMode ? Constants.darkTheme : Constants.lightTheme,
        ),
        child: WeMotions(),
      ),
    );
  }

  List<ChangeNotifierProvider> _getProviders() {
    return [
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
      ChangeNotifierProvider(create: (_) => ReportProvider()),
      ChangeNotifierProvider(create: (_) => CreateSubverseProvider()),
      ChangeNotifierProvider(create: (_) => EditSubverseProvider()),
      ChangeNotifierProvider(create: (_) => EditProfileProvider()),
      ChangeNotifierProvider(create: (_) => AccountProvider()),
      ChangeNotifierProvider(create: (_) => InviteProvider()),
      ChangeNotifierProvider(create: (_) => QrCodeProvider()),
      ChangeNotifierProvider(create: (_) => ExitProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => ReplyProvider()),
    ];
  }
}

