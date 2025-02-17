
import 'package:socialverse/core/domain/models/notifications_model.dart';

class NotificationModel {
  final String status;
  final int page;
  final int maxPageSize;
  final int pageSize;
  final List<Notifications> notifications;

  NotificationModel({
    required this.status,
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      status: json['status'] as String,
      page: json['page'] as int,
      maxPageSize: json['max_page_size'] as int,
      pageSize: json['page_size'] as int,
      notifications: (json['notifications'] as List<dynamic>?)
              ?.map((e) => Notifications.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'page': page,
        'max_page_size': maxPageSize,
        'page_size': pageSize,
        'notifications': notifications.map((e) => e.toJson()).toList(),
      };
}
