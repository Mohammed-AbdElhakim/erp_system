class AddNewTimeModel {
  int? tTLID;
  String? requestedDate;
  bool? isAccepted;
  int? taskID;
  int? empID;
  String? description;
  Emp? emp;

  AddNewTimeModel(
      {this.tTLID,
        this.requestedDate,
        this.isAccepted,
        this.taskID,
        this.empID,
        this.description,
        this.emp});

  AddNewTimeModel.fromJson(Map<String, dynamic> json) {
    tTLID = json['TTLID'];
    requestedDate = json['RequestedDate'];
    isAccepted = json['IsAccepted'];
    taskID = json['TaskID'];
    empID = json['EmpID'];
    description = json['Description'];
    emp = json['Emp'] != null ? Emp.fromJson(json['Emp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TTLID'] = tTLID;
    data['RequestedDate'] = requestedDate;
    data['IsAccepted'] = isAccepted;
    data['TaskID'] = taskID;
    data['EmpID'] = empID;
    data['Description'] = description;
    if (emp != null) {
      data['Emp'] = emp!.toJson();
    }
    return data;
  }
}

class Emp {
  int? employeeID;
  String? employeeNameA;
  bool? isActive;
  String? username;
  String? passWord;
  int? groupID;
  bool? isEngineer;
  bool? languageDir;
  String? fingerID;
  String? startDate;
  int? authGroup;
  int? isManager;
  String? birthdate;
  String? imageUrl;
  String? rout;
  String? lastDateProcess;
  bool? isAbsence;
  bool? isLate;
  String? empIndexString;
  int? empAutoCode;

  Emp(
      {this.employeeID,
        this.employeeNameA,
        this.isActive,
        this.username,
        this.passWord,
        this.groupID,
        this.isEngineer,
        this.languageDir,
        this.fingerID,
        this.startDate,
        this.authGroup,
        this.isManager,
        this.birthdate,
        this.imageUrl,
        this.rout,
        this.lastDateProcess,
        this.isAbsence,
        this.isLate,
        this.empIndexString,
        this.empAutoCode,
        });

  Emp.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    employeeNameA = json['EmployeeNameA'];
    isActive = json['IsActive'];
    username = json['Username'];
    passWord = json['PassWord'];
    groupID = json['GroupID'];
    isEngineer = json['IsEngineer'];
    languageDir = json['LanguageDir'];
    fingerID = json['FingerID'];
    startDate = json['StartDate'];
    authGroup = json['AuthGroup'];
    isManager = json['IsManager'];
    birthdate = json['Birthdate'];
    imageUrl = json['ImageUrl'];
    rout = json['Rout'];
    lastDateProcess = json['LastDateProcess'];
    isAbsence = json['IsAbsence'];
    isLate = json['IsLate'];
    empIndexString = json['EmpIndexString'];
    empAutoCode = json['EmpAutoCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeID'] = employeeID;
    data['EmployeeNameA'] = employeeNameA;
    data['IsActive'] = isActive;
    data['Username'] = username;
    data['PassWord'] = passWord;
    data['GroupID'] = groupID;
    data['IsEngineer'] = isEngineer;
    data['LanguageDir'] = languageDir;
    data['FingerID'] = fingerID;
    data['StartDate'] = startDate;
    data['AuthGroup'] = authGroup;
    data['IsManager'] = isManager;
    data['Birthdate'] = birthdate;
    data['ImageUrl'] = imageUrl;
    data['Rout'] = rout;
    data['LastDateProcess'] = lastDateProcess;
    data['IsAbsence'] = isAbsence;
    data['IsLate'] = isLate;
    data['EmpIndexString'] = empIndexString;
    data['EmpAutoCode'] = empAutoCode;

    return data;
  }
}
