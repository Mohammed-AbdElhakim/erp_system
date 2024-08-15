import 'package:flutter/material.dart';

import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'custom_main_list_tile_in_drawer_cashier.dart';
import 'custom_sub_list_tile_in_drawer_cashier.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer(
      {super.key,
      required this.proCompanyList,
      required this.modalityList,
      required this.onTap});
  final List<ProCompanyItem> proCompanyList;
  final List<ModalityItem> modalityList;
  final void Function(int modalityId) onTap;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: widget.proCompanyList.length,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ProCompanyItem proCompanyItem = widget.proCompanyList[index];
          List<ModalityItem> modalityList = [];
          for (var i in widget.modalityList) {
            if (i.companyID == proCompanyItem.companyID) {
              modalityList.add(i);
            }
          }
          return CustomMainListTileInDrawerCashier(
            title: proCompanyItem.companyName!,
            bodyList: List.generate(
              modalityList.length,
              (modalityIndex) {
                return CustomSubListTileInDrawerCashier(
                  modalityItem: modalityList[modalityIndex],
                  onTap: (modalityId) {
                    widget.onTap(modalityId);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
