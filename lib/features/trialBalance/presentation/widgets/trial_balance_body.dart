import 'package:erp_system/core/widgets/custom_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trial_balance_body_model.dart';
import '../../data/models/trial_balance_model.dart';
import '../manager/trialBalance/trial_balance_cubit.dart';
import 'trial_balance_table.dart';

class TrialBalanceBody extends StatefulWidget {
  const TrialBalanceBody({super.key});

  @override
  State<TrialBalanceBody> createState() => _TrialBalanceBodyState();
}

class _TrialBalanceBodyState extends State<TrialBalanceBody> {
  String dateFrom = "", dateTo = "";
  bool checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) nsetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    S.of(context).massage_number_zero,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    nsetState(() {
                      checkboxValue = !checkboxValue;
                    });
                    BlocProvider.of<TrialBalanceCubit>(context).getTrialBalance(
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
          BlocBuilder<TrialBalanceCubit, TrialBalanceState>(
            builder: (context, state) {
              if (state is TrialBalanceSuccess) {
                List<TrialBalanceModel> trialBalanceList =
                    state.trialBalanceModel;
                return TrialBalanceTable(
                  trialBalanceList: trialBalanceList,
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
      ),
    );
  }
}
