class PercentageSectionsModel {
  List<PercentageSectionItems>? percentageSectionItems;
  int? sectionId;
  String? nameAr;
  String? nameEn;
  int? sectionOrder;
  String? type;
  List<dynamic>? dashboardAuth;
  List<dynamic>? dashboardGraphs;
  List<dynamic>? dashboardNumbers;
  List<dynamic>? dashboardPercentages;
  List<dynamic>? dashboardTables;

  PercentageSectionsModel(
      {this.percentageSectionItems,
      this.sectionId,
      this.nameAr,
      this.nameEn,
      this.sectionOrder,
      this.type,
      this.dashboardAuth,
      this.dashboardGraphs,
      this.dashboardNumbers,
      this.dashboardPercentages,
      this.dashboardTables});

  PercentageSectionsModel.fromJson(Map<String, dynamic> json) {
    if (json['SectionItems'] != null) {
      percentageSectionItems = <PercentageSectionItems>[];
      json['SectionItems'].forEach((v) {
        percentageSectionItems!.add(PercentageSectionItems.fromJson(v));
      });
    }
    sectionId = json['SectionId'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
    sectionOrder = json['SectionOrder'];
    type = json['Type'];

    if (json['DashboardAuth'] != null) {
      dashboardAuth = <dynamic>[];
      json['DashboardAuth'].forEach((v) {
        dashboardAuth!.add(v);
      });
    }
    if (json['DashboardGraphs'] != null) {
      dashboardGraphs = <dynamic>[];
      json['DashboardGraphs'].forEach((v) {
        dashboardGraphs!.add(v);
      });
    }
    if (json['DashboardNumbers'] != null) {
      dashboardNumbers = <dynamic>[];
      json['DashboardNumbers'].forEach((v) {
        dashboardNumbers!.add(v);
      });
    }
    if (json['DashboardPercentages'] != null) {
      dashboardPercentages = <dynamic>[];
      json['DashboardPercentages'].forEach((v) {
        dashboardPercentages!.add(v);
      });
    }
    if (json['DashboardTables'] != null) {
      dashboardTables = <dynamic>[];
      json['DashboardTables'].forEach((v) {
        dashboardTables!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (percentageSectionItems != null) {
      data['SectionItems'] =
          percentageSectionItems!.map((v) => v.toJson()).toList();
    }
    data['SectionId'] = sectionId;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    data['SectionOrder'] = sectionOrder;
    data['Type'] = type;
    if (dashboardAuth != null) {
      data['DashboardAuth'] = dashboardAuth!.map((v) => v.toJson()).toList();
    }
    if (dashboardGraphs != null) {
      data['DashboardGraphs'] =
          dashboardGraphs!.map((v) => v.toJson()).toList();
    }
    if (dashboardNumbers != null) {
      data['DashboardNumbers'] =
          dashboardNumbers!.map((v) => v.toJson()).toList();
    }
    if (dashboardPercentages != null) {
      data['DashboardPercentages'] =
          dashboardPercentages!.map((v) => v.toJson()).toList();
    }
    if (dashboardTables != null) {
      data['DashboardTables'] =
          dashboardTables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PercentageSectionItems {
  double? totalNumber;
  double? number;
  String? nameAr;
  String? nameEn;

  PercentageSectionItems(
      {this.totalNumber, this.number, this.nameAr, this.nameEn});

  PercentageSectionItems.fromJson(Map<String, dynamic> json) {
    totalNumber = json['TotalNumber'];
    number = json['Number'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalNumber'] = totalNumber;
    data['Number'] = number;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    return data;
  }
}
