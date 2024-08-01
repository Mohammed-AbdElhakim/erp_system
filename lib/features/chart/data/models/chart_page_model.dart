class ChartPageModel {
  List<ChartPageData>? dynamicList;
  int? numberofrecords;

  ChartPageModel({this.dynamicList, this.numberofrecords});

  ChartPageModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <ChartPageData>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(ChartPageData.fromJson(v));
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

class ChartPageData {
  int? id;
  int? pageId;
  int? chartId;

  ChartPageData({this.id, this.pageId, this.chartId});

  ChartPageData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pageId = json['PageId'];
    chartId = json['ChartId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PageId'] = pageId;
    data['ChartId'] = chartId;
    return data;
  }
}
