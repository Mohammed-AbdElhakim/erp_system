class GetEmployeesModel {
  int? tEID;
  int? taskID;
  int? employeeID;
  bool? isMain;
  Employee? employee;

  GetEmployeesModel(
      {this.tEID, this.taskID, this.employeeID, this.isMain, this.employee});

  GetEmployeesModel.fromJson(Map<String, dynamic> json) {
    tEID = json['TEID'];
    taskID = json['TaskID'];
    employeeID = json['EmployeeID'];
    isMain = json['IsMain'];
    employee = json['Employee'] != null
        ? Employee.fromJson(json['Employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TEID'] = tEID;
    data['TaskID'] = taskID;
    data['EmployeeID'] = employeeID;
    data['IsMain'] = isMain;
    if (employee != null) {
      data['Employee'] = employee!.toJson();
    }
    return data;
  }
}

class Employee {
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

  Employee(
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

  Employee.fromJson(Map<String, dynamic> json) {
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
