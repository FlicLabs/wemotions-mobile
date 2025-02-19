class SubverseSearchModel {
  SubverseSearchModel({
    required this.id,
    required this.name,
    required this.count,
    required this.description,
    required this.imageUrl,
    required this.isPrivate,
    required this.hasAccess,
  });
  late final int id;
  late final String name;
  late final int count;
  late final String description;
  late final String imageUrl;
  late final bool isPrivate;
  late final bool hasAccess;

  SubverseSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    count = json['count'] ?? 0;
    description = json['description'] ?? '';
    imageUrl = json['image_url'] ?? '';
    isPrivate = json['is_private'] ?? false;
    hasAccess = json['has_access'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['count'] = count;
    _data['description'] = description;
    _data['image_url'] = imageUrl;
    _data['is_private'] = isPrivate;
    _data['has_access'] = hasAccess;
    return _data;
  }
}
