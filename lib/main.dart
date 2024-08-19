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
String? owner_id;
SharedPreferences? prefs;

const String appGroupId = 'group.vible';
const String iOSWidgetName = 'VibleWidgets';
const String androidWidgetName = 'VibleWidgets';

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
  owner_id = prefs?.getString('owner_id') ?? '';
  gc_member = prefs?.getBool('gc_member') ?? false;
  await dotenv.load();
  NetworkDio.setDynamicHeader(endPoint: API.endpoint);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  SharedPreferences.getInstance().then(
    (prefs) {
      var mode = prefs.getString('themeMode') ?? 'ThemeMode.system';
      getThemeMode(mode);
      bool value = mode == 'ThemeMode.dark';
      runApp(
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(
            value ? Constants.darkTheme : Constants.lightTheme,
          ),
          builder: (context, child) => HolyVible(initialLink: initialLink),
        ),
      );
    },
  );
}
