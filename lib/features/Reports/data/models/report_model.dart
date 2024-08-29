class ReportModel {
  int? id;
  String? pivotRepeat;
  String? pivotValue;
  int? pageAttributeId;
  String? reportName;
  String? tailCondition;
  String? listes;
  bool? showVSum;
  bool? sowHSum;
  String? aggrigate;
  List? pivotAuth;
  List? pivotListes;

  ReportModel(
      {this.id,
      this.pivotRepeat,
      this.pivotValue,
      this.pageAttributeId,
      this.reportName,
      this.tailCondition,
      this.listes,
      this.showVSum,
      this.sowHSum,
      this.aggrigate,
      this.pivotAuth,
      this.pivotListes});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    pivotRepeat = json['PivotRepeat'];
    pivotValue = json['PivotValue'];
    pageAttributeId = json['PageAttributeId'];
    reportName = json['ReportName'];
    tailCondition = json['TailCondition'];
    listes = json['listes'];
    showVSum = json['ShowVSum'];
    sowHSum = json['SowHSum'];
    aggrigate = json['Aggrigate'];
    if (json['PivotAuth'] != null) {
      pivotAuth = [];
      json['PivotAuth'].forEach((v) {
        pivotAuth!.add(v);
      });
    }
    if (json['PivotListes'] != null) {
      pivotListes = [];
      json['PivotListes'].forEach((v) {
        pivotListes!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PivotRepeat'] = pivotRepeat;
    data['PivotValue'] = pivotValue;
    data['PageAttributeId'] = pageAttributeId;
    data['ReportName'] = reportName;
    data['TailCondition'] = tailCondition;
    data['listes'] = listes;
    data['ShowVSum'] = showVSum;
    data['SowHSum'] = sowHSum;
    data['Aggrigate'] = aggrigate;
    if (pivotAuth != null) {
      data['PivotAuth'] = pivotAuth!.map((v) => v).toList();
    }
    if (pivotListes != null) {
      data['PivotListes'] = pivotListes!.map((v) => v).toList();
    }
    return data;
  }
}
