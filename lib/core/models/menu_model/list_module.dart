import 'pages.dart';

class ListModule {
  ListModule({
    required this.moduleID,
    required this.moduleKey,
    required this.moduleNameAr,
    required this.moduleNameEn,
    required this.pages,
  });
  late final int moduleID;
  late final String? moduleKey;
  late final String moduleNameAr;
  late final String moduleNameEn;
  late final List<Pages> pages;

  ListModule.fromJson(Map<String, dynamic> json) {
    moduleID = json['ModuleID'];
    moduleKey = json['ModuleKey'] ?? '';
    moduleNameAr = json['ModuleNameAr'];
    moduleNameEn = json['ModuleNameEn'];
    pages = List.from(json['Pages']).map((e) => Pages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ModuleID'] = moduleID;
    data['ModuleKey'] = moduleKey;
    data['ModuleNameAr'] = moduleNameAr;
    data['ModuleNameEn'] = moduleNameEn;
    data['Pages'] = pages.map((e) => e.toJson()).toList();
    return data;
  }
}
