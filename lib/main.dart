import 'package:socialverse/app.dart';
import 'package:socialverse/features/home/providers/nested_provider.dart';
import 'package:socialverse/features/search/providers/video_provider.dart';

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

const String appGroupId = 'group.wemotions';
const String iOSWidgetName = 'WeMotionWidgets';
const String androidWidgetName = 'WeMotionWidgets';

ThemeMode getThemeMode(String themeModeString) {
  switch (themeModeString) {
    case 'ThemeMode.light':
      return themeMode = ThemeMode.light;
    case 'ThemeMode.dark':
      return themeMode = ThemeMode.dark;
    case 'ThemeMode.system':
      return themeMode = ThemeMode.system;
    default:
      return ThemeMode.system;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
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
  token = await prefs?.getString('token') ?? '';
  logged_in = prefs?.getBool('logged_in') ?? false;
  gc_member = prefs?.getBool('gc_member') ?? false;

  NetworkDio.setDynamicHeader(endPoint: API.endpoint);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );


  SharedPreferences.getInstance().then(
        (prefs) {
      var mode = prefs.getString('themeMode') ?? 'ThemeMode.system';
      getThemeMode(mode);
      bool value = mode == 'ThemeMode.dark';
      runApp(
        MultiProvider(
          providers: [

            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
            ChangeNotifierProvider(create: (_) => SmoothPageIndicatorProvider()),
            ChangeNotifierProvider(create: (_) => VideoProvider()),
            ChangeNotifierProvider(create: (_) => CameraProvider()),
            ChangeNotifierProvider(create: (_) => PostProvider()),
            ChangeNotifierProvider(create: (_) => SettingsProvider()),
            ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ChangeNotifierProvider(create: (_) => UserProfileProvider()),
            ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
            ChangeNotifierProvider(create: (_) => ReportProvider()),
            ChangeNotifierProvider(create: (_) => EditProfileProvider()),
            ChangeNotifierProvider(create: (_) => AccountProvider()),
            ChangeNotifierProvider(create: (_) => InviteProvider()),
            ChangeNotifierProvider(create: (_) => QrCodeProvider()),
            ChangeNotifierProvider(create: (_) => ExitProvider()),
            ChangeNotifierProvider(create: (_) => NotificationProvider()),
            ChangeNotifierProvider(create: (_) => ReplyProvider()),
            ChangeNotifierProvider(create: (_) => SearchProvider()),
            ChangeNotifierProvider(create: (_) => ViewVideoProvider()),
            ChangeNotifierProvider(create: (_) => NestedRProvider()),
            ChangeNotifierProvider<ThemeProvider>(
              create: (_) => ThemeProvider(
                value ? Constants.darkTheme : Constants.lightTheme,
              ),
            ),
          ],
          child:  const WeMotions(),
        ),
      );
    },
  );
}
