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
  late final int pageId;
  late final String nameAr;
  late final String nameEn;
  late final String navigationKey;
  late final String icon;
  late final bool isFastScreen;
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
