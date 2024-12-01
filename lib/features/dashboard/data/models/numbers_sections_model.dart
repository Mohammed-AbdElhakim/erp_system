class NumbersSectionsModel {
  List<NumbersSectionItems>? numbersSectionItems;
  int? sectionId;
  String? nameAr;
  String? nameEn;
  int? sectionOrder;
  String? type;
  List<dynamic>? dashboardAuth;
  List<dynamic>? dashboardNumbers;
  List<dynamic>? dashboardPercentages;

  NumbersSectionsModel(
      {this.numbersSectionItems,
        this.sectionId,
        this.nameAr,
        this.nameEn,
        this.sectionOrder,
        this.type,
        this.dashboardAuth,
        this.dashboardNumbers,
        this.dashboardPercentages});

  NumbersSectionsModel.fromJson(Map<String, dynamic> json) {
    if (json['SectionItems'] != null) {
      numbersSectionItems = <NumbersSectionItems>[];
      json['SectionItems'].forEach((v) {
        numbersSectionItems!.add(NumbersSectionItems.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (numbersSectionItems != null) {
      data['SectionItems'] = numbersSectionItems!.map((v) => v.toJson()).toList();
    }
    data['SectionId'] = sectionId;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    data['SectionOrder'] = sectionOrder;
    data['Type'] = type;
    if (dashboardAuth != null) {
      data['DashboardAuth'] =
          dashboardAuth!.map((v) => v.toJson()).toList();
    }
    if (dashboardNumbers != null) {
      data['DashboardNumbers'] =
          dashboardNumbers!.map((v) => v.toJson()).toList();
    }
    if (dashboardPercentages != null) {
      data['DashboardPercentages'] =
          dashboardPercentages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NumbersSectionItems {
  double? number;
  String? icon;
  String? nameAr;
  String? nameEn;

  NumbersSectionItems({this.number, this.icon, this.nameAr, this.nameEn});

  NumbersSectionItems.fromJson(Map<String, dynamic> json) {
    number = json['Number'];
    icon = json['Icon'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Number'] = number;
    data['Icon'] = icon;
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    return data;
  }
}