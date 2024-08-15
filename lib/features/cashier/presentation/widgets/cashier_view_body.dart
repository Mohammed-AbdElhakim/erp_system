import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'custom_app_bar_body.dart';
import 'custom_drawer.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody(
      {super.key,
      required this.title,
      required this.proCompanyList,
      required this.modalityList,
      required this.productList});
  final String title;
  final List<PRoCompanyItem> proCompanyList;
  final List<ModalityItem> modalityList;
  final List<ProductItem> productList;

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  int modalityIdChoose = -1;
  List<ProductItem> myProductList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBody(title: widget.title),
      drawer: CustomDrawer(
        proCompanyList: widget.proCompanyList,
        modalityList: widget.modalityList,
        onTap: (modalityId) {
          modalityIdChoose = modalityId;
          myProductList.clear();
          for (var i in widget.productList) {
            if (i.modality == modalityId) {
              myProductList.add(i);
            }
          }
          setState(() {});
        },
      ),
      body: modalityIdChoose == -1
          ? const Center(
              child: Text("برجاء اختيار القسم"),
            )
          : myProductList.isEmpty
              ? const Center(
                  child: Text("لا يوجد منتاجات"),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Text(myProductList[index].proName!);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemCount: myProductList.length,
                ),
    );
  }
}
