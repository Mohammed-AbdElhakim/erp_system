import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'custom_app_bar_body.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarBody(title: widget.title),
      drawer: Drawer(
        child: Container(
          child: Text(widget.productList[1].proName!),
        ),
      ),
      body: Container(
        child: Text(widget.productList[1].proName!),
      ),
    );
  }
}
