import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/methods.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'custom_app_bar_body.dart';
import 'custom_drawer.dart';
import 'custom_product_item_widget.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody(
      {super.key,
      required this.title,
      required this.proCompanyList,
      required this.modalityList,
      required this.productList});
  final String title;
  final List<ProCompanyItem> proCompanyList;
  final List<ModalityItem> modalityList;
  final List<ProductItem> productList;

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  int modalityIdChoose = -1;
  List<ProductItem> myProductList = [];
  List<ProductItem> myProductListSearch = [];
  TextEditingController controllerSearch = TextEditingController();
  @override
  void dispose() {
    controllerSearch.dispose();
    super.dispose();
  }

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
          controllerSearch.text = "";
          for (var i in widget.productList) {
            if (i.modality == modalityId) {
              myProductList.add(i);
            }
          }
          setState(() {});
        },
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
            child: CustomTextFormFieldSearch(
              hintText: S.of(context).search,
              controller: controllerSearch,
              onChanged: (value) {
                myProductListSearch.clear();

                for (var i in widget.productList) {
                  if (i.proName != null) {
                    if (i.proName!.contains(value)) {
                      myProductListSearch.add(i);
                    }
                  }
                }

                setState(() {});
              },
            ),
          ),
          if (modalityIdChoose == -1 && controllerSearch.text.isEmpty)
            const Center(
              child: Text("برجاء اختيار القسم"),
            ),
          if (controllerSearch.text.isNotEmpty)
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: myProductListSearch.length,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isOrientationPortrait(context) ? 2 : 5,
                    mainAxisSpacing: 35,
                    crossAxisSpacing: 35,
                    childAspectRatio: 1.2
                    // mainAxisExtent: MediaQuery.of(context).size.width * .25,
                    // childAspectRatio: MediaQuery.of(context).size.width * .5,
                    ),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductItemWidget(
                    productItem: myProductListSearch[index],
                  );
                },
              ),
            ),
          // if (myProductList.isEmpty && modalityIdChoose != -1 ||
          //     controllerSearch.text.isNotEmpty)
          //   const Center(
          //     child: Text("لا يوجد منتاجات"),
          //   ),
          if (controllerSearch.text.isEmpty)
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: myProductList.length,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isOrientationPortrait(context) ? 2 : 5,
                    mainAxisSpacing: 35,
                    crossAxisSpacing: 35,
                    childAspectRatio: 1.2
                    // mainAxisExtent: MediaQuery.of(context).size.width * .25,
                    // childAspectRatio: MediaQuery.of(context).size.width * .5,
                    ),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductItemWidget(
                    productItem: myProductList[index],
                  );
                },
              ),
            ),
        ],
      ),
      /* body: modalityIdChoose == -1
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
                ),*/
    );
  }
}
