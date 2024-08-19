import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/chat/domain/models/member_model.dart';
import 'package:socialverse/features/chat/domain/models/members_model.dart';
import 'package:socialverse/features/chat/domain/models/message_model.dart';
import 'package:socialverse/features/chat/domain/models/received_model.dart';
import 'package:socialverse/features/chat/domain/services/chat_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatProvider with ChangeNotifier {
  //ChatProvider() { init(); }
  final notification = getIt<NotificationProvider>();
  final nav = getIt<BottomNavBarProvider>();
  late WebSocketChannel channel;
  final _service = ChatService();
  final controller = ScrollController();
  final focusNode = FocusNode();

  List<Messages> _messages = <Messages>[];
  List<Messages> get messages => _messages;

  List<Members> _members = <Members>[];
  List<Members> get members => _members;

  final _message = TextEditingController();
  TextEditingController get message => _message;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  bool _isFetchingOlderMessages = false;
  bool get isFetchingOlderMessages => _isFetchingOlderMessages;

  bool _isScrollingUp = false;
  bool get isScrollingUp => _isScrollingUp;

  bool _loading = false;
  bool get loading => _loading;

  set isScrollingUp(bool value) {
    _isScrollingUp = value;
    notifyListeners();
  }

  bool _isTextEmpty = true;
  bool get isTextEmpty => _isTextEmpty;

  void updateText(String newText) {
    _isTextEmpty = newText.trim().isEmpty;
    notifyListeners();
  }

  int _page = 1;
  int get page => _page;

  set page(int value) {
    _page = value;
    notifyListeners();
  }

  double _lastScrollPosition = 0.0;
  double get lastScrollPosition => _lastScrollPosition;

  set lastScrollPosition(double value) {
    _lastScrollPosition = value;
    notifyListeners();
  }

  bool _scrolledToBottom = false;
  bool get scrolledToBottom => _scrolledToBottom;

  set scrolledToBottom(bool value) {
    _scrolledToBottom = value;
    notifyListeners();
  }

  final _pingInterval = Duration(seconds: 30);
  Duration get pingInterval => _pingInterval;

  String? _route_name;
  String? get route_name => _route_name;

  // void init() async {}

  connect(String token) async {
    channel = WebSocketChannel.connect(Uri.parse(API.socket + token));
    await channel.ready;
    fetchMessages();
    fetchGroupMembers();
    channel.stream.listen(
      (data) {
        log('incoming message:' + data);
        Map<String, dynamic> jsonData = jsonDecode(data);
        //log('incoming message:' + jsonData['type']);
        if (jsonData['type'] == 'heartbeat' ||
            jsonData['type'] == 'onlineStatus') {
          return;
        }

        if (jsonData['type'] == 'groupChat') {
          final incomingMessage = ReceivedModel.fromJson(jsonData);
          Messages messageObj = incomingMessage.toMessages();
          _messages.add(messageObj);
          notification.show(
            title: 'Vible Community',
            body: messageObj.message,
            username: messageObj.sender.username,
            imageUrl: messageObj.sender.profileUrl,
            chat_id: messageObj.id,
            type: NotificationType.push,
            chat_type: jsonData['type'],
          );
          //log('add message to list');
          notifyListeners();
        }
      },
    );

    Timer.periodic(pingInterval, (Timer timer) {
      if (channel.closeCode == null) {
        //log('ping socket');
        channel.sink.add(jsonEncode({"type": "heartbeat"}));
        notifyListeners();
      } else {
        log('cancel timer');
        timer.cancel();
      }
    });
  }

  Future<void> sendMessage() async {
    Map data = {
      "type": "groupChat",
      "group_id": group_id,
      "message_text": message.text.trim(),
    };
    log('${data}');
    await channel.ready;
    channel.sink.add(jsonEncode(data));
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    String formatted = formatter.format(now);
    _addLocalMessage(message.text, formatted);
    message.clear();
    notifyListeners();
  }

  Future<void> fetchGroupMembers() async {
    _loading = true;
    notifyListeners();
    Response response = await _service.fetchGroupMembers(id: group_id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final members = GroupMemberModel.fromJson(response.data).data.members;
      _members = members;
      _loading = false;
      notifyListeners();
    } else {}
  }

  String? getCurrentRouteName() {
    if (navKey.currentState != null && navKey.currentContext != null) {
      log('navKey: get name');
      ModalRoute? modalRoute = ModalRoute.of(navKey.currentContext!);
      _route_name = modalRoute?.settings.name;
      log('nav: ${_route_name}');
      return _route_name;
    }
    return null;
  }

  String formatUsernames(List<Members> members) {
    if (members.isEmpty) return 'No members';
    String result = members.map((member) => member.username).join(', ');
    return result;
  }

  void _addLocalMessage(String messageText, String sentAt) {
    final newMessage = ReceivedModel(
      sender: Sender(
        username: prefs_username,
      ),
      messageText: messageText,
      sentAt: sentAt,
    );

    Messages messageObj = newMessage.toMessages();
    _messages.add(messageObj);
    notifyListeners();
  }

  Future<void> fetchMessages() async {
    Response response = await _service.getMessages(page: page);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = MessageModel.fromJson(response.data).messages;
      _messages.addAll(message.reversed.toList());
      notifyListeners();
    } else {}
  }

  Future<void> fetchOlderMessages() async {
    if (_isFetchingOlderMessages) return;
    _isFetchingOlderMessages = true;

    try {
      // final oldScrollExtent = controller.position.maxScrollExtent;

      Response response = await _service.getMessages(page: page);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = MessageModel.fromJson(response.data).messages;
        _messages.insertAll(0, message.reversed.toList());
        notifyListeners();

        // await Future.delayed(Duration(milliseconds: 100));
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   final newScrollExtent = controller.position.maxScrollExtent;
        //   final difference = newScrollExtent - oldScrollExtent;

        //   final newPosition = math.min(controller.offset + difference,
        //       controller.position.maxScrollExtent);
        //   controller.jumpTo(newPosition);
        // });
      } else {}
    } catch (e) {
    } finally {
      _isFetchingOlderMessages = false;
    }
  }

  Future<void> joinGroupChat() async {
    HapticFeedback.mediumImpact();
    Map data = {
      "group_id": group_id,
    };

    Response response = await _service.joinGroupChat(data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      notification.show(
        type: NotificationType.local,
        title: 'Welcome to the Vible Community' + '${prefs_username}!',
      );
      prefs!.setBool("gc_member", true);
      gc_member = prefs?.getBool('gc_member') ?? false;
      log('member: ${gc_member}');
      await connect(token!);
      await fetchMessages();
      notifyListeners();
    } else {}
  }
}
