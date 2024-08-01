class ChartMasterModel {
  List<ChartMasterData>? dynamicList;
  int? numberofrecords;

  ChartMasterModel({this.dynamicList, this.numberofrecords});

  ChartMasterModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <ChartMasterData>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(ChartMasterData.fromJson(v));
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

class ChartMasterData {
  int? id;
  String? arName;
  String? tableOrView;
  String? enName;
  bool? isVisible;
  String? labelName;
  String? x;
  String? name;
  String? value;
  String? type;
  bool? isCompany;

  ChartMasterData(
      {this.id,
      this.arName,
      this.tableOrView,
      this.enName,
      this.isVisible,
      this.labelName,
      this.x,
      this.name,
      this.value,
      this.type,
      this.isCompany});

  ChartMasterData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    arName = json['ArName'] ?? "";
    tableOrView = json['TableOrView'];
    enName = json['EnName'] ?? "";
    isVisible = json['IsVisible'] ?? false;
    labelName = json['LabelName'];
    x = json['X'];
    name = json['Name'];
    value = json['Value'];
    type = json['Type'] ?? "";
    isCompany = json['IsCompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ArName'] = arName;
    data['TableOrView'] = tableOrView;
    data['EnName'] = enName;
    data['IsVisible'] = isVisible;
    data['LabelName'] = labelName;
    data['X'] = x;
    data['Name'] = name;
    data['Value'] = value;
    data['Type'] = type;
    data['IsCompany'] = isCompany;
    return data;
  }
}
