class ModalityModel {
  List<ModalityItem>? modalityList;
  int? numberofrecords;

  ModalityModel({this.modalityList, this.numberofrecords});

  ModalityModel.fromJson(Map<String, dynamic> json) {
    if (json['dynamicList'] != null) {
      modalityList = <ModalityItem>[];
      json['dynamicList'].forEach((v) {
        modalityList!.add(ModalityItem.fromJson(v));
      });
    }
    numberofrecords = json['numberofrecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (modalityList != null) {
      data['dynamicList'] = modalityList!.map((v) => v.toJson()).toList();
    }
    data['numberofrecords'] = numberofrecords;
    return data;
  }
}

class ModalityItem {
  int? modalityID;
  String? modalityName;
  int? companyID;

  ModalityItem({this.modalityID, this.modalityName, this.companyID});

  ModalityItem.fromJson(Map<String, dynamic> json) {
    modalityID = json['ModalityID'];
    modalityName = json['ModalityName'];
    companyID = json['CompanyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ModalityID'] = modalityID;
    data['ModalityName'] = modalityName;
    data['CompanyID'] = companyID;
    return data;
  }
}
