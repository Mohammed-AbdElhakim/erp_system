import 'graph_sections_model.dart';
import 'news_sections_model.dart';
import 'numbers_sections_model.dart';
import 'percentage_sections_model.dart';
import 'tables_sections_model.dart';

class DashboardModel {
  DashboardModel({
    required this.list,
  });
  late final MyList list;

  DashboardModel.fromJson(Map<String, dynamic> json) {
    list = MyList.fromJson(json['list']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['list'] = list.toJson();
    return data;
  }
}

class MyList {
  MyList({
    required this.percentageSections,
    required this.numbersSections,
    required this.newsSections,
    required this.graphSections,
    required this.tablesSections,
  });
  late final List<PercentageSectionsModel> percentageSections;
  late final List<NumbersSectionsModel> numbersSections;
  late final List<NewsSectionsModel> newsSections;
  late final List<GraphSectionsModel> graphSections;
  late final List<TablesSectionsModel> tablesSections;

  MyList.fromJson(Map<String, dynamic> json) {
    percentageSections = List.from(json['PercentageSections'])
        .map((e) => PercentageSectionsModel.fromJson(e))
        .toList();
    numbersSections = List.from(json['NumbersSection'])
        .map((e) => NumbersSectionsModel.fromJson(e))
        .toList();
    newsSections = List.from(json['NewsSection'])
        .map((e) => NewsSectionsModel.fromJson(e))
        .toList();
    graphSections = List.from(json['GraphSections'])
        .map((e) => GraphSectionsModel.fromJson(e))
        .toList();
    tablesSections = List.from(json['TablesSections'])
        .map((e) => TablesSectionsModel.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PercentageSections'] =
        percentageSections.map((e) => e.toJson()).toList();
    data['NumbersSection'] = numbersSections.map((e) => e.toJson()).toList();
    data['NewsSection'] = newsSections.map((e) => e.toJson()).toList();
    data['GraphSections'] = graphSections.map((e) => e.toJson()).toList();
    data['TablesSections'] = tablesSections.map((e) => e.toJson()).toList();
    return data;
  }
}
