import 'package:erp_system/features/cashier/data/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/modality_model.dart';
import '../../data/models/pro_company_model.dart';
import 'custom_product_item_widget.dart';
import 'custom_search.dart';

class CashierViewBody extends StatefulWidget {
  const CashierViewBody(
      {super.key,
      required this.title,
      required this.allProCompanyList,
      required this.allModalityList,
      required this.allProductList});
  final String title;
  final List<ProCompanyItem> allProCompanyList;
  final List<ModalityItem> allModalityList;
  final List<ProductItem> allProductList;

  @override
  State<CashierViewBody> createState() => _CashierViewBodyState();
}

class _CashierViewBodyState extends State<CashierViewBody> {
  late int companyId;
  List<ModalityItem> modalityList = [];
  List<ProductItem> productList = [];
  late int modalityId;
  @override
  void initState() {
    companyId = widget.allProCompanyList[0].companyID!;
    for (var i in widget.allModalityList) {
      if (i.companyID == companyId) {
        modalityList.add(i);
      }
    }
    modalityId = modalityList[0].modalityID!;
    for (var i in widget.allProductList) {
      if (i.modality == modalityId) {
        productList.add(i);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                  border: BorderDirectional(
                      end: BorderSide(color: Colors.black26))),
              padding: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.separated(
                  itemCount: modalityList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        productList.clear();
                        setState(() {
                          modalityId = modalityList[index].modalityID!;
                          for (var i in widget.allProductList) {
                            if (i.modality == modalityId) {
                              productList.add(i);
                            }
                          }
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 35,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: modalityId == modalityList[index].modalityID
                                ? AppColors.blueGreyDark
                                : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          modalityList[index].modalityName ?? "",
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: modalityId == modalityList[index].modalityID
                                ? AppColors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                ),
              ),
            )),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 5, right: 16, left: 16, bottom: 10),
                      child: InkWell(
                        onTap: () {
                          showSearch(
                            context: context,
                            delegate: CustomSearch(
                              productList: widget.allProductList,
                            ),
                          );
                        },
                        child: CircleAvatar(
                            backgroundColor: AppColors.blueGreyLight,
                            child: const Icon(Icons.search)),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Wrap(
                              runSpacing: 5.0,
                              spacing: 5,
                              children: productList
                                  .map(
                                    (e) => CustomProductItemWidget(
                                      productItem: e,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        )),
        Container(
          height: 86,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: const Border(top: BorderSide(color: Colors.black))),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                runSpacing: 5.0,
                spacing: 5,
                direction: Axis.vertical,
                children: widget.allProCompanyList
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          modalityList.clear();
                          productList.clear();
                          setState(() {
                            companyId = item.companyID!;
                            for (var i in widget.allModalityList) {
                              if (i.companyID == companyId) {
                                modalityList.add(i);
                              }
                            }
                            modalityId = modalityList[0].modalityID!;
                            for (var i in widget.allProductList) {
                              if (i.modality == modalityId) {
                                productList.add(i);
                              }
                            }
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: companyId == item.companyID
                                  ? AppColors.blueGreyDark
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.black)),
                          child: Text(
                            item.companyName ?? "",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: companyId == item.companyID
                                  ? AppColors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
