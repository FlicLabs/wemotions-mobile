import 'package:socialverse/features/profile/domain/models/users_model.dart';

class ActiveUsersModel {
  ActiveUsersModel({
    required this.status,
    required this.message,
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.users,
  });

  late final String status;
  late final String message;
  late final String page;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Users> users;
  
  ActiveUsersModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    page = json['page'];
    maxPageSize = json['max_page_size'];
    pageSize = json['page_size'];
    users = List.from(json['users']).map((e)=>Users.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['page'] = page;
    _data['max_page_size'] = maxPageSize;
    _data['page_size'] = pageSize;
    _data['users'] = users.map((e)=>e.toJson()).toList();
    return _data;
  }
}