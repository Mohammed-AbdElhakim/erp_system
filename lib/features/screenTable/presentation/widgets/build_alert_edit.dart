import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getTable/get_table_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/screen_model.dart';
import 'dropdown_widget.dart';

class BuildAlertEdit extends StatefulWidget {
  const BuildAlertEdit(
      {super.key, required this.columnList, required this.pageData});
  final List<ColumnList> columnList;
  final Pages pageData;

  @override
  State<BuildAlertEdit> createState() => _BuildAlertEditState();
}

class _BuildAlertEditState extends State<BuildAlertEdit> {
  String? lang;
  String statment = '';
  GlobalKey<FormState> formKey = GlobalKey();
  bool checkboxValue = false;
  String date = '';

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...getMyWidgetList(widget.columnList),
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Center(
              child: CustomButton(
                text: S.of(context).btn_edit,
                width: 80,
                onTap: () {
                  formKey.currentState!.save();
                  BlocProvider.of<GetTableCubit>(context).getTable(
                      pageId: widget.pageData.pageId.toString(),
                      employee: false,
                      isdesc: false,
                      limit: 10,
                      offset: 0,
                      orderby: '',
                      statment: statment,
                      selectcolumns: '',
                      numberOfPage: 1,
                      dropdownValueOfLimit: 10);
                  print("***************");
                  print(statment);
                  print("***************");
                  Navigator.pop(context);
                  // GoRouter.of(context).pushReplacementNamed(AppRouter.kScreenView);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  getMyWidgetList(List<ColumnList> columnList) {
    List<Widget> listWidgets = [];

    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      if (item.insertType == "text" && item.insertVisable == true) {
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
                    });
                  }
                },
              )
            ],
          ),
        ));
      }
      if (item.insertType == "number" && item.insertVisable == true) {
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
              CustomTextFormField(
                hintText: '',
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  if (value!.isNotEmpty) {
                    setState(() {
                      statment = "${statment}and ${item.searchName} <= $value ";
                    });
                  }
                },
              ),
            ],
          ),
        ));
      }
      if (item.insertType == "date" && item.insertVisable == true) {
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
                StatefulBuilder(
                  builder: (context, dsetState) {
                    return InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2100),
                        );
                        if (dateTime != null) {
                          dsetState(() {
                            date =
                                DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                            // dateFrom = dateTime.toString();
                          });
                          statment =
                              "${statment}and Convert(date,  ${item.searchName} )>= Convert(date, '$date') ";
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: AppColors.blueDark)),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            date,
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14
                                .copyWith(color: Colors.black),
                          )),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }
      //TODO:dropdown
      if (item.insertType == "dropdown" && item.insertVisable == true) {
        listWidgets.add(DropdownWidget(title: title));
      }
      //TODO:checkbox
      if (item.insertType == "checkbox" && item.insertVisable == true) {
        listWidgets.add(
          StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.black),
                  ),
                  onChanged: (newValue) {
                    csetState(() {
                      checkboxValue = !checkboxValue;
                      if (checkboxValue == true) {
                        statment = "${statment}and ${item.searchName} = 1 ";
                      } else {
                        if (statment.contains("and ${item.searchName} = 1 ")) {
                          statment = statment.replaceAll(
                              "and ${item.searchName} = 1 ", '');
                        }
                        statment =
                            "${statment}and (${item.searchName} = 0 or ${item.searchName} is null) ";
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

class ListModel {
  final Widget widget;
  final String data;

  ListModel({required this.widget, required this.data});
}
