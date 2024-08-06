import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_date.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trial_balance_body_model.dart';
import '../../data/models/trial_balance_model.dart';
import '../manager/trialBalance/trial_balance_cubit.dart';
import 'multi_select.dart';
import 'trial_balance_table.dart';

class TrialBalanceBody extends StatefulWidget {
  const TrialBalanceBody({super.key});

  @override
  State<TrialBalanceBody> createState() => _TrialBalanceBodyState();
}

class _TrialBalanceBodyState extends State<TrialBalanceBody> {
  String dateFrom = "", dateTo = "";
  bool checkboxValue = false;
  List<String> selectionItems = [AppStrings.closingBalances];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).date_from),
                        CustomDate(
                          onSelect: (date) {
                            setState(() {
                              dateFrom = date;
                            });
                            if (dateTo.isNotEmpty) {
                              BlocProvider.of<TrialBalanceCubit>(context)
                                  .getTrialBalance(
                                trialBalanceBody: TrialBalanceBodyModel(
                                    datefrom: dateFrom,
                                    dateto: dateTo,
                                    product: 0,
                                    comID: 0,
                                    iszero: checkboxValue,
                                    currancy: 0,
                                    customer: 0,
                                    supplier: 0,
                                    cost: 0,
                                    iscompany: true),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(S.of(context).date_to),
                        CustomDate(
                          onSelect: (date) {
                            setState(() {
                              dateTo = date;
                            });
                            if (dateFrom.isNotEmpty) {
                              BlocProvider.of<TrialBalanceCubit>(context)
                                  .getTrialBalance(
                                trialBalanceBody: TrialBalanceBodyModel(
                                    datefrom: dateFrom,
                                    dateto: dateTo,
                                    product: 0,
                                    comID: 0,
                                    iszero: checkboxValue,
                                    currancy: 0,
                                    customer: 0,
                                    supplier: 0,
                                    cost: 0,
                                    iscompany: true),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StatefulBuilder(
                      builder: (BuildContext context,
                          void Function(void Function()) nsetState) {
                        return CheckboxListTile(
                            contentPadding: EdgeInsets.zero,
                            value: checkboxValue,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              S.of(context).massage_number_zero,
                              style: AppStyles.textStyle14
                                  .copyWith(color: Colors.black),
                            ),
                            onChanged: (newValue) {
                              nsetState(() {
                                checkboxValue = !checkboxValue;
                              });
                              BlocProvider.of<TrialBalanceCubit>(context)
                                  .getTrialBalance(
                                trialBalanceBody: TrialBalanceBodyModel(
                                    datefrom: dateFrom,
                                    dateto: dateTo,
                                    product: 0,
                                    comID: 0,
                                    iszero: checkboxValue,
                                    currancy: 0,
                                    customer: 0,
                                    supplier: 0,
                                    cost: 0,
                                    iscompany: true),
                              );
                            });
                      },
                    ),
                  ),
                  if (dateTo.isNotEmpty && dateFrom.isNotEmpty)
                    IconButton(
                      onPressed: _showMultiSelectDialog,
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<TrialBalanceCubit, TrialBalanceState>(
          builder: (context, state) {
            if (state is TrialBalanceSuccess) {
              List<TrialBalanceModel> trialBalanceList =
                  state.trialBalanceModel;
              return TrialBalanceTable(
                trialBalanceList: trialBalanceList,
                selectionItemsShow: selectionItems,
              );
            } else if (state is TrialBalanceFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is TrialBalanceLoading) {
              return const CustomLoadingWidget();
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  void _showMultiSelectDialog() async {
    final List<String> items = [
      AppStrings.openingBalances,
      AppStrings.movement,
      AppStrings.totals,
      AppStrings.closingBalances,
    ];
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(
          items: items,
          selectionItems: selectionItems,
          checkboxValue: checkboxValue,
          dateFrom: dateFrom,
          dateTo: dateTo,
          context: context,
        );
      },
    );
    if (results != null) {
      setState(() {
        selectionItems = results;
      });
    }
  }
}
