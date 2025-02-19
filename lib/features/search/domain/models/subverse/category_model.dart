import 'package:socialverse/export.dart';

class CategoryModel {
  CategoryModel({
    required this.page,
    required this.maxPageSize,
    required this.pageSize,
    required this.categories,
  });
  late final String page;
  late final int maxPageSize;
  late final int pageSize;
  late final List<Category> categories;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    maxPageSize = json['max_page_size'];
    pageSize = json['page_size'];
    categories =
        List.from(json['categories']).map((e) => Category.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['max_page_size'] = maxPageSize;
    _data['page_size'] = pageSize;
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    return _data;
  }
}
