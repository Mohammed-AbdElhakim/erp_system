import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/methods.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/dropdown_model.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/models/tap_model.dart';
import '../../../data/repositories/screen_repo_impl.dart';
import '../../manager/getDropdownList/get_dropdown_list_cubit.dart';
import 'tap_details_widget_body.dart';

typedef OnTapSearch<T> = void Function(T myStatement);
typedef OnTapClean<T> = void Function();

class BuildAlertSearchDetails extends StatefulWidget {
  const BuildAlertSearchDetails({
    super.key,
    required this.columnList,
    required this.tap,
    required this.oldStatement,
    required this.mainId,
    required this.onTapSearch,
    required this.onTapClean,
  });
  final List<ColumnList> columnList;
  final ListTaps tap;
  final String mainId;
  final String oldStatement;
  final OnTapSearch<String> onTapSearch;
  final OnTapClean<void> onTapClean;
  static String statement = '';

  @override
  State<BuildAlertSearchDetails> createState() =>
      _BuildAlertSearchDetailsState();
}

class _BuildAlertSearchDetailsState extends State<BuildAlertSearchDetails> {
  String? lang;
  late String statment;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    statment = "and ${widget.tap.foreignKey}  =  ${widget.mainId} ";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .75,
      child: Form(
        key: formKey,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getMyWidgetList(widget.columnList),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              // bottom: -25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: S.of(context).cancel,
                    width: MediaQuery.of(context).size.width / 6,
                    noGradient: true,
                    color: Colors.transparent,
                    noShadow: true,
                    textStyle:
                        AppStyles.textStyle16.copyWith(color: Colors.grey),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                      text: S.of(context).clean,
                      width: MediaQuery.of(context).size.width / 6,
                      noGradient: true,
                      color: Colors.transparent,
                      noShadow: true,
                      textStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.grey),
                      onTap: () {
                        TapDetailsWidgetBody.isSearch = false;
                        BuildAlertSearchDetails.statement = '';
                        TapDetailsWidgetBody.isDesc = false;
                        TapDetailsWidgetBody.orderBy = widget.tap.orderBy;
                        // BlocProvider.of<GetPageDetailsTableCubit>(context)
                        //     .getPageDetailsTable(
                        //         tapData: ListTaps(
                        //           pageID: widget.tap.pageID,
                        //           pageDisplay: widget.tap.pageDisplay,
                        //           masterName: widget.tap.masterName,
                        //           modulName: widget.tap.modulName,
                        //           masterID: widget.tap.masterID,
                        //           modulID: widget.tap.modulID,
                        //           detailId: widget.tap.detailId,
                        //           listName: widget.tap.listName,
                        //           tableName: widget.tap.tableName,
                        //           primary: widget.tap.primary,
                        //           controllerName: widget.tap.controllerName,
                        //           tableSrc: widget.tap.tableSrc,
                        //           editSrc: widget.tap.editSrc,
                        //           isCompany: widget.tap.isCompany,
                        //           companyName: widget.tap.companyName,
                        //           showPrint: widget.tap.showPrint,
                        //           showExport: widget.tap.showExport,
                        //           showSearch: widget.tap.showSearch,
                        //           showEdit: widget.tap.showEdit,
                        //           showDelete: widget.tap.showDelete,
                        //           showRowPrint: widget.tap.showRowPrint,
                        //           showNew: widget.tap.showNew,
                        //           searchFirst: widget.tap.searchFirst,
                        //           showSetting: widget.tap.showSetting,
                        //           showMasterButton: widget.tap.showMasterButton,
                        //           canDrag: widget.tap.canDrag,
                        //           canGroup: widget.tap.canGroup,
                        //           showSum: widget.tap.showSum,
                        //           showColumnSetting:
                        //               widget.tap.showColumnSetting,
                        //           showRefersh: widget.tap.showRefersh,
                        //           canSort: widget.tap.canSort,
                        //           showPaging: widget.tap.showPaging,
                        //           showGroup: widget.tap.showGroup,
                        //           dataSourceApi: widget.tap.dataSourceApi,
                        //           limit: 10,
                        //           orderBy: widget.tap.orderBy,
                        //           tailCondition: widget.tap.tailCondition,
                        //           master: widget.tap.master,
                        //           foreignKey: widget.tap.foreignKey,
                        //           foreignKeyValue: widget.tap.foreignKeyValue,
                        //           groupLayout: widget.tap.groupLayout,
                        //           groupColumn: widget.tap.groupColumn,
                        //           outSiderGroupColumn:
                        //               widget.tap.outSiderGroupColumn,
                        //           editOnly: widget.tap.editOnly,
                        //           listMaster: widget.tap.listMaster,
                        //           excel: widget.tap.excel,
                        //           excelNew: widget.tap.excelNew,
                        //           showInPopUp: widget.tap.showInPopUp,
                        //           pageAttributeId: widget.tap.pageAttributeId,
                        //           displayArabic: widget.tap.displayArabic,
                        //           displayEnglish: widget.tap.displayEnglish,
                        //           displayChinese: widget.tap.displayChinese,
                        //           columnColor: widget.tap.columnColor,
                        //           enName: widget.tap.enName,
                        //           isDesc: widget.tap.isDesc,
                        //           unaryColumn: widget.tap.unaryColumn,
                        //           numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                        //           offset: 0,
                        //           statment:
                        //               "and ${widget.tap.foreignKey}  =  ${widget.mainId} ",
                        //         ),
                        //         numberOfPage: 1,
                        //         dropdownValueOfLimit: 10);
                        widget.onTapClean();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  CustomButton(
                    text: S.of(context).btn_search,
                    width: 80,
                    onTap: () {
                      formKey.currentState!.save();
                      TapDetailsWidgetBody.isSearch = true;
                      widget.onTapSearch(statment);
                      // BlocProvider.of<GetPageDetailsTableCubit>(context)
                      //     .getPageDetailsTable(
                      //         tapData: ListTaps(
                      //           pageID: widget.tap.pageID,
                      //           pageDisplay: widget.tap.pageDisplay,
                      //           masterName: widget.tap.masterName,
                      //           modulName: widget.tap.modulName,
                      //           masterID: widget.tap.masterID,
                      //           modulID: widget.tap.modulID,
                      //           detailId: widget.tap.detailId,
                      //           listName: widget.tap.listName,
                      //           tableName: widget.tap.tableName,
                      //           primary: widget.tap.primary,
                      //           controllerName: widget.tap.controllerName,
                      //           tableSrc: widget.tap.tableSrc,
                      //           editSrc: widget.tap.editSrc,
                      //           isCompany: widget.tap.isCompany,
                      //           companyName: widget.tap.companyName,
                      //           showPrint: widget.tap.showPrint,
                      //           showExport: widget.tap.showExport,
                      //           showSearch: widget.tap.showSearch,
                      //           showEdit: widget.tap.showEdit,
                      //           showDelete: widget.tap.showDelete,
                      //           showRowPrint: widget.tap.showRowPrint,
                      //           showNew: widget.tap.showNew,
                      //           searchFirst: widget.tap.searchFirst,
                      //           showSetting: widget.tap.showSetting,
                      //           showMasterButton: widget.tap.showMasterButton,
                      //           canDrag: widget.tap.canDrag,
                      //           canGroup: widget.tap.canGroup,
                      //           showSum: widget.tap.showSum,
                      //           showColumnSetting: widget.tap.showColumnSetting,
                      //           showRefersh: widget.tap.showRefersh,
                      //           canSort: widget.tap.canSort,
                      //           showPaging: widget.tap.showPaging,
                      //           showGroup: widget.tap.showGroup,
                      //           dataSourceApi: widget.tap.dataSourceApi,
                      //           limit: 10,
                      //           orderBy: widget.tap.orderBy,
                      //           tailCondition: widget.tap.tailCondition,
                      //           master: widget.tap.master,
                      //           foreignKey: widget.tap.foreignKey,
                      //           foreignKeyValue: widget.tap.foreignKeyValue,
                      //           groupLayout: widget.tap.groupLayout,
                      //           groupColumn: widget.tap.groupColumn,
                      //           outSiderGroupColumn:
                      //               widget.tap.outSiderGroupColumn,
                      //           editOnly: widget.tap.editOnly,
                      //           listMaster: widget.tap.listMaster,
                      //           excel: widget.tap.excel,
                      //           excelNew: widget.tap.excelNew,
                      //           showInPopUp: widget.tap.showInPopUp,
                      //           pageAttributeId: widget.tap.pageAttributeId,
                      //           displayArabic: widget.tap.displayArabic,
                      //           displayEnglish: widget.tap.displayEnglish,
                      //           displayChinese: widget.tap.displayChinese,
                      //           columnColor: widget.tap.columnColor,
                      //           enName: widget.tap.enName,
                      //           isDesc: widget.tap.isDesc,
                      //           unaryColumn: widget.tap.unaryColumn,
                      //           numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                      //           offset: 0,
                      //           statment: statment,
                      //         ),
                      //         numberOfPage: 1,
                      //         dropdownValueOfLimit: 10)
                      //     ;

                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getMyWidgetList(List<ColumnList> columnList) {
    List<Widget> listWidgets = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      //text
      if (item.insertType == "text" && item.visible == true) {
        String oldValue = getStringText(
            search: item.searchName!, statement: widget.oldStatement);
        TextEditingController controller =
            TextEditingController(text: oldValue);
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              CustomTextFormField(
                controller: controller,
                hintText: '',
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  if (value!.isNotEmpty) {
                    setState(() {
                      statment =
                          "${statment}and ${item.searchName} like N'%$value%' ";
                      BuildAlertSearchDetails.statement = statment;
                    });
                  }
                },
              )
            ],
          ),
        ));
      }
      //number
      if (item.insertType == "number" && item.visible == true) {
        String oldValueFrom = getStringNumber(
            search: item.searchName!,
            statement: widget.oldStatement,
            type: "F");
        String oldValueTo = getStringNumber(
            search: item.searchName!,
            statement: widget.oldStatement,
            type: "T");
        String oldValueNon = getStringNumber(
            search: item.searchName!,
            statement: widget.oldStatement,
            type: "N");
        TextEditingController controllerFrom =
            TextEditingController(text: oldValueFrom);
        TextEditingController controllerTo =
            TextEditingController(text: oldValueTo);
        bool checkboxValue = oldValueNon == "0" ? true : false;
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              Row(
                children: [
                  //number from
                  Expanded(
                    child: CustomTextFormField(
                      controller: controllerFrom,
                      hintText: S.of(context).from,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            statment =
                                "${statment}and ${item.searchName} >= $value ";
                            BuildAlertSearchDetails.statement = statment;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  //number to
                  Expanded(
                    child: CustomTextFormField(
                      controller: controllerTo,
                      hintText: S.of(context).to,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            statment =
                                "${statment}and ${item.searchName} <= $value ";
                            BuildAlertSearchDetails.statement = statment;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              // number =0
              StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) nsetState) {
                  return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      value: checkboxValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        S.of(context).massage_number_zero,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      onChanged: (newValue) {
                        nsetState(() {
                          checkboxValue = !checkboxValue;
                          if (checkboxValue == true) {
                            statment =
                                "${statment}and ${item.searchName} <> 0 and ${item.searchName} is not null ";
                            BuildAlertSearchDetails.statement = statment;
                          } else {
                            if (statment.contains(
                                "and ${item.searchName} <> 0 and ${item.searchName} is not null ")) {
                              statment = statment.replaceAll(
                                  "and ${item.searchName} <> 0 and ${item.searchName} is not null ",
                                  '');
                              BuildAlertSearchDetails.statement = statment;
                            }
                          }
                        });
                      });
                },
              ),
            ],
          ),
        ));
      }
      //Date
      if (item.insertType == "date" && item.visible == true) {
        String oldValueFrom = getStringDate(
            search: item.searchName!,
            statement: widget.oldStatement,
            type: "F");
        String oldValueTo = getStringDate(
            search: item.searchName!,
            statement: widget.oldStatement,
            type: "T");
        String dateFrom =
            oldValueFrom != '' ? oldValueFrom : S.of(context).from;
        String dateTo = oldValueTo != '' ? oldValueTo : S.of(context).to;
        listWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                ),
                Row(
                  children: [
                    //Date From
                    StatefulBuilder(
                      builder: (context, dsetState) {
                        return Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2100),
                              );
                              if (dateTime != null) {
                                dsetState(() {
                                  dateFrom = DateFormat("yyyy-MM-dd", 'en')
                                      .format(dateTime);
                                  // dateFrom = dateTime.toString();
                                });
                                statment =
                                    "${statment}and Convert(date,  ${item.searchName} )>= Convert(date, '$dateFrom') ";
                                BuildAlertSearchDetails.statement = statment;
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: AppColors.blueDark)),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  dateFrom,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyle14
                                      .copyWith(color: Colors.black),
                                )),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    //Date To
                    StatefulBuilder(
                      builder: (context, dsetState) {
                        return Expanded(
                          child: InkWell(
                            onTap: () async {
                              DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2100),
                              );
                              if (dateTime != null) {
                                dsetState(() {
                                  dateTo = DateFormat("yyyy-MM-dd", 'en')
                                      .format(dateTime);
                                  // dateFrom = dateTime.toString();
                                });
                                statment =
                                    "${statment}and  Convert(date,${item.searchName}) <= Convert(date, '$dateTo') ";
                                BuildAlertSearchDetails.statement = statment;
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: AppColors.blueDark)),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  dateTo,
                                  textAlign: TextAlign.center,
                                  style: AppStyles.textStyle14
                                      .copyWith(color: Colors.black),
                                )),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }
      //dropdown
      if (item.insertType == "dropdown" && item.visible == true) {
        String oldValue = getStringDropdown(
            statement: widget.oldStatement, search: item.searchName!);
        List<ListDropdownModel> dropList = [
          ListDropdownModel(value: -1, text: '')
        ];
        List<String> selected = [];
        List<int> intSelected = [];
        String stFinial = "";
        listWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                ),
                SizedBox(
                  // height: 40,
                  child: BlocProvider(
                    create: (context) =>
                        GetDropdownListCubit(getIt.get<ScreenRepoImpl>())
                          ..getDropdownList(
                            droModel: item.droModel ?? "",
                            droValue: item.droValue ?? "",
                            droText: item.droText ?? "",
                            droCondition: item.droCondition ?? "",
                            droCompany: item.droCompany ?? "",
                          ),
                    child: BlocConsumer<GetDropdownListCubit,
                        GetDropdownListState>(
                      listener: (context, state) {
                        if (state is GetDropdownListSuccess) {
                          dropList = state.dropdownModel.list!;
                        }
                      },
                      builder: (context, state) {
                        List<String> dropValue = [];
                        if (oldValue.isEmpty) {
                          dropValue = [];
                        } else if (oldValue.contains("or")) {
                          List<String> sList = oldValue.split(" or ");
                          for (var s in sList) {
                            String finalVal = s.substring(
                                (item.searchName!.length) + 3, s.length);
                            for (var i in dropList) {
                              if (i.value.toString() == finalVal) {
                                dropValue.add(i.text ?? '');
                              }
                            }
                          }
                        } else {
                          for (var i in dropList) {
                            if (i.value.toString() == oldValue) {
                              dropValue.add(i.text ?? '');
                            }
                          }
                        }

                        return StatefulBuilder(
                          builder: (context, dsetState) {
                            String st = "";
                            return CustomDropdown<String>.multiSelectSearch(
                              hintText: '',
                              initialItems: dropValue,
                              decoration: CustomDropdownDecoration(
                                  headerStyle: AppStyles.textStyle16
                                      .copyWith(color: Colors.black),
                                  closedFillColor: Colors.transparent,
                                  closedBorder:
                                      Border.all(color: AppColors.blueDark)),
                              items: dropList.isEmpty
                                  ? ['']
                                  : List.generate(dropList.length,
                                      (index) => dropList[index].text ?? ''),
                              onListChanged: (x) {
                                dsetState(() {
                                  selected = x;
                                });
                                intSelected.clear();
                                for (var s in selected) {
                                  for (var d in dropList) {
                                    if (s == d.text) {
                                      intSelected.add(d.value);
                                    }
                                  }
                                }
                                if (statment.contains(stFinial)) {
                                  statment = statment.replaceAll(stFinial, '');
                                  BuildAlertSearchDetails.statement = statment;
                                }
                                st += "and( ";

                                for (var element in intSelected) {
                                  st += "${item.searchName} = $element";
                                  if (element !=
                                      intSelected[intSelected.length - 1]) {
                                    st += " or ";
                                  }
                                }
                                st += " ) ";
                                stFinial = st;

                                statment = "$statment $stFinial";
                                BuildAlertSearchDetails.statement = statment;
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox" && item.visible == true) {
        String oldValue = getStringCheckbox(
            search: item.searchName!, statement: widget.oldStatement);
        String? valueCheckbox = oldValue.isEmpty ? null : oldValue;
        listWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.grey),
              ),
              StatefulBuilder(
                builder: (context, csetState) {
                  return DropdownButtonFormField(
                    value: valueCheckbox,
                    elevation: 16,
                    isExpanded: true,
                    hint: const Text(""),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.red),
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.blueDark),
                          borderRadius: BorderRadius.circular(12)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.blueDark),
                          borderRadius: BorderRadius.circular(12)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.blueDark),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    // underline: const SizedBox(),
                    onChanged: (String? newValue) {
                      csetState(() {
                        valueCheckbox = newValue!;
                        if (valueCheckbox == "True") {
                          statment = "${statment}and ${item.searchName} = 1 ";
                          BuildAlertSearchDetails.statement = statment;
                        } else {
                          if (statment
                              .contains("and ${item.searchName} = 1 ")) {
                            statment = statment.replaceAll(
                                "and ${item.searchName} = 1 ", '');
                            BuildAlertSearchDetails.statement = statment;
                          }
                          if (statment.contains(
                              "and (${item.searchName} = 0 or ${item.searchName} is null) ")) {
                            statment = statment.replaceAll(
                                "and (${item.searchName} = 0 or ${item.searchName} is null) ",
                                '');
                            BuildAlertSearchDetails.statement = statment;
                          }
                          statment =
                              "${statment}and (${item.searchName} = 0 or ${item.searchName} is null) ";
                          BuildAlertSearchDetails.statement = statment;
                        }
                      });
                    },
                    items: ["True", "False", "None"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: Text(value.toString())),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      }
    }

    return listWidgets;
  }
}