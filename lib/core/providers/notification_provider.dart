import 'package:socialverse/core/domain/models/notification_model.dart';
import 'package:socialverse/core/domain/models/notifications_model.dart';
import 'package:socialverse/core/domain/models/payload_model.dart';
import 'package:socialverse/core/widgets/overlay_notification.dart';
import 'package:socialverse/export.dart';
import 'package:dio/dio.dart';

enum NotificationType { push, local }

class NotificationProvider extends ChangeNotifier {
  final _service = FirebaseMessagingService();

  OverlayEntry? _overlayEntry;
  Timer? _dismissTimer;

  String? _deviceToken;
  String? get deviceToken => _deviceToken;

  List<Notifications> _notifications = <Notifications>[];
  List<Notifications> get notifications => _notifications;

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
    dismiss(); // Ensure no duplicate notifications

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
    _startDismissTimer();
  }

  void dismiss() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _dismissTimer?.cancel();
    } catch (e) {
      print("Error dismissing notification: $e");
    }
  }

  void _startDismissTimer() {
    _dismissTimer?.cancel();
    _dismissTimer = Timer(Duration(seconds: 6), dismiss);
  }

  void toggleFollowing(int index) {
    HapticFeedback.mediumImpact();
    final actor = _notifications[index].actor;
    if (actor?.isFollowing != null) {
      actor!.isFollowing = !actor.isFollowing!;
      notifyListeners();
    }
  }

  Future<void> initialize() async {
    final settings = await _service.setupPushNotifications();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
        print('User tapped on the notification');
      });
    }
  }

  Future<void> getToken() async {
    _deviceToken = await _service.getToken();
    print('Device Token: $_deviceToken');
    notifyListeners();
  }

  Future<void> fetchActivity() async {
    try {
      Response response = await _service.fetchActivity();
      if (response.statusCode == 200 || response.statusCode == 201) {
        _notifications = NotificationModel.fromJson(response.data).notifications;
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching notifications: $e");
    }
  }
}

