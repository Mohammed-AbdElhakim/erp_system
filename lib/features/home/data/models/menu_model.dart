class MenuModel {
  MenuModel({
    required this.list,
  });
  late final List<ListModule> list;

  MenuModel.fromJson(Map<String, dynamic> json) {
    list = List.from(json['list']).map((e) => ListModule.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.map((e) => e.toJson()).toList();
    return data;
  }
}

class ListModule {
  ListModule({
    required this.moduleID,
    required this.moduleKey,
    required this.moduleNameAr,
    required this.moduleNameEn,
    required this.pages,
  });
  late final int moduleID;
  late final String moduleKey;
  late final String moduleNameAr;
  late final String moduleNameEn;
  late final List<Pages> pages;

  ListModule.fromJson(Map<String, dynamic> json) {
    moduleID = json['moduleID'];
    moduleKey = json['moduleKey'];
    moduleNameAr = json['moduleNameAr'];
    moduleNameEn = json['moduleNameEn'];
    pages = List.from(json['pages']).map((e) => Pages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['moduleID'] = moduleID;
    data['moduleKey'] = moduleKey;
    data['moduleNameAr'] = moduleNameAr;
    data['moduleNameEn'] = moduleNameEn;
    data['pages'] = pages.map((e) => e.toJson()).toList();
    return data;
  }
}

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
