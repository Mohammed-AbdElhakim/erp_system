import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/screen_model.dart';
import 'dropdown_widget.dart';

class BuildAlertAdd extends StatefulWidget {
  const BuildAlertAdd(
      {super.key, required this.columnList, required this.pageData});
  final List<ColumnList> columnList;
  final Pages pageData;

  @override
  State<BuildAlertAdd> createState() => _BuildAlertAddState();
}

class _BuildAlertAddState extends State<BuildAlertAdd> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();

    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(widget.columnList.length);
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
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
                    text: S.of(context).btn_edit,
                    width: 80,
                    onTap: () {
                      formKey.currentState!.save();
                      print("//////////////////");
                      print(newRowData);
                      print("//////////////////");
                      // BlocProvider.of<GetTableCubit>(context).getTable(
                      //     pageId: widget.pageData.pageId.toString(),
                      //     employee: false,
                      //     isdesc: false,
                      //     limit: 10,
                      //     offset: 0,
                      //     orderby: '',
                      //     statment: '',
                      //     selectcolumns: '',
                      //     numberOfPage: 1,
                      //     dropdownValueOfLimit: 10);
                      widget.columnList.clear();
                      Navigator.pop(context);
                    },
                  ),
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
      if (item.insertType == "text" && item.insertVisable == true) {
        //TODO:text
        TextEditingController controller = TextEditingController();
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
                controller: controller,
                keyboardType: TextInputType.text,
                onSaved: (newValue) {
                  if (newValue!.isNotEmpty) {
                    setState(() {
                      newRowData
                          .addAll({item.columnName!.toString(): newValue});
                      // newRowData.updateAll((key, value) =>
                      //     key == item.columnName!.toString()
                      //         ? value = controller.text
                      //         : value);
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
        TextEditingController controller = TextEditingController();

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
                controller: controller,
                onSaved: (newValue) {
                  if (newValue!.isNotEmpty) {
                    // newRowData[item.columnName!] = newValue;

                    setState(() {
                      newRowData
                          .addAll({item.columnName!.toString(): newValue});
                      // newRowData.updateAll((key, value) =>
                      //     key == item.columnName!.toString()
                      //         ? value = controller.text
                      //         : value);
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
        String date = '';
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

                          dsetState(() {
                            newRowData.addAll(
                                {item.columnName!.toString(): dateTime});
                            // newRowData.updateAll((key, value) =>
                            //     key == item.columnName!.toString()
                            //         ? value = dateTime
                            //         : value);
                          });
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
        bool checkboxValue = false;

        listWidgets.add(
          StatefulBuilder(
            builder: (context, csetState) {
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
                    });
                    csetState(() {
                      newRowData
                          .addAll({item.columnName!.toString(): checkboxValue});
                      // newRowData.updateAll((key, value) =>
                      //     key == item.columnName!.toString()
                      //         ? value = checkboxValue
                      //         : value);
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
