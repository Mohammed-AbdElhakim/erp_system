class TablesSectionsModel {
  List<TablesSectionItems>? tablesSectionItems;
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

  TablesSectionsModel(
      {this.tablesSectionItems,
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

  TablesSectionsModel.fromJson(Map<String, dynamic> json) {
    if (json['SectionItems'] != null) {
      tablesSectionItems = <TablesSectionItems>[];
      json['SectionItems'].forEach((v) {
        tablesSectionItems!.add(TablesSectionItems.fromJson(v));
      });
    }
    sectionId = json['SectionId'];
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
    sectionOrder = json['SectionOrder'];
    type = json['Type'];
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
    if (tablesSectionItems != null) {
      data['SectionItems'] =
          tablesSectionItems!.map((v) => v.toJson()).toList();
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

class TablesSectionItems {
  List<Map<String, dynamic>>? columnList;
  List<Map<String, dynamic>>? dataList;
  String? nameAr;
  String? nameEn;

  TablesSectionItems(
      {this.columnList, this.dataList, this.nameAr, this.nameEn});

  TablesSectionItems.fromJson(Map<String, dynamic> json) {
    if (json['columnList'] != null) {
      columnList = <Map<String, dynamic>>[];
      json['columnList'].forEach((v) {
        columnList!.add(v);
      });
    }
    if (json['dataList'] != null) {
      dataList = <Map<String, dynamic>>[];
      json['dataList'].forEach((v) {
        dataList!.add(v);
      });
    }
    nameAr = json['NameAr'];
    nameEn = json['NameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (columnList != null) {
      data['columnList'] = columnList!.map((v) => v).toList();
    }
    if (dataList != null) {
      data['dataList'] = dataList!.map((v) => v).toList();
    }
    data['NameAr'] = nameAr;
    data['NameEn'] = nameEn;
    return data;
  }
}
