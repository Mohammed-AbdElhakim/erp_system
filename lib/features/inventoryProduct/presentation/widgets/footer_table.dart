import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/inventory_product_model.dart';

class FooterTable extends StatelessWidget {
  const FooterTable(
      {super.key,
      required this.sumScrollController,
      required this.inventoryProductList,
      required this.selectionItemsShow});
  final ScrollController? sumScrollController;
  final List<InventoryProductModel> inventoryProductList;
  final List<String> selectionItemsShow;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: sumScrollController,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.blueLight,
          // border: Border.all(color: Colors.grey.shade100, width: 1),
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              height: 45,
              child: Center(
                  child: Text(
                "الإجمالى",
                style: AppStyles.textStyle14,
              )),
            ),
            if (selectionItemsShow.contains(AppStrings.openingBalances))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumDepitBefor(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.openingBalances))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumCreditBefor(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.movement))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumDepitMony(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.movement))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumCreditMony(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.totals))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumDepitSum(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.totals))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumCreditSum(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.closingBalances))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumDepitAfter(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.closingBalances))
              Container(
                width: MediaQuery.of(context).size.width * .25,
                height: 45,
                decoration: const BoxDecoration(
                  border: BorderDirectional(start: BorderSide(color: Colors.black12, width: 1)),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        getSumCreditAfter(),
                        style: AppStyles.textStyle14,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String getSumDepitBefor() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + (item.beforCorD == true ? item.beformony! : 0);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditBefor() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + (item.beforCorD == false ? item.beformony! : 0);
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitMony() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + (item.depitmony!);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditMony() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + (item.creditmony!);
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitSum() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + ((item.depitmony! + (item.beforCorD == true ? item.beformony! : 0)));
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditSum() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + ((item.depitmony! + (item.beforCorD == false ? item.beformony! : 0)));
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitAfter() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum + (item.creditORDepit == true ? item.mony! : 0);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditAfter() {
    double sum = 0;
    for (var item in inventoryProductList) {
      sum = sum +
          (item.creditORDepit == true
              ? item.mony! < 0
                  ? item.mony! * -1
                  : 0
              : 0);
    }
    return NumberFormat("#0.00").format(sum);
  }
}
