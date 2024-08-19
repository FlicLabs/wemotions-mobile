import 'package:socialverse/export.dart';

class Messages {
  Messages({
    this.id,
    required this.sender,
    required this.message,
    required this.sentAt,
  });

  late final int? id;
  late final dynamic sender;
  late final String message;
  late final String sentAt;

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = Sender.fromJson(json['sender']);
    message = json['message'];
    sentAt = json['sent_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['sender'] = sender.toJson();
    _data['message'] = message;
    _data['sent_at'] = sentAt;
    return _data;
  }
}
