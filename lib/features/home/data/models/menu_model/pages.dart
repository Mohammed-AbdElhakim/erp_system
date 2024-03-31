import 'package:hive_flutter/hive_flutter.dart';

part 'pages.g.dart';

@HiveType(typeId: 2)
class Pages {
  Pages({
    required this.pageId,
    required this.nameAr,
    required this.nameEn,
    required this.navigationKey,
    required this.icon,
    required this.isFastScreen,
    required this.moduleID,
  });
  @HiveField(0)
  late final int pageId;
  @HiveField(1)
  late final String nameAr;
  @HiveField(2)
  late final String nameEn;
  @HiveField(3)
  late final String navigationKey;
  @HiveField(4)
  late final String icon;
  @HiveField(5)
  late final bool isFastScreen;
  @HiveField(6)
  late final int moduleID;

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    navigationKey = json['navigationKey'];
    icon = json['icon'];
    isFastScreen = json['isFastScreen'];
    moduleID = json['moduleID'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pageId'] = pageId;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['navigationKey'] = navigationKey;
    data['icon'] = icon;
    data['isFastScreen'] = isFastScreen;
    data['moduleID'] = moduleID;
    return data;
  }
}
