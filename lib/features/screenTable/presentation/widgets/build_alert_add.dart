import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/dropdown_model.dart';
import '../../data/models/screen_model.dart';
import '../../data/repositories/screen_repo_impl.dart';
import '../manager/addEdit/add_edit_cubit.dart';
import '../manager/getDropdownList/get_dropdown_list_cubit.dart';
import '../manager/getTable/get_table_cubit.dart';

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
  bool isShow = false;

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
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
              padding: const EdgeInsets.only(bottom: 35),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getMyWidgetList(widget.columnList, 10).isNotEmpty)
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            S.of(context).basic_data,
                            style: AppStyles.textStyle18
                                .copyWith(color: Colors.black),
                          )),
                    // ...getMyWidgetList(widget.columnList, 10),
                    ...List.generate(
                        getMyWidgetList(widget.columnList, 10).length, (my) {
                      ItemList itemList =
                          getMyWidgetList(widget.columnList, 10)[my];
                      return itemList.show == true
                          ? itemList.widget
                          : isShow == true
                              ? itemList.widget
                              : const SizedBox();
                    }),

                    if (getMyWidgetList(widget.columnList, 11).isNotEmpty)
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(.4),
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            S.of(context).multiple_choices,
                            style: AppStyles.textStyle18
                                .copyWith(color: Colors.black),
                          )),
                    // ...getMyWidgetList(widget.columnList, 11),
                    ...List.generate(
                        getMyWidgetList(widget.columnList, 11).length, (my) {
                      ItemList itemList =
                          getMyWidgetList(widget.columnList, 11)[my];
                      return itemList.show == true
                          ? itemList.widget
                          : isShow == true
                              ? itemList.widget
                              : const SizedBox();
                    }),

                    TextButton(
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      child: Text(!isShow ? "عرض المزيد" : "عرض أقل"),
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
                  BlocConsumer<AddEditCubit, AddEditState>(
                    listener: (context, state) {
                      if (state is AddEditSuccess) {
                        BlocProvider.of<GetTableCubit>(context).getTable(
                            pageId: widget.pageData.pageId.toString(),
                            employee: false,
                            isdesc: false,
                            limit: 10,
                            offset: 0,
                            orderby: '',
                            statment: '',
                            selectcolumns: '',
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
                          text: S.of(context).btn_add,
                          width: 80,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              BlocProvider.of<AddEditCubit>(context).add(
                                  controllerName:
                                      widget.pageData.controllerName,
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
  }

  List<ItemList> getMyWidgetList(List<ColumnList> columnList, int categoryID) {
    List<ItemList> list = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      //text
      if (item.insertType == "text" &&
          item.insertVisable == true &&
          item.categoryID == categoryID) {
        TextEditingController controller = TextEditingController();
        list.add(
          ItemList(
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.grey),
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
                          newRowData
                              .addAll({item.columnName!.toString(): newValue});
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            show: item.insertDefult!,
          ),
        );
      }
      //number
      if (item.insertType == "number" &&
          item.insertVisable == true &&
          item.categoryID == categoryID) {
        TextEditingController controller = TextEditingController();

        list.add(
          ItemList(
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.grey),
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
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) {
                      if (newValue!.isNotEmpty) {
                        setState(() {
                          newRowData
                              .addAll({item.columnName!.toString(): newValue});
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            show: item.insertDefult!,
          ),
        );
      }
      //Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryID == categoryID) {
        String date = '';
        list.add(ItemList(
            widget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.grey),
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
                              date = DateFormat("yyyy-MM-dd", 'en')
                                  .format(dateTime);
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
                  ),
                ],
              ),
            ),
            show: item.insertDefult!));
      }

      //dropdown
      if (item.insertType == "dropdown" &&
          item.insertVisable == true &&
          item.categoryID == categoryID) {
        List<ListDropdown> dropList = [];
        list.add(ItemList(
          widget: Padding(
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
                        return DropdownMenu(
                          expandedInsets: EdgeInsets.zero,
                          dropdownMenuEntries: List.generate(
                            dropList.length,
                            (index) => DropdownMenuEntry(
                                value: dropList[index].value,
                                label: dropList[index].text),
                          ),
                          onSelected: (value) {
                            if (value != null) {
                              newRowData
                                  .addAll({item.searchName!.toString(): value});
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          show: item.insertDefult!,
        ));
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.insertVisable == true &&
          item.categoryID == categoryID) {
        bool checkboxValue = false;

        list.add(ItemList(
          widget: StatefulBuilder(
            builder: (context, csetState) {
              return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: checkboxValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Row(
                    children: [
                      Text(
                        title,
                        style:
                            AppStyles.textStyle14.copyWith(color: Colors.black),
                      ),
                      if (item.isRquired == true)
                        const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 10,
                        )
                    ],
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
          show: item.insertDefult!,
        ));
      }
    }
    return list;
  }
}

class ItemList {
  final Widget widget;
  final bool show;

  ItemList({required this.widget, required this.show});
}
