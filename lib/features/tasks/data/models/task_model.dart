class TaskModel {
  Parent? parent;
  List<Parent>? children;

  TaskModel({this.parent, this.children});

  TaskModel.fromJson(Map<String, dynamic> json) {
    parent = json['Parent'] != null ? Parent.fromJson(json['Parent']) : null;
    if (json['Children'] != null) {
      children = <Parent>[];
      json['Children'].forEach((v) {
        children!.add(Parent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (parent != null) {
      data['Parent'] = parent!.toJson();
    }
    if (children != null) {
      data['Children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parent {
  bool? isDone;
  bool? onProgress;
  bool? isMConfirmed;
  double? progress;
  String? empPremissions;
  String? empPermissionNames;
  String? conParentName;
  int? allSibling;
  int? tID;
  String? tName;
  String? tDescription;
  String? createdDate;
  String? startDate;
  String? endDate;
  int? doneOrder;
  int? startOrder;
  String? actualStartDate;
  String? actualEndDate;
  String? taskIndex;
  int? tlevel;
  int? createdEmployeeID;
  int? taskOrder;
  int? typeID;
  int? comID;
  int? tTID;
  String? tTName;

  Parent(
      {this.isDone,
      this.onProgress,
      this.isMConfirmed,
      this.progress,
      this.empPremissions,
      this.empPermissionNames,
      this.conParentName,
      this.allSibling,
      this.tID,
      this.tName,
      this.tDescription,
      this.createdDate,
      this.startDate,
      this.endDate,
      this.doneOrder,
      this.startOrder,
      this.actualStartDate,
      this.actualEndDate,
      this.taskIndex,
      this.tlevel,
      this.createdEmployeeID,
      this.taskOrder,
      this.typeID,
      this.comID,
      this.tTID,
      this.tTName});

  Parent.fromJson(Map<String, dynamic> json) {
    isDone = json['IsDone'] ?? false;
    onProgress = json['OnProgress'] ?? false;
    isMConfirmed = json['IsMConfirmed'] ?? false;
    progress = json['progress'];
    empPremissions = json['EmpPremissions'];
    empPermissionNames = json['EmpPermissionNames'];
    conParentName = json['ConParentName'];
    allSibling = json['allSibling'];
    tID = json['TID'];
    tName = json['TName'];
    tDescription = json['TDescription'] ?? "";
    createdDate = json['CreatedDate'];
    startDate = json['StartDate'] ?? "";
    endDate = json['EndDate'] ?? "";
    doneOrder = json['DoneOrder'];
    startOrder = json['StartOrder'];
    actualStartDate = json['ActualStartDate'];
    actualEndDate = json['ActualEndDate'];
    taskIndex = json['TaskIndex'];
    tlevel = json['Tlevel'];
    createdEmployeeID = json['CreatedEmployeeID'];
    taskOrder = json['TaskOrder'];
    typeID = json['TypeID'];
    comID = json['ComID'];
    tTID = json['TTID'];
    tTName = json['TTName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsDone'] = isDone;
    data['OnProgress'] = onProgress;
    data['IsMConfirmed'] = isMConfirmed;
    data['progress'] = progress;
    data['EmpPremissions'] = empPremissions;
    data['EmpPermissionNames'] = empPermissionNames;
    data['ConParentName'] = conParentName;
    data['allSibling'] = allSibling;
    data['TID'] = tID;
    data['TName'] = tName;
    data['TDescription'] = tDescription;
    data['CreatedDate'] = createdDate;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['DoneOrder'] = doneOrder;
    data['StartOrder'] = startOrder;
    data['ActualStartDate'] = actualStartDate;
    data['ActualEndDate'] = actualEndDate;
    data['TaskIndex'] = taskIndex;
    data['Tlevel'] = tlevel;
    data['CreatedEmployeeID'] = createdEmployeeID;
    data['TaskOrder'] = taskOrder;
    data['TypeID'] = typeID;
    data['ComID'] = comID;
    data['TTID'] = tTID;
    data['TTName'] = tTName;
    return data;
  }
}
