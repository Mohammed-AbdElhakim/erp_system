import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../screenTable/data/models/item_list_setup_model.dart';
import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'page_2.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody(
      {super.key,
      required this.title,
      required this.allProCompanyList,
      required this.allModalityList,
      required this.allProductList,
      required this.listSetup,
      required this.listColumn,
      required this.listKey,
      required this.categoryList,
      required this.listHeader,
      this.onPageChanged});
  final String title;
  final List<ProCompanyItem> allProCompanyList;
  final List<ModalityItem> allModalityList;
  final List<ProductItem> allProductList;
  final List<ItemListSetupModel> listSetup;
  final List<ItemListSetupModel> listColumn;
  final List<dynamic> listKey;
  final List<String> categoryList;
  final List<String> listHeader;
  final void Function(int)? onPageChanged;

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
        widget.onPageChanged!(_currentIndex);
      },
      children: [
        Container(
          color: Colors.green,
          child: Center(
            child: Text(
              'Screen 1',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        Page2(
          allProCompanyList: widget.allProCompanyList,
          allModalityList: widget.allModalityList,
          allProductList: widget.allProductList,
        ),
        Container(
          color: Colors.red,
          child: Center(
            child: Text(
              'Screen 3',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
      ],
    );
  }
}
