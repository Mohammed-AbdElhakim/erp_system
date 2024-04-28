class Pages {
  Pages({
    required this.pageId,
    required this.nameAr,
    required this.nameEn,
    required this.navigationKey,
    required this.icon,
    required this.isFastScreen,
    required this.moduleID,
    required this.url,
    required this.tableSrc,
    required this.editSrc,
    required this.controllerName,
    required this.primary,
    required this.orderBy,
    required this.isDesc,
  });
  late final int pageId;
  late final String nameAr;
  late final String nameEn;
  late final String navigationKey;
  late final String icon;
  late final bool isFastScreen;
  late final int moduleID;
  late final String url;
  late final String tableSrc;
  late final String editSrc;
  late final String controllerName;
  late final String primary;
  late final String orderBy;
  late final bool isDesc;

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    navigationKey = json['navigationKey'];
    icon = json['icon'];
    isFastScreen = json['isFastScreen'];
    moduleID = json['moduleID'];
    url = json['url'];
    tableSrc = json['tableSrc'];
    editSrc = json['editSrc'];
    controllerName = json['controllerName'];
    primary = json['primary'];
    orderBy = json['orderBy'];
    isDesc = json['isDesc'];
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
    data['Url'] = url;
    data['tableSrc'] = tableSrc;
    data['editSrc'] = editSrc;
    data['controllerName'] = controllerName;
    data['primary'] = primary;
    data['orderBy'] = orderBy;
    data['isDesc'] = isDesc;
    return data;
  }
}
