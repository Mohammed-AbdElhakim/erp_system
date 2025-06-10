import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_date.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trial_cost_body_model.dart';
import '../../data/models/trial_cost_model.dart';
import '../manager/trialCost/trial_cost_cubit.dart';
import 'trial_cost_table.dart';

class TrialCostViewBody extends StatefulWidget {
  const TrialCostViewBody({super.key});

  @override
  State<TrialCostViewBody> createState() => _TrialCostViewBodyState();
}

class _TrialCostViewBodyState extends State<TrialCostViewBody> {
  String dateFrom = "", dateTo = "";
  bool checkboxValue = true;
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
                              BlocProvider.of<TrialCostCubit>(context).getTrialCost(
                                trialCostBody: TrialCostBodyModel(
                                  datefrom: dateFrom,
                                  dateto: dateTo,
                                  comID: -1,
                                  iszero: checkboxValue,
                                  iscompany: true,
                                  pram: 0,
                                  type: 4,
                                ),
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
                              BlocProvider.of<TrialCostCubit>(context).getTrialCost(
                                trialCostBody: TrialCostBodyModel(
                                  datefrom: dateFrom,
                                  dateto: dateTo,
                                  comID: -1,
                                  iszero: checkboxValue,
                                  iscompany: true,
                                  pram: 0,
                                  type: 4,
                                ),
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
                builder: (BuildContext context, void Function(void Function()) nsetState) {
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
                        BlocProvider.of<TrialCostCubit>(context).getTrialCost(
                          trialCostBody: TrialCostBodyModel(
                            datefrom: dateFrom,
                            dateto: dateTo,
                            comID: -1,
                            iszero: checkboxValue,
                            iscompany: true,
                            pram: 0,
                            type: 4,
                          ),
                        );
                      });
                },
              )
            ],
          ),
        ),
        BlocBuilder<TrialCostCubit, TrialCostState>(
          builder: (context, state) {
            if (state is TrialCostSuccess) {
              List<TrialCostItem> trialCostList = state.trialCostItemsList;
              return TrialCostTable(
                trialCostList: trialCostList,
                // selectionItemsShow: selectionItems,
              );
            } else if (state is TrialCostFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is TrialCostLoading) {
              return const CustomLoadingWidget();
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
