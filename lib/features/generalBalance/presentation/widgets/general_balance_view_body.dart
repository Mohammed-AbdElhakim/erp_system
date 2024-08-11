import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_date.dart';
import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/general_balance_body_model.dart';
import '../../data/models/general_balance_model.dart';
import '../manager/generalBalance/general_balance_cubit.dart';
import 'general_balance_table.dart';

class ProfitViewBody extends StatefulWidget {
  const ProfitViewBody({super.key});

  @override
  State<ProfitViewBody> createState() => _ProfitViewBodyState();
}

class _ProfitViewBodyState extends State<ProfitViewBody> {
  String dateFrom = "", dateTo = "";
  bool checkboxValue = false;
  TextEditingController controllerLevel = TextEditingController();
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

                            BlocProvider.of<GeneralBalanceCubit>(context)
                                .getGeneralBalance(
                              generalBalanceBodyModel: GeneralBalanceBodyModel(
                                  datefrom: dateFrom,
                                  dateto: dateTo,
                                  comID: 0,
                                  iszero: checkboxValue,
                                  accName: "",
                                  accName2: "",
                                  iscompany: true),
                            );
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

                            BlocProvider.of<GeneralBalanceCubit>(context)
                                .getGeneralBalance(
                              generalBalanceBodyModel: GeneralBalanceBodyModel(
                                  datefrom: dateFrom,
                                  dateto: dateTo,
                                  comID: 0,
                                  iszero: checkboxValue,
                                  accName: "",
                                  accName2: "",
                                  iscompany: true),
                            );
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
                              BlocProvider.of<GeneralBalanceCubit>(context)
                                  .getGeneralBalance(
                                generalBalanceBodyModel:
                                    GeneralBalanceBodyModel(
                                        datefrom: dateFrom,
                                        dateto: dateTo,
                                        comID: 0,
                                        iszero: checkboxValue,
                                        accName: "",
                                        accName2: "",
                                        iscompany: true),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        BlocBuilder<GeneralBalanceCubit, GeneralBalanceState>(
          builder: (context, state) {
            if (state is GeneralBalanceSuccess) {
              List<GeneralBalanceModel> generalBalance =
                  state.generalBalanceModel;
              List<GeneralBalanceModel> generalBalanceList = [];
              for (var i in generalBalance) {
                if (i.creditORDepit == true) {
                  generalBalanceList.add(i);
                }
              }
              for (var i in generalBalance) {
                if (i.creditORDepit != true) {
                  generalBalanceList.add(i);
                }
              }

              return GeneralBalanceTable(
                generalBalanceList: generalBalanceList,
                // selectionItemsShow: selectionItems,
              );
            } else if (state is GeneralBalanceFailure) {
              return CustomErrorMassage(errorMassage: state.errorMassage);
            } else if (state is GeneralBalanceLoading) {
              return const CustomLoadingWidget();
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  // void _showMultiSelectDialog() async {
  //   final List<String> items = [
  //     AppStrings.openingBalances,
  //     AppStrings.movement,
  //     AppStrings.totals,
  //     AppStrings.closingBalances,
  //   ];
  //   final List<String>? results = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return MultiSelect(
  //         items: items,
  //         selectionItems: selectionItems,
  //       );
  //     },
  //   );
  //   if (results != null) {
  //     setState(() {
  //       selectionItems = results;
  //     });
  //     if (dateFrom.isNotEmpty && dateTo.isNotEmpty) {
  //       BlocProvider.of<TrialBalanceCubit>(context).getTrialBalance(
  //         trialBalanceBody: TrialBalanceBodyModel(
  //             datefrom: dateFrom,
  //             dateto: dateTo,
  //             product: 0,
  //             comID: 0,
  //             iszero: checkboxValue,
  //             currancy: 0,
  //             customer: 0,
  //             supplier: 0,
  //             cost: 0,
  //             iscompany: true),
  //       );
  //     }
  //   }
  // }
}
