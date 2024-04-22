import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getTable/get_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/screen_model.dart';
import 'dropdown_widget.dart';
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

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    dateFrom = S.of(context).from;
    dateTo = S.of(context).to;
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(widget.columnList.length);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
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
                      print("***************");
                      print(statment);
                      print("***************");
                      Navigator.pop(context);
                      // GoRouter.of(context).pushReplacementNamed(AppRouter.kScreenView);
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
      if (item.insertType == "text" && item.visible == true) {
        //TODO:text
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
      if (item.insertType == "number" && item.visible == true) {
        //TODO:number
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
                  //TODO: number from
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
                  //TODO:number to
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
              //TODO: number =0
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
      if (item.insertType == "date" && item.visible == true) {
        //TODO:Date
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
                    //TODO:Date From
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
                    //TODO:Date To
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
      //TODO:dropdown
      if (item.insertType == "dropdown" && item.visible == true) {
        listWidgets.add(DropdownWidget(title: title));
      }
      //TODO:checkbox
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
