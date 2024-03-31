import 'list_module.dart';

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
