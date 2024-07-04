import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_error_massage.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/repositories/screen_repo_impl.dart';
import '../../manager/addEdit/add_edit_cubit.dart';
import '../../manager/getById/get_by_id_cubit.dart';
import '../../manager/getTable/get_table_cubit.dart';
import 'general/table_general.dart';
import 'group/table_group.dart';

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
  bool isShow = false;
  late List<String> myListCategory;
  late List<AllDropdownModel> myAllDropdownModelList;
  late String id;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();

    super.didChangeDependencies();
  }

  @override
  void initState() {
    myListCategory = widget.pageData.tableSrc == AppStrings.tableGroup
        ? TableGroup.listCategory
        : TableGeneral.listCategory;
    myAllDropdownModelList = widget.pageData.tableSrc == AppStrings.tableGroup
        ? TableGroup.myAllDropdownModelList
        : TableGeneral.myAllDropdownModelList;
    id = widget.pageData.tableSrc == AppStrings.tableGroup
        ? TableGroup.rowData[0].toString()
        : TableGeneral.rowData[0][widget.pageData.primary].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetByIdCubit(getIt.get<ScreenRepoImpl>())
        ..getById(id: id, controllerName: widget.pageData.controllerName),
      child: BlocBuilder<GetByIdCubit, GetByIdState>(
        builder: (context, state) {
          if (state is GetByIdSuccess) {
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
                            ...List.generate(myListCategory.length, (index) {
                              String categoryName = myListCategory[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(.4),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Text(
                                        categoryName,
                                        style: AppStyles.textStyle18
                                            .copyWith(color: Colors.black),
                                      )),
                                  ...getMyWidgetList(
                                      columnList: widget.columnList,
                                      categoryName: categoryName,
                                      show: true,
                                      rowData: state.valueGetById),
                                  if (isShow == true)
                                    ...getMyWidgetList(
                                        columnList: widget.columnList,
                                        categoryName: categoryName,
                                        show: false,
                                        rowData: state.valueGetById),
                                ],
                              );
                            }),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isShow = !isShow;
                                });
                              },
                              child: Text(!isShow
                                  ? S.of(context).show_more
                                  : S.of(context).show_less),
                            ),
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
                            width: 80,
                            noGradient: true,
                            color: Colors.transparent,
                            noShadow: true,
                            textStyle: AppStyles.textStyle16
                                .copyWith(color: Colors.grey),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          BlocConsumer<AddEditCubit, AddEditState>(
                            listener: (context, state) {
                              if (state is AddEditSuccess) {
                                BlocProvider.of<GetTableCubit>(context)
                                    .getTable(
                                        pageId: widget.pageData.pageId,
                                        employee: false,
                                        isdesc: widget.pageData.isDesc,
                                        limit: 10,
                                        offset: 0,
                                        orderby: widget.pageData.orderBy,
                                        statment: '',
                                        selectcolumns: '',
                                        departmentName:
                                            widget.pageData.departmentName,
                                        isDepartment:
                                            widget.pageData.isDepartment,
                                        authorizationID:
                                            widget.pageData.authorizationID,
                                        viewEmployeeColumn:
                                            widget.pageData.viewEmployeeColumn,
                                        numberOfPage: 1,
                                        dropdownValueOfLimit: 10);
                                widget.columnList.clear();
                                Navigator.pop(context);
                              } else if (state is AddEditFailure) {
                                CustomAlertDialog.alertWithButton(
                                    context: context,
                                    type: AlertType.error,
                                    title: S.of(context).error,
                                    desc: state.errorMassage);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddEditLoading) {
                                return const CustomLoadingWidget();
                              } else {
                                return CustomButton(
                                  text: S.of(context).btn_edit,
                                  width: 80,
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();

                                      BlocProvider.of<AddEditCubit>(context)
                                          .edit(
                                              controllerName: widget
                                                  .pageData.controllerName,
                                              body: newRowData);
                                    }
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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

  getMyWidgetList({
    required List<ColumnList> columnList,
    required Map<String, dynamic> rowData,
    required String categoryName,
    required bool show,
  }) {
    // List<Widget> listWidgets = [];
    List<Widget> list = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      //text
      if (item.insertType == "text" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        TextEditingController controller = TextEditingController(
            text: rowData[item.columnName].toString() == "null"
                ? ''
                : rowData[item.columnName]);
        list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  if (item.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                controller: controller,
                isValidator: item.isRquired!,
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
      //number
      if (item.insertType == "number" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        TextEditingController controller = TextEditingController(
            text: rowData[item.columnName].toString() == "null"
                ? ''
                : rowData[item.columnName].toString());

        list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  if (item.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                keyboardType: TextInputType.number,
                isValidator: item.isRquired!,
                controller: controller,
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
              ),
            ],
          ),
        ));
      }
      //Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        String date;
        if (rowData[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(
              DateTime.parse(rowData[item.columnName].toString()).toLocal());
        } else {
          // date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
          date = '';
        }

        list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
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
                          rowData.updateAll((key, value) =>
                              key == item.columnName!.toString()
                                  ? value = dateTime.toString()
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
        ));
      }
      //dropdown
      if (item.insertType == "dropdown" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];

        for (var ii in myAllDropdownModelList) {
          if (ii.listName == widget.pageData.listName) {
            listDrop = ii.list;
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list;
          }
        }
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.text.toString() == rowData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.text.toString() == rowData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.text.toString() == rowData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.text.toString() == rowData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
        }
        list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: AppStyles.textStyle14.copyWith(color: Colors.grey),
                  ),
                  if (item.isRquired == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomDropdown<String>.search(
                hintText: '',
                initialItem: dropValue,
                decoration: CustomDropdownDecoration(
                    headerStyle:
                        AppStyles.textStyle16.copyWith(color: Colors.black),
                    closedFillColor: Colors.transparent,
                    closedBorder: Border.all(color: AppColors.blueDark)),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return S.of(context).field_is_required;
                  } else {
                    return null;
                  }
                },
                items: myListDrop.isEmpty
                    ? ['']
                    : List.generate(myListDrop.length,
                        (index) => myListDrop![index].text ?? ''),
                onChanged: (value) {
                  newRowData.addAll({item.searchName!.toString(): value});
                },
              ),
            ],
          ),
        ));
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        bool checkboxValue = rowData[item.columnName] ?? false;

        list.add(StatefulBuilder(
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
        ));
      }
    }

    return list;
  }
}
