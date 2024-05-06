class TaskModel {
  Parent? parent;
  List<Children>? children;

  TaskModel({this.parent, this.children});

  TaskModel.fromJson(Map<String, dynamic> json) {
    parent =
        json['Parent'] != null ? new Parent.fromJson(json['Parent']) : null;
    if (json['Children'] != null) {
      children = <Children>[];
      json['Children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.parent != null) {
      data['Parent'] = this.parent!.toJson();
    }
    if (this.children != null) {
      data['Children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Parent {
  bool? isDone;
  bool? onProgress;
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
    isDone = json['IsDone'];
    onProgress = json['OnProgress'];
    progress = json['progress'];
    empPremissions = json['EmpPremissions'];
    empPermissionNames = json['EmpPermissionNames'];
    conParentName = json['ConParentName'];
    allSibling = json['allSibling'];
    tID = json['TID'];
    tName = json['TName'];
    tDescription = json['TDescription'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsDone'] = this.isDone;
    data['OnProgress'] = this.onProgress;
    data['progress'] = this.progress;
    data['EmpPremissions'] = this.empPremissions;
    data['EmpPermissionNames'] = this.empPermissionNames;
    data['ConParentName'] = this.conParentName;
    data['allSibling'] = this.allSibling;
    data['TID'] = this.tID;
    data['TName'] = this.tName;
    data['TDescription'] = this.tDescription;
    data['CreatedDate'] = this.createdDate;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['DoneOrder'] = this.doneOrder;
    data['StartOrder'] = this.startOrder;
    data['ActualStartDate'] = this.actualStartDate;
    data['ActualEndDate'] = this.actualEndDate;
    data['TaskIndex'] = this.taskIndex;
    data['Tlevel'] = this.tlevel;
    data['CreatedEmployeeID'] = this.createdEmployeeID;
    data['TaskOrder'] = this.taskOrder;
    data['TypeID'] = this.typeID;
    data['ComID'] = this.comID;
    data['TTID'] = this.tTID;
    data['TTName'] = this.tTName;
    return data;
  }
}

class Children {
  bool? isDone;
  bool? onProgress;
  double? progress;
  String? empPremissions;
  String? empPermissionNames;
  String? conParentName;
  int? allSibling;
  int? tID;
  String? tName;
  String? createdDate;
  int? doneOrder;
  int? startOrder;
  String? taskIndex;
  int? tlevel;
  int? createdEmployeeID;
  int? taskOrder;
  int? typeID;
  int? parentID;
  String? parentName;
  int? comID;
  int? tTID;
  String? tTName;

  Children(
      {this.isDone,
      this.onProgress,
      this.progress,
      this.empPremissions,
      this.empPermissionNames,
      this.conParentName,
      this.allSibling,
      this.tID,
      this.tName,
      this.createdDate,
      this.doneOrder,
      this.startOrder,
      this.taskIndex,
      this.tlevel,
      this.createdEmployeeID,
      this.taskOrder,
      this.typeID,
      this.parentID,
      this.parentName,
      this.comID,
      this.tTID,
      this.tTName});

  Children.fromJson(Map<String, dynamic> json) {
    isDone = json['IsDone'];
    onProgress = json['OnProgress'];
    progress = json['progress'];
    empPremissions = json['EmpPremissions'];
    empPermissionNames = json['EmpPermissionNames'];
    conParentName = json['ConParentName'];
    allSibling = json['allSibling'];
    tID = json['TID'];
    tName = json['TName'];
    createdDate = json['CreatedDate'];
    doneOrder = json['DoneOrder'];
    startOrder = json['StartOrder'];
    taskIndex = json['TaskIndex'];
    tlevel = json['Tlevel'];
    createdEmployeeID = json['CreatedEmployeeID'];
    taskOrder = json['TaskOrder'];
    typeID = json['TypeID'];
    parentID = json['ParentID'];
    parentName = json['ParentName'];
    comID = json['ComID'];
    tTID = json['TTID'];
    tTName = json['TTName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsDone'] = this.isDone;
    data['OnProgress'] = this.onProgress;
    data['progress'] = this.progress;
    data['EmpPremissions'] = this.empPremissions;
    data['EmpPermissionNames'] = this.empPermissionNames;
    data['ConParentName'] = this.conParentName;
    data['allSibling'] = this.allSibling;
    data['TID'] = this.tID;
    data['TName'] = this.tName;
    data['CreatedDate'] = this.createdDate;
    data['DoneOrder'] = this.doneOrder;
    data['StartOrder'] = this.startOrder;
    data['TaskIndex'] = this.taskIndex;
    data['Tlevel'] = this.tlevel;
    data['CreatedEmployeeID'] = this.createdEmployeeID;
    data['TaskOrder'] = this.taskOrder;
    data['TypeID'] = this.typeID;
    data['ParentID'] = this.parentID;
    data['ParentName'] = this.parentName;
    data['ComID'] = this.comID;
    data['TTID'] = this.tTID;
    data['TTName'] = this.tTName;
    return data;
  }
}
