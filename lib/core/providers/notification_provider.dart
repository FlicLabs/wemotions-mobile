import 'package:socialverse/core/domain/models/payload_model.dart';
import 'package:socialverse/core/widgets/overlay_notification.dart';
import 'package:socialverse/export.dart';

enum NotificationType { push, local }

class NotificationProvider extends ChangeNotifier {
  final _service = FirebaseMessagingService();

  OverlayEntry? _overlayEntry;
  Timer? _dismissTimer;

  String? _deviceToken;
  String? get deviceToken => _deviceToken;

  PayloadModel? _payload;
  PayloadModel? get payload => _payload;

  void show({
    required String? title,
    String? body,
    String? username,
    String? imageUrl,
    int? chat_id,
    String? chat_type,
    required NotificationType type,
  }) {
    if (_overlayEntry != null) {
      // Prevent duplicate notifications
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => OverlayNotification(
        title: title,
        body: body,
        chat_id: chat_id,
        imageUrl: imageUrl,
        username: username,
        type: type,
        chatType: chat_type,
        onDismiss: dismiss,
      ),
    );

    navKey.currentState?.overlay?.insert(_overlayEntry!);
    // Start a timer to automatically dismiss the notification
    _startDismissTimer();
  }

  void dismiss() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _dismissTimer?.cancel();
    print("OverlayEntry dismissed and removed");
  }

  void _startDismissTimer() {
    _dismissTimer?.cancel();
    _dismissTimer = Timer(Duration(seconds: 6), dismiss);
  }

  Future<void> initialize() async {
    final settings = await _service.setupPushNotifications();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Handle the incoming message when the app is in the foreground.
        print('Handling a foreground message ${message.notification?.body}');
        print('Handling a foreground message ${message.notification?.title}');
        print('Handling a foreground message ${message.data['type']}');
        print('Handling a message opened app ${json.encode(message.toMap())}');

        final String jsonString = json.encode(message.toMap());
        final Map<String, dynamic> responseData = json.decode(jsonString);
        PayloadModel payload = PayloadModel.fromJson(responseData);

        if (message.data['type'] == 'privateChat') {
          HapticFeedback.mediumImpact();
          show(
            type: NotificationType.push,
            title: payload.notification.title,
            body: payload.notification.body,
            username: payload.data.mixture.userData.username,
            imageUrl: payload.data.mixture.userData.profileUrl,
            chat_id: int.parse(payload.data.id),
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // Handle the incoming message when the user taps on the notification.
        print('Handling a message opened app ${message.notification?.body}');
        print('Handling a message opened app ${message.notification?.title}');
        print('Handling a message opened app ${message.toMap()}');

        // final String jsonString = json.encode(message.toMap());
        // final Map<String, dynamic> responseData = json.decode(jsonString);
        // PayloadModel payload = PayloadModel.fromJson(responseData);

        if (message.data['type'] == 'privateChat') {
          navKey.currentState!.pushNamed(ChatScreen.routeName);
        }
      });
    }

    // if (logged_in!) {
    //   await getToken();

    //   Map data = {
    //     'device-type': Platform.isIOS ? 'ios' : 'android',
    //     'device-token': _deviceToken,
    //   };

    //   _service.sendDeviceToken(data: data);

    //   FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
    //     log('Token refreshed: $token');
    //     _deviceToken = token;
    //     _service.sendDeviceToken(data: data);
    //     notifyListeners();
    //   });
    // }
  }

  Future<void> getToken() async {
    final deviceToken = await _service.getToken();
    _deviceToken = deviceToken;
    print('${_deviceToken}');
    // if (Platform.isIOS) {
    //   final apnsToken = await _service.getAPNSToken();
    //   _deviceToken = apnsToken;
    //   print('${apnsToken}');
    // } else {
    //   final deviceToken = await _service.getToken();
    //   _deviceToken = deviceToken;
    //   print('${_deviceToken}');
    // }
    notifyListeners();
  }

  void handleNotification(RemoteMessage message) {}
}
