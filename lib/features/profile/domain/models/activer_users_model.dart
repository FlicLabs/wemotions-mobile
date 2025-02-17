

import 'package:equatable/equatable.dart';
import 'users_model.dart';

class ActiveUsersModel extends Equatable {
  final String status;
  final String message;
  final String page;
  final int maxPageSize;
  final int pageSize;
  final List<Users> users;

  const ActiveUsersModel({
    required this.status,
    required this.message,
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.users,
  });

  /// Empty instance for default values
  static const empty = ActiveUsersModel(
    status: '',
    message: '',
    page: '',
    maxPageSize: 0,
    pageSize: 0,
    users: [],
  );

  /// Factory constructor for safer JSON parsing
  factory ActiveUsersModel.fromJson(Map<String, dynamic> json) {
    return ActiveUsersModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      page: json['page'] ?? '',
      maxPageSize: json['max_page_size'] ?? 0,
      pageSize: json['page_size'] ?? 0,
      users: (json['users'] as List<dynamic>?)
              ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converts the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'page': page,
      'max_page_size': maxPageSize,
      'page_size': pageSize,
      'users': users.map((e) => e.toJson()).toList(),
    };
  }

  /// Allows modification of specific fields
  ActiveUsersModel copyWith({
    String? status,
    String? message,
    String? page,
    int? maxPageSize,
    int? pageSize,
    List<Users>? users,
  }) {
    return ActiveUsersModel(
      status: status ?? this.status,
      message: message ?? this.message,
      page: page ?? this.page,
      maxPageSize: maxPageSize ?? this.maxPageSize,
      pageSize: pageSize ?? this.pageSize,
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [status, message, page, maxPageSize, pageSize, users];
}
