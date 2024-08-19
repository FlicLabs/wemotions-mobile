import 'package:socialverse/export.dart';

class MessageModel {
  MessageModel({
    required this.status,
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.messages,
  });

  late final String status;
  late final int page;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Messages> messages;

  MessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    page = json['page'];
    maxPageSize = json['max_page_size'];
    pageSize = json['page_size'];
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['page'] = page;
    _data['max_page_size'] = maxPageSize;
    _data['page_size'] = pageSize;
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}
