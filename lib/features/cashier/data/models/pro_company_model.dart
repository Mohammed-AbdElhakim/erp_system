class ProCompanyModel {
  List<ProCompanyItem>? proCompanyList;
  int? numberofrecords;

  ProCompanyModel({this.proCompanyList, this.numberofrecords});

  ProCompanyModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      proCompanyList = <ProCompanyItem>[];
      json['dynamicList'].forEach((v) {
        proCompanyList!.add(ProCompanyItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (proCompanyList != null) {
      data['dynamicList'] = proCompanyList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ProCompanyItem {
  int? companyID;
  String? companyName;
  int? comID;
  bool? iSQuntity;
  bool? iSInventory;
  bool? iSService;
  bool? iSSales;
  bool? saleMoreOne;
  bool? iSPurchase;
  bool? iSContractSale;
  bool? iSPrimary;

  ProCompanyItem(
      {this.companyID,
      this.companyName,
      this.comID,
      this.iSQuntity,
      this.iSInventory,
      this.iSService,
      this.iSSales,
      this.saleMoreOne,
      this.iSPurchase,
      this.iSContractSale,
      this.iSPrimary});

  ProCompanyItem.fromJson(Map<String, dynamic> json) {
    companyID = json['CompanyID'];
    companyName = json['CompanyName'];
    comID = json['ComID'];
    iSQuntity = json['ISQuntity'];
    iSInventory = json['ISInventory'];
    iSService = json['ISService'];
    iSSales = json['ISSales'];
    saleMoreOne = json['SaleMoreOne'];
    iSPurchase = json['ISPurchase'];
    iSContractSale = json['ISContractSale'];
    iSPrimary = json['ISPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyID'] = companyID;
    data['CompanyName'] = companyName;
    data['ComID'] = comID;
    data['ISQuntity'] = iSQuntity;
    data['ISInventory'] = iSInventory;
    data['ISService'] = iSService;
    data['ISSales'] = iSSales;
    data['SaleMoreOne'] = saleMoreOne;
    data['ISPurchase'] = iSPurchase;
    data['ISContractSale'] = iSContractSale;
    data['ISPrimary'] = iSPrimary;
    return data;
  }
}
