import 'package:erp_system/core/utils/app_styles.dart';
import 'package:erp_system/core/utils/service_locator.dart';
import 'package:erp_system/core/widgets/custom_error_massage.dart';
import 'package:erp_system/core/widgets/custom_loading_widget.dart';
import 'package:erp_system/features/screenTable/data/repositories/screen_repo_impl.dart';
import 'package:erp_system/features/screenTable/presentation/manager/getById/get_by_id_cubit.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/screen_table_body.dart';
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
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ScreenTableBody.rowData = {};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetByIdCubit(getIt.get<ScreenRepoImpl>())
        ..getById(
            id: ScreenTableBody.rowData[widget.pageData.primary].toString(),
            controllerName: widget.pageData.controllerName),
      child: BlocBuilder<GetByIdCubit, GetByIdState>(
        builder: (context, state) {
          if (state is GetByIdSuccess) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...getMyWidgetList(widget.columnList, state.valueGetById),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Center(
                      child: CustomButton(
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

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is GetByIdFailure) {
            return CustomErrorMassage(errorMassage: state.errorMassage);
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }

  getMyWidgetList(List<ColumnList> columnList, Map<String, dynamic> rowData) {
    List<Widget> listWidgets = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      if (item.insertType == "text" && item.insertVisable == true) {
        //TODO:text
        TextEditingController controller =
            TextEditingController(text: rowData[item.columnName].toString());
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
                      rowData.updateAll((key, value) =>
                          key == item.columnName!.toString()
                              ? value = controller.text
                              : value);
                      newRowData = rowData;
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
        TextEditingController controller =
            TextEditingController(text: rowData[item.columnName].toString());

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
                      rowData.updateAll((key, value) =>
                          key == item.columnName!.toString()
                              ? value = controller.text
                              : value);
                      newRowData = rowData;
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
        String date = DateFormat("yyyy-MM-dd", 'en')
            .format(DateTime.parse(rowData[item.columnName].toString()));
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
                            newRowData.updateAll((key, value) =>
                                key == item.columnName!.toString()
                                    ? value = dateTime
                                    : value);
                            newRowData = rowData;
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
        bool checkboxValue = rowData[item.columnName] ?? false;

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
                      rowData.updateAll((key, value) =>
                          key == item.columnName!.toString()
                              ? value = checkboxValue
                              : value);
                      newRowData = rowData;
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
