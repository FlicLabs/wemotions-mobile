

import 'package:socialverse/features/chat/domain/models/group_model.dart';
import 'package:socialverse/features/chat/domain/models/members_model.dart';

class GroupMemberModel {
  GroupMemberModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final Data data;

  GroupMemberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.group,
    required this.members,
  });
  late final List<Group> group;
  late final List<Members> members;

  Data.fromJson(Map<String, dynamic> json) {
    group = List.from(json['group']).map((e) => Group.fromJson(e)).toList();
    members =
        List.from(json['members']).map((e) => Members.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['group'] = group.map((e) => e.toJson()).toList();
    _data['members'] = members.map((e) => e.toJson()).toList();
    return _data;
  }
}
