import 'package:erp_system/core/models/menu_model/pages.dart';

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
