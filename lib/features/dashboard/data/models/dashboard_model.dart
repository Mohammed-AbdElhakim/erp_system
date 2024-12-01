

import 'news_sections_model.dart';
import 'numbers_sections_model.dart';
import 'percentage_sections_model.dart';

class DashboardModel {
  DashboardModel({
    required this.list,
  });
  late final MyList list;

  DashboardModel.fromJson(Map<String, dynamic> json){
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
  });
  late final List<PercentageSectionsModel> percentageSections;
  late final List<NumbersSectionsModel> numbersSections;
  late final List<NewsSectionsModel> newsSections;

  MyList.fromJson(Map<String, dynamic> json){
    percentageSections = List.from(json['PercentageSections']).map((e)=>PercentageSectionsModel.fromJson(e)).toList();
    numbersSections = List.from(json['NumbersSection']).map((e)=>NumbersSectionsModel.fromJson(e)).toList();
    newsSections = List.from(json['NewsSection']).map((e)=>NewsSectionsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['PercentageSections'] = percentageSections.map((e)=>e.toJson()).toList();
    data['NumbersSection'] = numbersSections.map((e)=>e.toJson()).toList();
    data['NewsSection'] = newsSections.map((e)=>e.toJson()).toList();
    return data;
  }
}



