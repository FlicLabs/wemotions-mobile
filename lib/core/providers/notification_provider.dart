import 'dart:developer';

import 'package:socialverse/core/domain/models/payload_model.dart';
import 'package:socialverse/export.dart';
import 'package:dio/dio.dart';
import '../domain/services/messaging_service.dart';
import '../widgets/overlay_notification.dart';

enum NotificationType { push, local }

class NotificationProvider extends ChangeNotifier {
  final _service = FirebaseMessagingService();

  // final notification = getIt<NotificationProvider>();

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


  toggleFollowing(int index) {
    HapticFeedback.mediumImpact();
    if (_notifications[index].actor != null) {
      if (_notifications[index].actor.isFollowing != null) {
        _notifications[index].actor.isFollowing =
            !_notifications[index].actor.isFollowing!;
        notifyListeners();
      }
    }
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

        // if (message.data['type'] == 'privateChat') {
        //   navKey.currentState!.pushNamed(ChatScreen.routeName);
        // }
      });
    }
  }

  Future<void> getToken() async {
    final deviceToken = await _service.getToken();
    _deviceToken = deviceToken;
    print('${_deviceToken}');
    notifyListeners();
  }

  void handleNotification(RemoteMessage message) {}

  Future<void> fetchActivity() async {
    try {
      Response response = await _service.fetchActivity();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final notifications =
            NotificationModel
                .fromJson(response.data)
                .notifications;
        _notifications.addAll(notifications.toList());
        notifyListeners();
      } else {}
    }catch (e){

      final errorMessage = e.toString().replaceAll('Exception: ', '');

      this.show(
        title: errorMessage,
        type: NotificationType.local,
      );
      log('$errorMessage in fetchActivity');
    }
  }

  Future<void> deleteActivity({required int postId, bool notifyUser = false}) async{
    try {
      Response response = await _service.deleteNotification(postId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if(notifyUser) {

          this.show(
            title: response.data['message'],
            type: NotificationType.local,
          );
        }

      } else{}
    }catch (e){

      final errorMessage = e.toString().replaceAll('Exception: ', '');

      this.show(
        title: errorMessage,
        type: NotificationType.local,
      );

      log(errorMessage);

    }
  }
}
