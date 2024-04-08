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

  Pages.fromJson(Map<String, dynamic> json) {
    pageId = json['PageId'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
    navigationKey = json['NavigationKey'];
    icon = json['Icon'];
    isFastScreen = json['IsFastScreen'];
    moduleID = json['ModuleID'];
    url = json['Url'];
    tableSrc = json['TableSrc'];
    editSrc = json['EditSrc'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PageId'] = pageId;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    data['NavigationKey'] = navigationKey;
    data['Icon'] = icon;
    data['IsFastScreen'] = isFastScreen;
    data['ModuleID'] = moduleID;
    data['Url'] = url;
    data['TableSrc'] = tableSrc;
    data['EditSrc'] = editSrc;
    return data;
  }
}
