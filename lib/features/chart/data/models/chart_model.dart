class ChartModel {
  List<Map<String, dynamic>>? dynamicList;
  int? numberofrecords;

  ChartModel({this.dynamicList, this.numberofrecords});

  ChartModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <Map<String, dynamic>>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(v);
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (dynamicList != null) {
      data['dynamicList'] = dynamicList!.map((v) => v).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}
