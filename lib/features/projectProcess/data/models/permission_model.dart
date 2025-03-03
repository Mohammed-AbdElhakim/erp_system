class PermissionModel {
  PermissionModel({
    required this.showPrint,
    required this.showExport,
    required this.showSearch,
    required this.showEdit,
    required this.showDelete,
    required this.showRowPrint,
    required this.showNew,
    required this.showSetting,
    required this.showMasterButton,
    required this.showSum,
    required this.showRefersh,
    required this.showPaging,
    required this.showGroup,
  });
  late final bool showPrint;
  late final bool showExport;
  late final bool showSearch;
  late final bool showEdit;
  late final bool showDelete;
  late final bool showRowPrint;
  late final bool showNew;
  late final bool showSetting;
  late final bool showMasterButton;
  late final bool showSum;
  late final bool showRefersh;
  late final bool showPaging;
  late final bool showGroup;

  PermissionModel.fromJson(Map<String, dynamic> json) {
    showPrint = json['ShowPrint'];
    showExport = json['ShowExport'];
    showSearch = json['ShowSearch'];
    showEdit = json['ShowEdit'];
    showDelete = json['ShowDelete'];
    showRowPrint = json['ShowRowPrint'];
    showNew = json['ShowNew'];
    showSetting = json['ShowSetting'];
    showMasterButton = json['ShowMasterButton'];
    showSum = json['ShowSum'];
    showRefersh = json['ShowRefersh'];
    showPaging = json['ShowPaging'];
    showGroup = json['ShowGroup'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ShowPrint'] = showPrint;
    data['ShowExport'] = showExport;
    data['ShowSearch'] = showSearch;
    data['ShowEdit'] = showEdit;
    data['ShowDelete'] = showDelete;
    data['ShowRowPrint'] = showRowPrint;
    data['ShowNew'] = showNew;
    data['ShowSetting'] = showSetting;
    data['ShowMasterButton'] = showMasterButton;
    data['ShowSum'] = showSum;
    data['ShowRefersh'] = showRefersh;
    data['ShowPaging'] = showPaging;
    data['ShowGroup'] = showGroup;
    return data;
  }
}
