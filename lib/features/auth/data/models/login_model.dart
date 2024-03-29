class LoginModel {
  LoginModel({
    required this.token,
    required this.employeeID,
    required this.companyID,
    required this.companyName,
    required this.userName,
  });
  late final String token;
  late final String employeeID;
  late final String companyID;
  late final String companyName;
  late final String userName;

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    employeeID = json['employeeID'];
    companyID = json['companyID'];
    companyName = json['companyName'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['employeeID'] = employeeID;
    data['companyID'] = companyID;
    data['companyName'] = companyName;
    data['userName'] = userName;
    return data;
  }
}
