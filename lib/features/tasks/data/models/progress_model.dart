class ProgressModel {
  int? empID;
  String? note;
  String? nDate;
  int? taskID;
  int? tPID;
  double? progress;
  String? dateFrom;
  String? dateTo;
  bool? isOwner;

  ProgressModel(
      {this.empID,
        this.note,
        this.nDate,
        this.taskID,
        this.tPID,
        this.progress,
        this.dateFrom,
        this.dateTo,
        this.isOwner});

  ProgressModel.fromJson(Map<String, dynamic> json) {
    empID = json['EmpID'];
    note = json['Note'];
    nDate = json['NDate'];
    taskID = json['TaskID'];
    tPID = json['TPID'];
    progress = json['Proggress'];
    dateFrom = json['DateFrom'];
    dateTo = json['DateTo'];
    isOwner = json['IsOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmpID'] = empID;
    data['Note'] = note;
    data['NDate'] = nDate;
    data['TaskID'] = taskID;
    data['TPID'] = tPID;
    data['Proggress'] = progress;
    data['DateFrom'] = dateFrom;
    data['DateTo'] = dateTo;
    data['IsOwner'] = isOwner;
    return data;
  }
}
