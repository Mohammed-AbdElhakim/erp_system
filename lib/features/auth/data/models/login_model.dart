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
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['employeeID'] = employeeID;
    _data['companyID'] = companyID;
    _data['companyName'] = companyName;
    _data['userName'] = userName;
    return _data;
  }
}
