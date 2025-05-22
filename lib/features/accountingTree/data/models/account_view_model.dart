class AccountTreeModel {
  AccountTreeModel({
    this.acId,
    this.acName,
    this.creditOrDepit,
    this.comId,
    this.sheetName,
    this.sheet,
    this.acCode,
    this.acIndex,
    this.indexchar,
    this.fullName,
    this.depit,
    this.credit,
    this.countentry,
    this.lastcount,
    this.nextcode,
    this.s,
    this.total,
    this.acParent,
    this.parent,
    this.openBalanceCreditOrDepit,
    this.openBalance,
    this.acType,
    this.sName,
    this.showPerm,
    this.addPerm,
    this.salesPerm,
    this.outPerm,
    this.taxCategoryId,
    this.startWith,
  });

  int? acId;
  String? acName;
  bool? creditOrDepit;
  int? comId;
  int? startWith;
  String? sheetName;
  int? sheet;
  double? acCode;
  double? acIndex;
  String? indexchar;
  String? fullName;
  int? depit;
  int? credit;
  int? countentry;
  int? lastcount;
  double? nextcode;
  int? s;
  int? total;
  int? acParent;
  String? parent;
  bool? openBalanceCreditOrDepit;
  double? openBalance;
  int? acType;
  String? sName;
  String? showPerm;
  String? addPerm;
  String? salesPerm;
  String? outPerm;
  int? taxCategoryId;

  factory AccountTreeModel.fromJson(Map<String, dynamic> json) {
    return AccountTreeModel(
      acId: json["AcID"],
      acName: json["AcName"],
      startWith: json["StartWith"],
      creditOrDepit: json["CreditORDepit"],
      comId: json["ComID"],
      sheetName: json["SheetName"],
      sheet: json["Sheet"],
      acCode: json["AcCode"],
      acIndex: json["AcIndex"],
      indexchar: json["indexchar"],
      fullName: json["FullName"],
      depit: json["depit"],
      credit: json["credit"],
      countentry: json["countentry"],
      lastcount: json["lastcount"],
      nextcode: json["nextcode"],
      s: json["s"],
      total: json["total"],
      acParent: json["AcParent"],
      parent: json["Parent"],
      openBalanceCreditOrDepit: json["OpenBalanceCreditOrDepit"],
      openBalance: json["OpenBalance"],
      acType: json["AcType"],
      sName: json["SName"],
      showPerm: json["ShowPerm"],
      addPerm: json["AddPerm"],
      salesPerm: json["SalesPerm"],
      outPerm: json["OutPerm"],
      taxCategoryId: json["TaxCategoryID"],
    );
  }

  Map<String, dynamic> toJson() => {
        "AcID": acId,
        "AcName": acName,
        "StartWith": startWith,
        "CreditORDepit": creditOrDepit,
        "ComID": comId,
        "SheetName": sheetName,
        "Sheet": sheet,
        "AcCode": acCode,
        "AcIndex": acIndex,
        "indexchar": indexchar,
        "FullName": fullName,
        "depit": depit,
        "credit": credit,
        "countentry": countentry,
        "lastcount": lastcount,
        "nextcode": nextcode,
        "s": s,
        "total": total,
        "AcParent": acParent,
        "Parent": parent,
        "OpenBalanceCreditOrDepit": openBalanceCreditOrDepit,
        "OpenBalance": openBalance,
        "AcType": acType,
        "SName": sName,
        "ShowPerm": showPerm,
        "AddPerm": addPerm,
        "SalesPerm": salesPerm,
        "OutPerm": outPerm,
        "TaxCategoryID": taxCategoryId,
      };
}
