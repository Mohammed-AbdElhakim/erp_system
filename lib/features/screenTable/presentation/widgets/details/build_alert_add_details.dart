import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:erp_system/features/screenTable/presentation/widgets/mainview/group/table_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../../core/helper/AlertDialog/custom_alert_dialog.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_loading_widget.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/screen_model.dart';
import '../../../data/models/tap_model.dart';
import '../../manager/addEdit/add_edit_cubit.dart';
import '../../manager/getPageDetailsTable/get_page_details_table_cubit.dart';
import '../mainview/general/table_general.dart';

typedef OnTapAdd<T> = void Function(T newRowData);

class BuildAlertAddDetails extends StatefulWidget {
  const BuildAlertAddDetails(
      {super.key,
      required this.columnList,
      required this.pageData,
      required this.tap,
      required this.mainId,
      required this.onTapAdd});
  final List<ColumnList> columnList;
  final Pages pageData;
  final ListTaps tap;
  final String mainId;

  final OnTapAdd<Map<String, dynamic>> onTapAdd;

  @override
  State<BuildAlertAddDetails> createState() => _BuildAlertAddDetailsState();
}

class _BuildAlertAddDetailsState extends State<BuildAlertAddDetails> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  bool isShow = false;
  late List<String> myListCategory;
  late List<AllDropdownModel> myAllDropdownModelList;

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
    newRowData[widget.tap.foreignKey] = widget.mainId;
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
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                categoryName,
                                style: AppStyles.textStyle18
                                    .copyWith(color: Colors.black),
                              )),
                          ...getMyWidgetList(
                              columnList: widget.columnList,
                              categoryName: categoryName,
                              show: true),
                          Visibility(
                            visible: isShow,
                            child: Column(
                              children: getMyWidgetList(
                                  columnList: widget.columnList,
                                  categoryName: categoryName,
                                  show: false),
                            ),
                          ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    text: S.of(context).cancel,
                    width: 80,
                    noGradient: true,
                    color: Colors.transparent,
                    noShadow: true,
                    textStyle:
                        AppStyles.textStyle16.copyWith(color: Colors.grey),
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
                        BlocProvider.of<GetPageDetailsTableCubit>(context)
                            .getPageDetailsTable(
                                tapData: ListTaps(
                                  pageID: widget.tap.pageID,
                                  pageDisplay: widget.tap.pageDisplay,
                                  masterName: widget.tap.masterName,
                                  modulName: widget.tap.modulName,
                                  masterID: widget.tap.masterID,
                                  modulID: widget.tap.modulID,
                                  detailId: widget.tap.detailId,
                                  listName: widget.tap.listName,
                                  tableName: widget.tap.tableName,
                                  primary: widget.tap.primary,
                                  controllerName: widget.tap.controllerName,
                                  tableSrc: widget.tap.tableSrc,
                                  editSrc: widget.tap.editSrc,
                                  isCompany: widget.tap.isCompany,
                                  companyName: widget.tap.companyName,
                                  showPrint: widget.tap.showPrint,
                                  showExport: widget.tap.showExport,
                                  showSearch: widget.tap.showSearch,
                                  showEdit: widget.tap.showEdit,
                                  showDelete: widget.tap.showDelete,
                                  showRowPrint: widget.tap.showRowPrint,
                                  showNew: widget.tap.showNew,
                                  searchFirst: widget.tap.searchFirst,
                                  showSetting: widget.tap.showSetting,
                                  showMasterButton: widget.tap.showMasterButton,
                                  canDrag: widget.tap.canDrag,
                                  canGroup: widget.tap.canGroup,
                                  showSum: widget.tap.showSum,
                                  showColumnSetting:
                                      widget.tap.showColumnSetting,
                                  showRefersh: widget.tap.showRefersh,
                                  canSort: widget.tap.canSort,
                                  showPaging: widget.tap.showPaging,
                                  showGroup: widget.tap.showGroup,
                                  dataSourceApi: widget.tap.dataSourceApi,
                                  limit: 10,
                                  orderBy: widget.tap.orderBy,
                                  tailCondition: widget.tap.tailCondition,
                                  master: widget.tap.master,
                                  foreignKey: widget.tap.foreignKey,
                                  foreignKeyValue: widget.tap.foreignKeyValue,
                                  groupLayout: widget.tap.groupLayout,
                                  groupColumn: widget.tap.groupColumn,
                                  outSiderGroupColumn:
                                      widget.tap.outSiderGroupColumn,
                                  editOnly: widget.tap.editOnly,
                                  listMaster: widget.tap.listMaster,
                                  excel: widget.tap.excel,
                                  excelNew: widget.tap.excelNew,
                                  showInPopUp: widget.tap.showInPopUp,
                                  pageAttributeId: widget.tap.pageAttributeId,
                                  displayArabic: widget.tap.displayArabic,
                                  displayEnglish: widget.tap.displayEnglish,
                                  displayChinese: widget.tap.displayChinese,
                                  columnColor: widget.tap.columnColor,
                                  enName: widget.tap.enName,
                                  isDesc: widget.tap.isDesc,
                                  unaryColumn: widget.tap.unaryColumn,
                                  numberOfEmptyRow: widget.tap.numberOfEmptyRow,
                                  offset: 0,
                                  statment:
                                      "and ${widget.tap.foreignKey}  =  ${widget.mainId} ",
                                ),
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
                              widget.onTapAdd(newRowData);
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

  List<Widget> getMyWidgetList({
    required List<ColumnList> columnList,
    required String categoryName,
    required bool show,
  }) {
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
        list.add(
          Padding(
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
        );
      }
      //number
      if (item.insertType == "number" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        list.add(
          Padding(
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
        );
      }
      //Date
      if (item.insertType == "date" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        String date = '';
        list.add(
          Padding(
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
                          });

                          dsetState(() {
                            newRowData.addAll({
                              item.columnName!.toString(): dateTime.toString()
                            });
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
        );
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
        list.add(
          Padding(
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
                  decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  // validator: (value) {
                  //   if (value?.isEmpty ?? true) {
                  //     return S.of(context).field_is_required;
                  //   } else {
                  //     return null;
                  //   }
                  // },
                  items: myListDrop!.isEmpty
                      ? [""]
                      : List.generate(myListDrop.length,
                          (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!
                        .firstWhere((element) => element.text == value);
                    newRowData.addAll({item.searchName!.toString(): ii.id});
                  },
                ),
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox" &&
          item.insertVisable == true &&
          item.categoryName == categoryName &&
          item.insertDefult == show) {
        bool checkboxValue = false;
        list.add(
          StatefulBuilder(
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
                    });
                  });
            },
          ),
        );
      }
    }
    return list;
  }
}