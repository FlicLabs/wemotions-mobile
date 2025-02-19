class Category {
  Category({
    required this.id,
    required this.name,
    required this.count,
    this.description,
    required this.imageUrl,
    this.isSubscriptionRequired,
    this.productSubscriptionAmount,
    this.productId,
    this.isPrivate,
    this.hasAccess,
    this.standaloneAppDeeplink,
  });
  late final int id;
  late final String name;
  late final int count;
  late final String? description;
  late final String imageUrl;
  late final bool? isSubscriptionRequired;
  late final int? productSubscriptionAmount;
  late final String? productId;
  late final bool? isPrivate;
  late final bool? hasAccess;
  late String? standaloneAppDeeplink;

  static var empty = Category(
    id: 0,
    name: '',
    count: 0,
    imageUrl: '',
    description: '',
    isSubscriptionRequired: false,
    productSubscriptionAmount: 0,
    productId: '',
    isPrivate: false,
    hasAccess: false,
    standaloneAppDeeplink: '',
  );

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    description = json['description'];
    imageUrl = json['image_url'];
    isSubscriptionRequired = json['is_subscription_required'];
    productSubscriptionAmount = json['product_subscription_amount'];
    standaloneAppDeeplink = json['standalone_app_deeplink'];
    productId = json['product_id'];
    isPrivate = json['is_private'];
    hasAccess = json['has_access'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['count'] = count;
    _data['description'] = description;
    _data['image_url'] = imageUrl;
    _data['is_subscription_required'] = isSubscriptionRequired;
    _data['product_subscription_amount'] = productSubscriptionAmount;
    _data['standalone_app_deeplink'] = standaloneAppDeeplink;
    _data['product_id'] = productId;
    _data['is_private'] = isPrivate;
    _data['has_access'] = hasAccess;
    return _data;
  }
}
