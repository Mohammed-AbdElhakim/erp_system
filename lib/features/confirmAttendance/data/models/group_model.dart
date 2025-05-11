class GroupModel {
  List<GroupItem>? listGroup;
  int? numberofrecords;

  GroupModel({this.listGroup, this.numberofrecords});

  GroupModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      listGroup = <GroupItem>[];
      json['dynamicList'].forEach((v) {
        listGroup!.add(GroupItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listGroup != null) {
      data['dynamicList'] = listGroup!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class GroupItem {
  int? groupID;
  String? groupName;
  String? groupDescription;
  int? comID;
  int? expncesAccount;
  int? monyAccont;
  int? expectExpencesAcount;
  int? loansAccount;
  double? loansDiscount;
  int? discountAccount;
  String? department;
  double? costItems;
  int? insuranceAccount;
  int? taxAccount;
  int? insuranceCashAccount;
  double? capacity;
  String? lastDateProcess;
  bool? isAbsence;
  bool? isLate;
  bool? isEarlyLeave;
  bool? isPaymentAttendance;
  bool? isPaymentDaily;
  bool? isTotalLate;
  bool? isOverTimeBefore;
  bool? isOverTimeAfter;
  bool? isOverTimeDay;
  bool? isAttendanceWorkShift;
  int? numberOfDays;
  int? numberOfHours;
  int? travelAccount;
  int? endWorkAccount;
  int? vactionAccountID;
  String? endVactionPerYear;
  int? leaveComeAccountID;

  GroupItem(
      {this.groupID,
      this.groupName,
      this.groupDescription,
      this.comID,
      this.expncesAccount,
      this.monyAccont,
      this.expectExpencesAcount,
      this.loansAccount,
      this.loansDiscount,
      this.discountAccount,
      this.department,
      this.costItems,
      this.insuranceAccount,
      this.taxAccount,
      this.insuranceCashAccount,
      this.capacity,
      this.lastDateProcess,
      this.isAbsence,
      this.isLate,
      this.isEarlyLeave,
      this.isPaymentAttendance,
      this.isPaymentDaily,
      this.isTotalLate,
      this.isOverTimeBefore,
      this.isOverTimeAfter,
      this.isOverTimeDay,
      this.isAttendanceWorkShift,
      this.numberOfDays,
      this.numberOfHours,
      this.travelAccount,
      this.endWorkAccount,
      this.vactionAccountID,
      this.endVactionPerYear,
      this.leaveComeAccountID});

  @override
  String toString() {
    return "$groupDescription";
  }

  GroupItem.fromJson(Map<String, dynamic> json) {
    groupID = json['GroupID'];
    groupName = json['GroupName'];
    groupDescription = json['GroupDescription'];
    comID = json['ComID'];
    expncesAccount = json['ExpncesAccount'];
    monyAccont = json['MonyAccont'];
    expectExpencesAcount = json['expectExpencesAcount'];
    loansAccount = json['loansAccount'];
    loansDiscount = json['LoansDiscount'];
    discountAccount = json['DiscountAccount'];
    department = json['department'];
    costItems = json['CostItems'];
    insuranceAccount = json['InsuranceAccount'];
    taxAccount = json['TaxAccount'];
    insuranceCashAccount = json['InsuranceCashAccount'];
    capacity = json['Capacity'];
    lastDateProcess = json['LastDateProcess'];
    isAbsence = json['IsAbsence'];
    isLate = json['IsLate'];
    isEarlyLeave = json['IsEarlyLeave'];
    isPaymentAttendance = json['IsPaymentAttendance'];
    isPaymentDaily = json['IsPaymentDaily'];
    isTotalLate = json['IsTotalLate'];
    isOverTimeBefore = json['IsOverTimeBefore'];
    isOverTimeAfter = json['IsOverTimeAfter'];
    isOverTimeDay = json['IsOverTimeDay'];
    isAttendanceWorkShift = json['IsAttendanceWorkShift'];
    numberOfDays = json['NumberOfDays'];
    numberOfHours = json['NumberOfHours'];
    travelAccount = json['TravelAccount'];
    endWorkAccount = json['EndWorkAccount'];
    vactionAccountID = json['VactionAccountID'];
    endVactionPerYear = json['EndVactionPerYear'];
    leaveComeAccountID = json['LeaveComeAccountID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['GroupID'] = groupID;
    data['GroupName'] = groupName;
    data['GroupDescription'] = groupDescription;
    data['ComID'] = comID;
    data['ExpncesAccount'] = expncesAccount;
    data['MonyAccont'] = monyAccont;
    data['expectExpencesAcount'] = expectExpencesAcount;
    data['loansAccount'] = loansAccount;
    data['LoansDiscount'] = loansDiscount;
    data['DiscountAccount'] = discountAccount;
    data['department'] = department;
    data['CostItems'] = costItems;
    data['InsuranceAccount'] = insuranceAccount;
    data['TaxAccount'] = taxAccount;
    data['InsuranceCashAccount'] = insuranceCashAccount;
    data['Capacity'] = capacity;
    data['LastDateProcess'] = lastDateProcess;
    data['IsAbsence'] = isAbsence;
    data['IsLate'] = isLate;
    data['IsEarlyLeave'] = isEarlyLeave;
    data['IsPaymentAttendance'] = isPaymentAttendance;
    data['IsPaymentDaily'] = isPaymentDaily;
    data['IsTotalLate'] = isTotalLate;
    data['IsOverTimeBefore'] = isOverTimeBefore;
    data['IsOverTimeAfter'] = isOverTimeAfter;
    data['IsOverTimeDay'] = isOverTimeDay;
    data['IsAttendanceWorkShift'] = isAttendanceWorkShift;
    data['NumberOfDays'] = numberOfDays;
    data['NumberOfHours'] = numberOfHours;
    data['TravelAccount'] = travelAccount;
    data['EndWorkAccount'] = endWorkAccount;
    data['VactionAccountID'] = vactionAccountID;
    data['EndVactionPerYear'] = endVactionPerYear;
    data['LeaveComeAccountID'] = leaveComeAccountID;
    return data;
  }
}
