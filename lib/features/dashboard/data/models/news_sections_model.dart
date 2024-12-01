class NewsSectionsModel {
  List<NewsSectionItems>? newsSectionItems;
  int? sectionId;
  String? nameAr;
  String? nameEn;
  int? sectionOrder;
  String? type;
  List<dynamic>? dashboardAuth;
  List<dynamic>? dashboardNumbers;
  List<dynamic>? dashboardPercentages;

  NewsSectionsModel(
      {this.newsSectionItems,
        this.sectionId,
        this.nameAr,
        this.nameEn,
        this.sectionOrder,
        this.type,
        this.dashboardAuth,
        this.dashboardNumbers,
        this.dashboardPercentages});

  NewsSectionsModel.fromJson(Map<String, dynamic> json) {
    if (json['SectionItems'] != null) {
      newsSectionItems = <NewsSectionItems>[];
      json['SectionItems'].forEach((v) {
        newsSectionItems!.add(NewsSectionItems.fromJson(v));
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
    if (newsSectionItems != null) {
      data['SectionItems'] = newsSectionItems!.map((v) => v.toJson()).toList();
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

class NewsSectionItems {
  String? newsText;
  String? date;

  NewsSectionItems({this.newsText, this.date});

  NewsSectionItems.fromJson(Map<String, dynamic> json) {
    newsText = json['NewsText'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NewsText'] = newsText;
    data['Date'] = date;
    return data;
  }
}