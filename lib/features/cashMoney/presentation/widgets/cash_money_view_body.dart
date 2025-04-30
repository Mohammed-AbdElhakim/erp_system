import 'package:erp_system/core/manager/listSetup/list_setup_cubit.dart';
import 'package:erp_system/core/repositories/general/general_repo_impl.dart';
import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_button.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/cashMoney/data/models/table_data_model.dart';
import 'package:erp_system/features/cashMoney/data/repositories/cashMoney/cash_money_repo_impl.dart';
import 'package:erp_system/features/cashMoney/presentation/manager/getMoney/get_money_cubit.dart';
import 'package:erp_system/features/cashMoney/presentation/manager/tableData/table_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/manager/dataGlobal/data_global_cubit.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/widgets/custom_date_widget.dart';
import '../../../../core/widgets/custom_dropdown_list.dart';
import '../../../../core/widgets/custom_text_and_number_widget.dart';
import '../../../../core/widgets/custom_time_period.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/money_account_model.dart';
import '../../data/models/table_header_model.dart';
import '../manager/saveMoney/save_money_cubit.dart';
import 'build_custom_button_with_icon.dart';
import 'custom_table_widget.dart';
import 'pagination_widget.dart';

class CashMoneyViewBody extends StatefulWidget {
  const CashMoneyViewBody({super.key, required this.scrollController, required this.pageData});

  final ScrollController scrollController;
  final Pages pageData;

  @override
  State<CashMoneyViewBody> createState() => _CashMoneyViewBodyState();
}

class _CashMoneyViewBodyState extends State<CashMoneyViewBody> {
  final Map<String, dynamic> bodyRequestToGetAccount = {"tableName": "MonyAccount"};
  final Map<String, dynamic> bodyRequestToGetDataTable = {
    "Groupby": null,
    "IsStoredProc": false,
    "arrayToSum": null,
    "authorizationID": 0,
    "company": true,
    "companyname": "ComID",
    "employee": false,
    "isCashed": false,
    "isDepartment": false,
    "isdesc": true,
    "limit": 10,
    "listName": "ProfAccount",
    "offset": 0,
    "orderby": "Edate",
    "selectFromCash": true,
    "selectcolumns": null,
    "statment": "",
    "tableName": "[ProfAccount]",
    "viewEmployeeColumn": "",
    "Params": null,
  };

  int? accountFrom;
  int? accountTo;
  String? dateFrom;
  String? dateTo;
  String? timePeriod;
  String? notes;
  String? value;
  String? date;
  bool isShowDetails = false;
  TextEditingController controllerValue = TextEditingController();

  final List<Map<String, dynamic>> widgetsData = [];

  Map<String, dynamic> myData = {};
  ScrollController verticalScrollController = ScrollController();
  ScrollController horizontalScrollController = ScrollController();

  final DataGridController dataGridController = DataGridController();
  late TableDataSource tableDataSource;

  late int allPages;
  List<int> listNumberItemInList = [10, 25, 50, 100];
  late int numberPage;
  late int dropdownValue;

  @override
  void initState() {
    numberPage = 1;
    dropdownValue = listNumberItemInList[0];
    super.initState();
  }

  @override
  void dispose() {
    controllerValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DataGlobalCubit(
            getIt.get<GeneralRepoImpl>(),
          )..getDataGlobal(bodyRequest: bodyRequestToGetAccount, link: "Structure"),
        ),
        BlocProvider(
          create: (context) => ListSetupCubit(
            getIt.get<GeneralRepoImpl>(),
          )..getListSetup(listName: "ProfAccount", link: "ProfAccount"),
        ),
        BlocProvider(
          create: (context) => GetMoneyCubit(getIt.get<CashMoneyRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => SaveMoneyCubit(getIt.get<CashMoneyRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => GetTableDataCubit(getIt.get<CashMoneyRepoImpl>()),
        ),
      ],
      child: BlocBuilder<ListSetupCubit, ListSetupState>(
        builder: (context, state) {
          if (state is ListSetupSuccess) {
            List<TableHeaderModel> listHeader = [];
            for (var i in state.data) {
              listHeader.add(TableHeaderModel.fromJson(i));
            }
            return BlocBuilder<DataGlobalCubit, DataGlobalState>(
              builder: (context, state) {
                if (state is DataGlobalSuccess) {
                  List<MoneyAccountList> moneyAccountList = [];
                  MoneyAccountModel moneyAccountModel;
                  if (moneyAccountList.isEmpty) {
                    moneyAccountModel = MoneyAccountModel.fromJson(state.data);
                    moneyAccountList = moneyAccountModel.moneyAccountList!;
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ////===================================
                        CustomDropdownList<MoneyAccountList>(
                          title: S.of(context).account,
                          onTapRefresh: () {
                            moneyAccountList.clear();
                            BlocProvider.of<DataGlobalCubit>(context)
                                .getDataGlobal(bodyRequest: bodyRequestToGetAccount, link: "Structure");
                          },
                          listData: moneyAccountList,
                          onChanged: (value) {
                            setState(() {
                              accountFrom = value?.acID;
                            });
                            bodyRequestToGetDataTable['Params'] = {
                              "Accountids": [accountFrom],
                              "dateto": dateTo,
                              "datefrom": dateFrom,
                              "per": timePeriod,
                            };
                            BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                              bodyRequest: bodyRequestToGetDataTable,
                              dropdownValueOfLimit: 10,
                              numberOfPage: 1,
                            );
                          },
                        ),
                        ////==================================
                        CustomDateWidget(
                          title: S.of(context).date_from,
                          onSelect: (date) {
                            setState(() {
                              dateFrom = date;
                            });
                            bodyRequestToGetDataTable['Params'] = {
                              "Accountids": [accountFrom],
                              "dateto": dateTo,
                              "datefrom": dateFrom,
                              "per": timePeriod,
                            };
                            BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                              bodyRequest: bodyRequestToGetDataTable,
                              dropdownValueOfLimit: 10,
                              numberOfPage: 1,
                            );
                          },
                        ),
                        ////===================================
                        CustomDateWidget(
                          title: S.of(context).date_to,
                          onSelect: (date) {
                            setState(() {
                              dateTo = date;
                            });
                            bodyRequestToGetDataTable['Params'] = {
                              "Accountids": [accountFrom],
                              "dateto": dateTo,
                              "datefrom": dateFrom,
                              "per": timePeriod,
                            };
                            BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                              bodyRequest: bodyRequestToGetDataTable,
                              dropdownValueOfLimit: 10,
                              numberOfPage: 1,
                            );
                          },
                        ),
                        ////===================================
                        CustomTimePeriod(
                          title: S.of(context).time_period,
                          onChanged: (value) {
                            setState(() {
                              timePeriod = value.id;
                            });
                            bodyRequestToGetDataTable['Params'] = {
                              "Accountids": [accountFrom],
                              "dateto": dateTo,
                              "datefrom": dateFrom,
                              "per": timePeriod,
                            };
                            BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                              bodyRequest: bodyRequestToGetDataTable,
                              dropdownValueOfLimit: 10,
                              numberOfPage: 1,
                            );
                          },
                        ),
                        ////===================================
                        CustomDropdownList<MoneyAccountList>(
                          title: S.of(context).account,
                          onTapRefresh: () {
                            moneyAccountList.clear();
                            BlocProvider.of<DataGlobalCubit>(context)
                                .getDataGlobal(bodyRequest: bodyRequestToGetAccount, link: "Structure");
                          },
                          listData: moneyAccountList,
                          onChanged: (value) {
                            setState(() {
                              accountTo = value?.acID;
                            });
                            customScrollAnimate();
                          },
                        ),
                        ////===================================
                        if (accountFrom != null && accountTo != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: CustomButton(
                              text: S.of(context).treasury_liquidation,
                              onTap: () {
                                controllerValue.clear();
                                BlocProvider.of<GetMoneyCubit>(context).getMoney(accountId: accountFrom!);
                                customScrollAnimate();
                                setState(() {
                                  isShowDetails = true;
                                });
                              },
                            ),
                          ),
                        ////====================================
                        if (isShowDetails)
                          BlocBuilder<GetMoneyCubit, GetMoneyState>(
                            builder: (context, state) {
                              if (state is GetMoneyInitial) {
                                return const SizedBox();
                              } else if (state is GetMoneySuccess) {
                                if (controllerValue.text.isEmpty) {
                                  value = controllerValue.text = state.data.toString();
                                }
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CustomTextAndNumberWidget(
                                      title: S.of(context).notes,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        setState(() {
                                          notes = value;
                                        });
                                      },
                                    ),
                                    ////====================================
                                    CustomTextAndNumberWidget(
                                      title: S.of(context).value,
                                      keyboardType: TextInputType.number,
                                      controller: controllerValue,
                                      onChanged: (val) {
                                        setState(() {
                                          value = val;
                                        });
                                      },
                                    ),
                                    ////====================================
                                    CustomDateWidget(
                                      title: S.of(context).date,
                                      onSelect: (date) {
                                        setState(() {
                                          this.date = date;
                                        });
                                      },
                                    ),

                                    ////====================================
                                    BlocConsumer<SaveMoneyCubit, SaveMoneyState>(
                                      listener: (context, state) {
                                        if (state is SaveMoneyFailure) {
                                          CustomAlertDialog.alertWithButton(
                                              context: context,
                                              type: AlertType.error,
                                              title: S.of(context).error,
                                              desc: state.errorMassage);
                                        }
                                        if (state is SaveMoneySuccess) {
                                          CustomAlertDialog.alertWithButton(
                                            context: context,
                                            type: AlertType.success,
                                            title: "",
                                            desc: S.of(context).save_ok,
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is SaveMoneyLoading) {
                                          return const CustomLoadingWidget();
                                        } else {
                                          return BuildCustomButtonWithIcon(
                                            text: S.of(context).save,
                                            icon: Icons.save,
                                            onTap: () {
                                              BlocProvider.of<SaveMoneyCubit>(context).saveMoney(bodyRequest: {
                                                "date": date,
                                                "datefrom": dateFrom,
                                                "dateto": dateTo,
                                                "mony": double.parse(value!),
                                                "note": notes,
                                                "per": timePeriod,
                                                "safeFrom": [accountFrom],
                                                "safeTo": accountTo,
                                              });
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                );
                              } else if (state is GetMoneyFailure) {
                                return CustomErrorMassage(errorMassage: state.errorMassage);
                              } else if (state is GetMoneyLoading) {
                                return const CustomLoadingWidget();
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        const SizedBox(height: 16),
                        if (accountFrom != null || dateFrom != null || dateTo != null || timePeriod != null)
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .65,
                            child: BlocBuilder<GetTableDataCubit, GetTableDataState>(
                              builder: (context, state) {
                                if (state is GetTableDataSuccess) {
                                  int? numberOfRecords = state.data.numberofrecords;
                                  List<ListItem>? listData = state.data.listData;

                                  numberPage = state.numberPage;
                                  dropdownValue = state.dropdownValue;
                                  allPages = (numberOfRecords! % dropdownValue) == 0
                                      ? (numberOfRecords ~/ dropdownValue)
                                      : (numberOfRecords ~/ dropdownValue) + 1;
                                  List<TableHeaderModel> headerInTable =
                                      listHeader.where((item) => item.visible == true && item.cvisable == true).toList();

                                  return CustomTableWidget(
                                    listData: listData!,
                                    listColumn: headerInTable,
                                    paginationWidget: PaginationWidget(
                                      allPages: allPages,
                                      dropdownValue: dropdownValue,
                                      listNumberItemInList: listNumberItemInList,
                                      myPage: numberPage,
                                      numberOfRecords: numberOfRecords,
                                      onChangeLimit: (limit) {
                                        setState(() {
                                          dropdownValue = limit;
                                          numberPage = 1;
                                          allPages = (numberOfRecords % dropdownValue) == 0
                                              ? (numberOfRecords ~/ dropdownValue)
                                              : (numberOfRecords ~/ dropdownValue) + 1;
                                        });

                                        bodyRequestToGetDataTable["offset"] = (numberPage * dropdownValue) - dropdownValue;
                                        bodyRequestToGetDataTable["limit"] = dropdownValue;
                                        BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                                          bodyRequest: bodyRequestToGetDataTable,
                                          numberOfPage: numberPage,
                                          dropdownValueOfLimit: dropdownValue,
                                        );
                                      },
                                      onTapMin: () {
                                        setState(() {
                                          numberPage--;
                                        });
                                        bodyRequestToGetDataTable["offset"] = (numberPage * dropdownValue) - dropdownValue;
                                        bodyRequestToGetDataTable["limit"] = dropdownValue;
                                        BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                                          bodyRequest: bodyRequestToGetDataTable,
                                          numberOfPage: numberPage,
                                          dropdownValueOfLimit: dropdownValue,
                                        );
                                      },
                                      onTapAdd: () {
                                        setState(() {
                                          numberPage++;
                                        });
                                        bodyRequestToGetDataTable["offset"] = (numberPage * dropdownValue) - dropdownValue;
                                        bodyRequestToGetDataTable["limit"] = dropdownValue;
                                        BlocProvider.of<GetTableDataCubit>(context).getGetTableData(
                                          bodyRequest: bodyRequestToGetDataTable,
                                          numberOfPage: numberPage,
                                          dropdownValueOfLimit: dropdownValue,
                                        );
                                      },
                                      pageData: widget.pageData,
                                      myData: bodyRequestToGetDataTable,
                                    ),
                                  );
                                } else if (state is GetTableDataFailure) {
                                  return CustomErrorMassage(errorMassage: state.errorMassage);
                                } else if (state is GetTableDataLoading) {
                                  return const CustomLoadingWidget();
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                } else if (state is DataGlobalFailure) {
                  return CustomErrorMassage(
                    errorMassage: state.errorMassage,
                  );
                } else {
                  return const CustomLoadingWidget();
                }
              },
            );
          } else if (state is ListSetupFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }

  void customScrollAnimate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController.animateTo(
        widget.scrollController.position.maxScrollExtent + 150,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });
  }
}
