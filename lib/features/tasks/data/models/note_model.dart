class NoteModel {
  int? empID;
  String? note;
  String? nDate;
  int? taskID;
  int? tNID;
  String? fileUrl;
  bool? isOwner;

  NoteModel(
      {this.empID,
        this.note,
        this.nDate,
        this.taskID,
        this.tNID,
        this.fileUrl,
        this.isOwner});

  NoteModel.fromJson(Map<String, dynamic> json) {
    empID = json['EmpID'];
    note = json['Note'];
    nDate = json['NDate'];
    taskID = json['TaskID'];
    tNID = json['TNID'];
    fileUrl = json['FileUrl'];
    isOwner = json['IsOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmpID'] = empID;
    data['Note'] = note;
    data['NDate'] = nDate;
    data['TaskID'] = taskID;
    data['TNID'] = tNID;
    data['FileUrl'] = fileUrl;
    data['IsOwner'] = isOwner;
    return data;
  }
}
