import 'package:socialverse/export.dart';

class PayloadModel {
  PayloadModel({
    this.senderId,
    this.category,
    required this.collapseKey,
    required this.contentAvailable,
    required this.data,
    required this.from,
    required this.messageId,
    this.messageType,
    required this.mutableContent,
    required this.notification,
    required this.sentTime,
    this.threadId,
    required this.ttl,
  });
  late final Null senderId;
  late final Null category;
  late final String collapseKey;
  late final bool contentAvailable;
  late final Data data;
  late final String from;
  late final String messageId;
  late final Null messageType;
  late final bool mutableContent;
  late final Notification notification;
  late final int sentTime;
  late final Null threadId;
  late final int ttl;

  PayloadModel.fromJson(Map<String, dynamic> json) {
    senderId = null;
    category = null;
    collapseKey = json['collapseKey'];
    contentAvailable = json['contentAvailable'];
    data = Data.fromJson(json['data']);
    from = json['from'];
    messageId = json['messageId'];
    messageType = null;
    mutableContent = json['mutableContent'];
    notification = Notification.fromJson(json['notification']);
    sentTime = json['sentTime'];
    threadId = null;
    ttl = json['ttl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['senderId'] = senderId;
    _data['category'] = category;
    _data['collapseKey'] = collapseKey;
    _data['contentAvailable'] = contentAvailable;
    _data['data'] = data.toJson();
    _data['from'] = from;
    _data['messageId'] = messageId;
    _data['messageType'] = messageType;
    _data['mutableContent'] = mutableContent;
    _data['notification'] = notification.toJson();
    _data['sentTime'] = sentTime;
    _data['threadId'] = threadId;
    _data['ttl'] = ttl;
    return _data;
  }
}

class Data {
  Data({
    required this.mixture,
    required this.id,
    required this.type,
  });
  late final Mixture mixture;
  late final String id;
  late final String type;

  Data.fromJson(Map<String, dynamic> json) {
    // Decode the 'mixture' string into a Map<String, dynamic> before passing to Mixture.fromJson
    var mixtureMap = jsonDecode(json['mixture']);
    mixture = Mixture.fromJson(mixtureMap);
    id = json['id'];
    type = json['type'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mixture'] = mixture.toJson();
    _data['id'] = id;
    _data['type'] = type;
    return _data;
  }
}

class Mixture {
  Mixture({
    required this.userData,
  });
  late final UserData userData;

  Mixture.fromJson(Map<String, dynamic> json) {
    userData = UserData.fromJson(json['userData']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userData'] = userData.toJson();
    return _data;
  }
}

class UserData {
  UserData({
    required this.id,
    required this.username,
    required this.profileUrl,
  });
  late final int id;
  late final String username;
  late final String profileUrl;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    profileUrl = json['profile_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['profile_url'] = profileUrl;
    return _data;
  }
}

class Notification {
  Notification({
    required this.title,
    required this.titleLocArgs,
    this.titleLocKey,
    required this.body,
    required this.bodyLocArgs,
    this.bodyLocKey,
    required this.android,
    this.apple,
    this.web,
  });
  late final String title;
  late final List<dynamic> titleLocArgs;
  late final Null titleLocKey;
  late final String body;
  late final List<dynamic> bodyLocArgs;
  late final Null bodyLocKey;
  late final Android android;
  late final Null apple;
  late final Null web;

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    titleLocArgs = List.castFrom<dynamic, dynamic>(json['titleLocArgs']);
    titleLocKey = null;
    body = json['body'];
    bodyLocArgs = List.castFrom<dynamic, dynamic>(json['bodyLocArgs']);
    bodyLocKey = null;
    android = Android.fromJson(json['android']);
    apple = null;
    web = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['titleLocArgs'] = titleLocArgs;
    _data['titleLocKey'] = titleLocKey;
    _data['body'] = body;
    _data['bodyLocArgs'] = bodyLocArgs;
    _data['bodyLocKey'] = bodyLocKey;
    _data['android'] = android.toJson();
    _data['apple'] = apple;
    _data['web'] = web;
    return _data;
  }
}

class Android {
  Android({
    this.channelId,
    this.clickAction,
    this.color,
    this.count,
    this.imageUrl,
    this.link,
    required this.priority,
    this.smallIcon,
    required this.sound,
    this.ticker,
    this.tag,
    required this.visibility,
  });
  late final Null channelId;
  late final Null clickAction;
  late final Null color;
  late final Null count;
  late final Null imageUrl;
  late final Null link;
  late final int priority;
  late final Null smallIcon;
  late final String sound;
  late final Null ticker;
  late final Null tag;
  late final int visibility;

  Android.fromJson(Map<String, dynamic> json) {
    channelId = null;
    clickAction = null;
    color = null;
    count = null;
    imageUrl = null;
    link = null;
    priority = json['priority'];
    smallIcon = null;
    sound = json['sound'];
    ticker = null;
    tag = null;
    visibility = json['visibility'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['channelId'] = channelId;
    _data['clickAction'] = clickAction;
    _data['color'] = color;
    _data['count'] = count;
    _data['imageUrl'] = imageUrl;
    _data['link'] = link;
    _data['priority'] = priority;
    _data['smallIcon'] = smallIcon;
    _data['sound'] = sound;
    _data['ticker'] = ticker;
    _data['tag'] = tag;
    _data['visibility'] = visibility;
    return _data;
  }
}
