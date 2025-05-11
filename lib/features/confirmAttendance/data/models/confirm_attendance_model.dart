import 'project_model.dart';

class ConfirmAttendanceModel {
  int? groupID;
  String? groupName;
  int? gSID;
  int? settingID;
  String? startDate;
  String? endDate;
  int? dayID;
  String? startTime;
  String? endTime;
  int? employeeID;
  int? machineID;
  String? employeeNameA;
  String? settingName;
  bool? isCheck;
  ProjectItem? selectedProject;

  ConfirmAttendanceModel({
    this.groupID,
    this.groupName,
    this.gSID,
    this.settingID,
    this.startDate,
    this.endDate,
    this.dayID,
    this.startTime,
    this.endTime,
    this.employeeID,
    this.machineID,
    this.employeeNameA,
    this.settingName,
    this.isCheck,
  });

  ConfirmAttendanceModel.fromJson(Map<String, dynamic> json) {
    groupID = json['GroupID'];
    groupName = json['GroupName'];
    gSID = json['GSID'];
    settingID = json['SettingID'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    dayID = json['DayID'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    employeeID = json['EmployeeID'];
    machineID = json['MachineID'];
    employeeNameA = json['EmployeeNameA'];
    settingName = json['SettingName'];
    isCheck = json['isCheck'];
    selectedProject = json['selectedProject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GroupID'] = groupID;
    data['GroupName'] = groupName;
    data['GSID'] = gSID;
    data['SettingID'] = settingID;
    data['StartDate'] = startDate;
    data['EndDate'] = endDate;
    data['DayID'] = dayID;
    data['StartTime'] = startTime;
    data['EndTime'] = endTime;
    data['EmployeeID'] = employeeID;
    data['MachineID'] = machineID;
    data['EmployeeNameA'] = employeeNameA;
    data['SettingName'] = settingName;
    data['isCheck'] = isCheck;
    data['selectedProject'] = selectedProject;
    return data;
  }
}
