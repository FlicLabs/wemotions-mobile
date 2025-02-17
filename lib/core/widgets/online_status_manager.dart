import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OnlineStatusManager extends StatefulWidget {
  final Widget child;
  final String flicToken;

  const OnlineStatusManager({
    Key? key,
    required this.child,
    required this.flicToken,
  }) : super(key: key);

  @override
  _OnlineStatusManagerState createState() => _OnlineStatusManagerState();
}

class _OnlineStatusManagerState extends State<OnlineStatusManager> with WidgetsBindingObserver {
  bool _isOnline = false;
  final Dio _dio = Dio(BaseOptions(followRedirects: false));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _goOnline();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _goOffline();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _goOnline();
    } else if (state == AppLifecycleState.paused) {
      _goOffline();
    }
  }

  void _goOnline() {
    if (!_isOnline) {
      _isOnline = true;
      _sendOnlineStatus(true);
    }
  }

  void _goOffline() {
    if (_isOnline) {
      _isOnline = false;
      _sendOnlineStatus(false);
    }
  }

  Future<void> _sendOnlineStatus(bool isOnline) async {
    try {
      final response = await _dio.post(
        '${API.endpoint}/user/isonline',
        data: {'is_online': isOnline},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Flic-Token': widget.flicToken,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("Online status updated successfully: ${response.data}");
      } else {
        debugPrint("Failed to update online status. Status code: ${response.statusCode}");
      }
    } on DioError catch (e) {
      debugPrint("Error sending online status: ${e.message}");
      debugPrint("Response Code: ${e.response?.statusCode}");
      debugPrint("Response Message: ${e.response?.statusMessage}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
