
import 'package:socialverse/core/domain/models/notifications_model.dart';

class NotificationModel {
  NotificationModel({
    required this.status,
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.notifications,
  });

  late final String status;
  late final int page;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Notifications> notifications;

  NotificationModel.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        page = json['page'],
        maxPageSize = json['max_page_size'],
        pageSize = json['page_size'],
        notifications = List<Notifications>.from(
          json['notifications'].map(
            (notification) => Notifications.fromJson(notification),
          ),
        );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'page': page,
      'max_page_size': maxPageSize,
      'page_size': pageSize,
      'notifications': notifications.map((e) => e.toJson()).toList(),
    };
    return data;
  }
}