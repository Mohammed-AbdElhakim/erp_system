class ChartModel {
  List<DynamicList>? dynamicList;
  int? numberofrecords;

  ChartModel({this.dynamicList, this.numberofrecords});

  ChartModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <DynamicList>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(DynamicList.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class DynamicList {
  String? name;
  int? value;
  String? x;

  DynamicList({this.name, this.value, this.x});

  DynamicList.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    value = json['value'];
    x = json['x'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['value'] = value;
    data['x'] = x;
    return data;
  }
}
