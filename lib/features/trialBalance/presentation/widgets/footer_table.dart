import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/trial_balance_model.dart';

class FooterTable extends StatelessWidget {
  const FooterTable({super.key,required this.sumScrollController, required this.trialBalanceList});
  final ScrollController? sumScrollController;
  final List<TrialBalanceModel> trialBalanceList;

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: sumScrollController,
        child: Row(
          children: [
            Container(
              width: 300,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                  child: Text(
                    "الإجمالى",
                    style: AppStyles.textStyle14,
                  )),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "depitBefor")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "creditBefor")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData:trialBalanceList,
                      columnName: "depitMony")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "creditMony")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "depitSum")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "creditSum")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "depitAfter")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
            Container(
              width: 120,
              height: 45,
              color: AppColors.blueLight,
              child: Center(
                child: Text(
                  getSum(
                      listData: trialBalanceList,
                      columnName: "creditAfter")
                      .toString(),
                  style: AppStyles.textStyle14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getSum(
      {required List<TrialBalanceModel> listData, required String columnName}) {
    switch (columnName) {
      case "depitBefor":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.beforCorD == true ? item.beformony! : 0);
        }

        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditBefor":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.beforCorD == false ? item.beformony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitMony":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.depitmony!);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditMony":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditmony!);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitSum":
        double sum = 0;
        for (var item in listData) {
          sum = sum +
              ((item.depitmony! +
                  (item.beforCorD == true ? item.beformony! : 0)));
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditSum":
        double sum = 0;
        for (var item in listData) {
          sum = sum +
              ((item.depitmony! +
                  (item.beforCorD == false ? item.beformony! : 0)));
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "depitAfter":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditORDepit == true ? item.mony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
      case "creditAfter":
        double sum = 0;
        for (var item in listData) {
          sum = sum + (item.creditORDepit == false ? item.mony! : 0);
        }
        return double.parse(NumberFormat("#0.00").format(sum));
    }
  }
}
