import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/features/screenTable/data/models/dropdown_model.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getTable/get_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/getDropdownList/get_dropdown_list_cubit.dart';
import 'screen_table_body.dart';

class BuildAlertSearch extends StatefulWidget {
  const BuildAlertSearch(
      {super.key, required this.columnList, required this.pageId});
  final List<ColumnList> columnList;
  final String pageId;
  static String statement = '';

  @override
  State<BuildAlertSearch> createState() => _BuildAlertSearchState();
}

class _BuildAlertSearchState extends State<BuildAlertSearch> {
  String? lang;
  String statment = '';
  GlobalKey<FormState> formKey = GlobalKey();
  bool checkboxValue = false;
  bool checkboxValue2 = false;
  late String dateFrom;
  late String dateTo;
  late String companyKey;
  late String token;
  late String host;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    dateFrom = S.of(context).from;
    dateTo = S.of(context).to;

    super.didChangeDependencies();
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
              padding: const EdgeInsets.only(bottom: 35),
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
              bottom: -25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: S.of(context).cancel,
                    width: 40,
                    height: 25,
                    noGradient: true,
                    textStyle: AppStyles.textStyle12,
                    color: Colors.grey,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  CustomButton(
                    text: S.of(context).btn_search,
                    width: 80,
                    onTap: () {
                      formKey.currentState!.save();
                      ScreenTableBody.isSearch = true;
                      BlocProvider.of<GetTableCubit>(context)
                          .getTable(
                              pageId: widget.pageId,
                              employee: false,
                              isdesc: false,
                              limit: 10,
                              offset: 0,
                              orderby: '',
                              statment: statment,
                              selectcolumns: '',
                              numberOfPage: 1,
                              dropdownValueOfLimit: 10)
                          .then((value) => widget.columnList.clear());

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
                hintText: '',
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  if (value!.isNotEmpty) {
                    setState(() {
                      statment =
                          "${statment}and ${item.searchName} like N'%$value%' ";
                      BuildAlertSearch.statement = statment;
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
                      hintText: S.of(context).from,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            statment =
                                "${statment}and ${item.searchName} >= $value ";
                            BuildAlertSearch.statement = statment;
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  //number to
                  Expanded(
                    child: CustomTextFormField(
                      hintText: S.of(context).to,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        if (value!.isNotEmpty) {
                          setState(() {
                            statment =
                                "${statment}and ${item.searchName} <= $value ";
                            BuildAlertSearch.statement = statment;
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
                            BuildAlertSearch.statement = statment;
                          } else {
                            if (statment.contains(
                                "and ${item.searchName} <> 0 and ${item.searchName} is not null ")) {
                              statment = statment.replaceAll(
                                  "and ${item.searchName} <> 0 and ${item.searchName} is not null ",
                                  '');
                              BuildAlertSearch.statement = statment;
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
                                BuildAlertSearch.statement = statment;
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
                                BuildAlertSearch.statement = statment;
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
        List<ListDropdown> dropList = [];
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
                  height: 40,
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
                          dropList = state.dropdownModel.list;
                        }
                      },
                      builder: (context, state) {
                        return StatefulBuilder(
                          builder: (context, dsetState) {
                            String st = "";
                            return DropDownMultiSelect(
                              onChanged: (List<String> x) {
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
                                  BuildAlertSearch.statement = statment;
                                }
                                st += "and( ";

                                for (var element in intSelected) {
                                  st += "${item.searchName} = $element";
                                  if (element !=
                                      intSelected[intSelected.length - 1]) {
                                    st += " or ";
                                  }
                                }
                                st += " )";
                                stFinial = st;

                                statment = "$statment $stFinial";
                                BuildAlertSearch.statement = statment;
                              },
                              options: List.generate(dropList.length,
                                  (index) => dropList[index].text),
                              selectedValues: selected,
                              whenEmpty: '',
                              selected_values_style: AppStyles.textStyle14
                                  .copyWith(color: Colors.black),
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
        listWidgets.add(
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue2,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      checkboxValue2 = !checkboxValue2;
                      if (checkboxValue2 == true) {
                        statment = "${statment}and ${item.searchName} = 1 ";
                        BuildAlertSearch.statement = statment;
                      } else {
                        if (statment.contains("and ${item.searchName} = 1 ")) {
                          statment = statment.replaceAll(
                              "and ${item.searchName} = 1 ", '');
                          BuildAlertSearch.statement = statment;
                        }
                        statment =
                            "${statment}and (${item.searchName} = 0 or ${item.searchName} is null) ";
                        BuildAlertSearch.statement = statment;
                      }
                    });
                  });
            },
          ),
        );
      }
    }

    return listWidgets;
  }
}
