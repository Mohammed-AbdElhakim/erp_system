import 'package:erp_system/features/home/data/models/menu_model/pages.dart';
import 'package:hive/hive.dart';

part 'list_module.g.dart';

@HiveType(typeId: 1)
class ListModule {
  ListModule({
    required this.moduleID,
    required this.moduleKey,
    required this.moduleNameAr,
    required this.moduleNameEn,
    required this.pages,
  });
  @HiveField(0)
  late final int moduleID;
  @HiveField(1)
  late final String moduleKey;
  @HiveField(2)
  late final String moduleNameAr;
  @HiveField(3)
  late final String moduleNameEn;
  @HiveField(4)
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
