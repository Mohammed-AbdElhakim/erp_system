class AllTimeModel {
  String? oldDate;
  String? requestedDate;
  String? newDate;
  bool? isAccepted;
  int? taskID;
  int? empID;
  int? acceptedEmpID;
  String? description;
  String? emp;
  String? acceptedEmp;
  int? tTLID;
  bool? isOwner;

  AllTimeModel(
      {this.oldDate,
        this.requestedDate,
        this.newDate,
        this.isAccepted,
        this.taskID,
        this.empID,
        this.acceptedEmpID,
        this.description,
        this.emp,
        this.acceptedEmp,
        this.tTLID,
        this.isOwner});

  AllTimeModel.fromJson(Map<String, dynamic> json) {
    oldDate = json['OldDate'];
    requestedDate = json['RequestedDate'];
    newDate = json['NewDate'];
    isAccepted = json['IsAccepted'];
    taskID = json['TaskID'];
    empID = json['EmpID'];
    acceptedEmpID = json['AcceptedEmpID'];
    description = json['Description'];
    emp = json['Emp'];
    acceptedEmp = json['AcceptedEmp'];
    tTLID = json['TTLID'];
    isOwner = json['IsOwner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OldDate'] = oldDate;
    data['RequestedDate'] = requestedDate;
    data['NewDate'] = newDate;
    data['IsAccepted'] = isAccepted;
    data['TaskID'] = taskID;
    data['EmpID'] = empID;
    data['AcceptedEmpID'] = acceptedEmpID;
    data['Description'] = description;
    data['Emp'] = emp;
    data['AcceptedEmp'] = acceptedEmp;
    data['TTLID'] = tTLID;
    data['IsOwner'] = isOwner;
    return data;
  }
}
