import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';

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
  // Timer? _heartbeatTimer;
  bool _isOnline = false;

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
    setState(() => _isOnline = true);
    _sendOnlineStatus(true);
    // _startHeartbeat();
  }

  void _goOffline() {
    setState(() => _isOnline = false);
    _sendOnlineStatus(false);
    // _stopHeartbeat();
  }

  // void _startHeartbeat() {
  //   _heartbeatTimer = Timer.periodic(Duration(minutes: 1), (timer) {
  //     _sendOnlineStatus(true);
  //   });
  // }

  // void _stopHeartbeat() {
  //   _heartbeatTimer?.cancel();
  //   _heartbeatTimer = null;
  // }

  Future<void> _sendOnlineStatus(bool isOnline) async {
    try {
      Dio dio = new Dio(BaseOptions(followRedirects: false));
      print('${API.endpoint}/user/isonline');
      print(token);
      Response response = await dio.post(
        '${API.endpoint}user/isonline',
        data: {'is_online': isOnline},
        options: Options(headers: {'Content-Type': 'application/json','Flic-Token': widget.flicToken,}),
      );

      if (response.statusCode == 200) {
        print(response.data);
      } else {
        print('Failed to update online status. Status code: ${response.statusCode}');
      }
    } on DioError catch (e){
      print('Error sending online status: $e');
      print(e.response?.statusCode);
      print(e.response?.statusMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}