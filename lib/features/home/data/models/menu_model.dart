class MenuModel {
  int? pageId;
  String? nameAr;
  String? nameEn;
  String? navigationKey;
  String? icon;
  int? moduleID;
  String? moduleKey;
  String? moduleNameAr;
  String? moduleNameEn;

  MenuModel(
      {this.pageId,
      this.nameAr,
      this.nameEn,
      this.navigationKey,
      this.icon,
      this.moduleID,
      this.moduleKey,
      this.moduleNameAr,
      this.moduleNameEn});

  MenuModel.fromJson(Map<String, dynamic> json) {
    pageId = json['pageId'];
    nameAr = json['nameAr'];
    nameEn = json['nameEn'];
    navigationKey = json['navigationKey'];
    icon = json['icon'];
    moduleID = json['moduleID'];
    moduleKey = json['moduleKey'];
    moduleNameAr = json['moduleNameAr'];
    moduleNameEn = json['moduleNameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageId'] = pageId;
    data['nameAr'] = nameAr;
    data['nameEn'] = nameEn;
    data['navigationKey'] = navigationKey;
    data['icon'] = icon;
    data['moduleID'] = moduleID;
    data['moduleKey'] = moduleKey;
    data['moduleNameAr'] = moduleNameAr;
    data['moduleNameEn'] = moduleNameEn;
    return data;
  }
}
