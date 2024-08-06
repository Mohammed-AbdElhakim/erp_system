import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/trial_balance_model.dart';

class FooterTable extends StatelessWidget {
  const FooterTable(
      {super.key,
      required this.sumScrollController,
      required this.trialBalanceList,
      required this.selectionItemsShow});
  final ScrollController? sumScrollController;
  final List<TrialBalanceModel> trialBalanceList;
  final List<String> selectionItemsShow;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            if (selectionItemsShow.contains(AppStrings.openingBalances))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumDepitBefor(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.openingBalances))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumCreditBefor(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.movement))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumDepitMony(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.movement))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumCreditMony(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.totals))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumDepitSum(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.totals))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumCreditSum(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.closingBalances))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumDepitAfter(),
                    style: AppStyles.textStyle14,
                  ),
                ),
              ),
            if (selectionItemsShow.contains(AppStrings.closingBalances))
              Container(
                width: 120,
                height: 45,
                color: AppColors.blueLight,
                child: Center(
                  child: Text(
                    getSumCreditAfter(),
                    style: AppStyles.textStyle14,
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
    for (var item in trialBalanceList) {
      sum = sum + (item.beforCorD == true ? item.beformony! : 0);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditBefor() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum + (item.beforCorD == false ? item.beformony! : 0);
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitMony() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum + (item.depitmony!);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditMony() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum + (item.creditmony!);
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitSum() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum +
          ((item.depitmony! + (item.beforCorD == true ? item.beformony! : 0)));
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditSum() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum +
          ((item.depitmony! + (item.beforCorD == false ? item.beformony! : 0)));
    }
    return NumberFormat("#0.00").format(sum);
  }

  String getSumDepitAfter() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum + (item.creditORDepit == true ? item.mony! : 0);
    }

    return NumberFormat("#0.00").format(sum);
  }

  String getSumCreditAfter() {
    double sum = 0;
    for (var item in trialBalanceList) {
      sum = sum + (item.creditORDepit == false ? item.mony! : 0);
    }
    return NumberFormat("#0.00").format(sum);
  }
}
