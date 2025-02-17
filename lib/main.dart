import 'export.dart';

@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

final rootKey = GlobalKey<ScaffoldMessengerState>();
final navKey = GlobalKey<NavigatorState>();

late SharedPreferences prefs;

String? prefsUsername, prefsEmail, pincode, token, prefsAddress, prefsNetwork;
bool? loggedIn, onboard, gcMember, isFirstExit;
ThemeMode? themeMode;
int subverseId = 2;
int groupId = 1;

const String appGroupId = 'group.vible';
const String iOSWidgetName = 'VibleWidgets';
const String androidWidgetName = 'VibleWidgets';

ThemeMode getThemeMode(String themeModeString) {
  return {
    'ThemeMode.light': ThemeMode.light,
    'ThemeMode.dark': ThemeMode.dark,
    'ThemeMode.system': ThemeMode.system,
  }[themeModeString] ?? ThemeMode.system;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  HomeWidget.setAppGroupId(appGroupId);
  prefs = await SharedPreferences.getInstance();

  _loadPreferences();
  NetworkDio.setDynamicHeader(endPoint: API.endpoint);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  bool isDarkMode = themeMode == ThemeMode.dark;
  runApp(MyApp(isDarkMode: isDarkMode));
}

void _loadPreferences() {
  prefsUsername = prefs.getString('username') ?? '';
  prefsEmail = prefs.getString('email') ?? '';
  pincode = prefs.getString('pincode') ?? '';
  onboard = prefs.getBool('onboard') ?? false;
  isFirstExit = prefs.getBool('exit') ?? false;
  token = prefs.getString('token') ?? '';
  loggedIn = prefs.getBool('logged_in') ?? false;
  gcMember = prefs.getBool('gc_member') ?? false;

  String mode = prefs.getString('themeMode') ?? 'ThemeMode.system';
  themeMode = getThemeMode(mode);
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
    final providerList = [
      AuthProvider(),
      HomeProvider(),
      SearchProvider(),
      VideoProvider(),
      CommentProvider(),
      CameraProvider(),
      PostProvider(),
      SettingsProvider(),
      SubscriptionProvider(),
      ProfileProvider(),
      UserProfileProvider(),
      BottomNavBarProvider(),
      ReportProvider(),
      CreateSubverseProvider(),
      EditSubverseProvider(),
      EditProfileProvider(),
      AccountProvider(),
      InviteProvider(),
      QrCodeProvider(),
      ExitProvider(),
      NotificationProvider(),
      ReplyProvider(),
    ];

    return providerList.map((provider) => ChangeNotifierProvider(create: (_) => provider)).toList();
  }
}


