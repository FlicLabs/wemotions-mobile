import 'package:socialverse/export.dart';

class ReceivedModel {
  ReceivedModel({
    required this.sender,
    required this.messageText,
    required this.sentAt,
  });
  late final Sender sender;
  late final String messageText;
  late final String sentAt;

  ReceivedModel.fromJson(Map<String, dynamic> json) {
    sender = Sender.fromJson(json['sender']);
    messageText = json['message_text'];
    sentAt = json['sent_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sender'] = sender.toJson();
    _data['message_text'] = messageText;
    _data['sent_at'] = sentAt;
    return _data;
  }

  Messages toMessages() {
    return Messages(
      sender: sender,
      message: messageText,
      sentAt: sentAt,
    );
  }
}
