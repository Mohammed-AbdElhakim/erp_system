class ProfileModel {
  String? userImageURL;
  String? userName;
  String? companyName;
  double? loansBalance;
  int? daysOffBalance;
  int? attendedDays;
  double? salary;

  ProfileModel(
      {this.userImageURL,
      this.userName,
      this.companyName,
      this.loansBalance,
      this.daysOffBalance,
      this.attendedDays,
      this.salary});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userImageURL = json['UserImageURL'];
    userName = json['UserName'];
    companyName = json['CompanyName'];
    loansBalance = json['LoansBalance'];
    daysOffBalance = json['DaysOffBalance'];
    attendedDays = json['AttendedDays'];
    salary = json['Salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserImageURL'] = userImageURL;
    data['UserName'] = userName;
    data['CompanyName'] = companyName;
    data['LoansBalance'] = loansBalance;
    data['DaysOffBalance'] = daysOffBalance;
    data['AttendedDays'] = attendedDays;
    data['Salary'] = salary;
    return data;
  }
}
