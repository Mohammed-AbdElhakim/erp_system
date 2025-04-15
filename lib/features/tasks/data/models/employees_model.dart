class EmployeesModel {
  List<EmployeeItemData>? dynamicList;
  int? numberofrecords;

  EmployeesModel({this.dynamicList, this.numberofrecords});

  EmployeesModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      dynamicList = <EmployeeItemData>[];
      json['dynamicList'].forEach((v) {
        dynamicList!.add(EmployeeItemData.fromJson(v));
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

class EmployeeItemData {
  int? employeeID;
  int? empAutoCode;
  String? employeeNameA;
  bool? isActive;
  String? username;
  String? passWord;
  int? groupID;
  bool? isEngineer;
  bool? languageDir;
  String? fingerID;
  String? groupName;
  int? comID;
  String? startDate;
  int? authGroup;
  int? isManager;
  String? empTestAuth;
  int? account;
  String? birthdate;
  String? imageUrl;
  String? rout;
  String? empIndexString;
  int? empIndex;
  int? daysOffCount;
  int? workDaysCount;
  String? employeeState;
  String? stateColor;
  bool? isInsuranced;
  String? insuranceStart;
  String? lastDiscount;
  String? telephone;
  int? directManger;
  String? manger;
  double? fixedSalary;
  bool? isOverTimeAfter;
  bool? isOverTimeBefore;
  bool? isOverTimeDay;
  bool? applyRestrictLogin;

  EmployeeItemData(
      {this.employeeID,
        this.empAutoCode,
        this.employeeNameA,
        this.isActive,
        this.username,
        this.passWord,
        this.groupID,
        this.isEngineer,
        this.languageDir,
        this.fingerID,
        this.groupName,
        this.comID,
        this.startDate,
        this.authGroup,
        this.isManager,
        this.empTestAuth,
        this.account,
        this.birthdate,
        this.imageUrl,
        this.rout,
        this.empIndexString,
        this.empIndex,
        this.daysOffCount,
        this.workDaysCount,
        this.employeeState,
        this.stateColor,
        this.isInsuranced,
        this.insuranceStart,
        this.lastDiscount,
        this.telephone,
        this.directManger,
        this.manger,
        this.fixedSalary,
        this.isOverTimeAfter,
        this.isOverTimeBefore,
        this.isOverTimeDay,
        this.applyRestrictLogin});

  EmployeeItemData.fromJson(Map<String, dynamic> json) {
    employeeID = json['EmployeeID'];
    empAutoCode = json['EmpAutoCode'];
    employeeNameA = json['EmployeeNameA'];
    isActive = json['IsActive'];
    username = json['Username'];
    passWord = json['PassWord'];
    groupID = json['GroupID'];
    isEngineer = json['IsEngineer'];
    languageDir = json['LanguageDir'];
    fingerID = json['FingerID'];
    groupName = json['GroupName'];
    comID = json['ComID'];
    startDate = json['StartDate'];
    authGroup = json['AuthGroup'];
    isManager = json['IsManager'];
    empTestAuth = json['empTestAuth'];
    account = json['account'];
    birthdate = json['Birthdate'];
    imageUrl = json['ImageUrl'];
    rout = json['Rout'];
    empIndexString = json['EmpIndexString'];
    empIndex = json['EmpIndex'];
    daysOffCount = json['DaysOffCount'];
    workDaysCount = json['WorkDaysCount'];
    employeeState = json['EmployeeState'];
    stateColor = json['StateColor'];
    isInsuranced = json['IsInsuranced'];
    insuranceStart = json['InsuranceStart'];
    lastDiscount = json['lastDiscount'];
    telephone = json['Telephone'];
    directManger = json['DirectManger'];
    manger = json['Manger'];
    fixedSalary = json['FixedSalary'];
    isOverTimeAfter = json['IsOverTimeAfter'];
    isOverTimeBefore = json['IsOverTimeBefore'];
    isOverTimeDay = json['IsOverTimeDay'];
    applyRestrictLogin = json['ApplyRestrictLogin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeID'] = employeeID;
    data['EmpAutoCode'] = empAutoCode;
    data['EmployeeNameA'] = employeeNameA;
    data['IsActive'] = isActive;
    data['Username'] = username;
    data['PassWord'] = passWord;
    data['GroupID'] = groupID;
    data['IsEngineer'] = isEngineer;
    data['LanguageDir'] = languageDir;
    data['FingerID'] = fingerID;
    data['GroupName'] = groupName;
    data['ComID'] = comID;
    data['StartDate'] = startDate;
    data['AuthGroup'] = authGroup;
    data['IsManager'] = isManager;
    data['empTestAuth'] = empTestAuth;
    data['account'] = account;
    data['Birthdate'] = birthdate;
    data['ImageUrl'] = imageUrl;
    data['Rout'] = rout;
    data['EmpIndexString'] = empIndexString;
    data['EmpIndex'] = empIndex;
    data['DaysOffCount'] = daysOffCount;
    data['WorkDaysCount'] = workDaysCount;
    data['EmployeeState'] = employeeState;
    data['StateColor'] = stateColor;
    data['IsInsuranced'] = isInsuranced;
    data['InsuranceStart'] = insuranceStart;
    data['lastDiscount'] = lastDiscount;
    data['Telephone'] = telephone;
    data['DirectManger'] = directManger;
    data['Manger'] = manger;
    data['FixedSalary'] = fixedSalary;
    data['IsOverTimeAfter'] = isOverTimeAfter;
    data['IsOverTimeBefore'] = isOverTimeBefore;
    data['IsOverTimeDay'] = isOverTimeDay;
    data['ApplyRestrictLogin'] = applyRestrictLogin;
    return data;
  }
}
