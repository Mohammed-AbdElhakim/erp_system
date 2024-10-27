import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../core/models/menu_model/pages.dart';
import '../../../../../../../core/models/widgets_data.dart';
import '../../../../../../../core/utils/app_colors.dart';
import '../../../../../../../core/utils/app_strings.dart';
import '../../../../../../../core/utils/app_styles.dart';
import '../../../../../../../core/widgets/custom_button.dart';
import '../../../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../../../data/models/item_list_setup_model.dart';
import '../../../../../data/models/tap_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class ExtractionSupplierAlertDialogEditWidget extends StatefulWidget {
  const ExtractionSupplierAlertDialogEditWidget({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAdd,
    required this.dataOld,
    required this.typeView,
  });
  final ListTaps? tapData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Pages pageData;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final Map<String, dynamic> dataOld;
  final String typeView;

  @override
  State<ExtractionSupplierAlertDialogEditWidget> createState() =>
      _ExtractionSupplierAlertDialogEditWidgetState();
}

class _ExtractionSupplierAlertDialogEditWidgetState
    extends State<ExtractionSupplierAlertDialogEditWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};
  late List<AllDropdownModel> myAllDropdownModelList;
  final List<WidgetsData> widgetsData = [];

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    for (var i in widget.listColumn) {
      for (var j in widget.dataOld.keys) {
        if (i.columnName == j) {
          widgetsData.add(WidgetsData(i, widget.dataOld[j]));
        }
      }
    }
    myAllDropdownModelList = widget.allDropdownModelList;
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
                    ...List.generate(
                      widgetsData.length,
                      (index) {
                        final widgetData = widgetsData[index];
                        ItemListSetupModel itemColumnList = widgetData.widget;
                        String title = lang == AppStrings.arLangKey
                            ? itemColumnList.arColumnLabel!
                            : itemColumnList.enColumnLabel!;
                        if (itemColumnList.insertType == "text") {
                          return buildTextAndNumberWidget(title, itemColumnList,
                              widgetData, TextInputType.text);
                        } else if (itemColumnList.insertType == "number") {
                          return buildTextAndNumberWidget(title, itemColumnList,
                              widgetData, TextInputType.number);
                        } else if (itemColumnList.insertType == "checkbox") {
                          return buildCheckBoxWidget(
                              widgetData, title, itemColumnList);
                        } else if (itemColumnList.insertType == "date") {
                          return buildDateWidget(
                              title, itemColumnList, widgetData);
                        } else if (itemColumnList.insertType == "dropdown") {
                          return buildDropdownWidget(
                              title, itemColumnList, widgetData);
                        } else {
                          return Text("${itemColumnList.insertType}");
                        }
                      },
                    )
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
                  CustomButton(
                    text: S.of(context).btn_edit,
                    width: 80,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        for (var i in widgetsData) {
                          newRowData[(i.widget as ItemListSetupModel)
                              .columnName!] = i.value;
                        }
                        widget.onTapAdd(newRowData);
                        Navigator.pop(context);
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

  Widget buildTextAndNumberWidget(
      String title,
      ItemListSetupModel itemColumnList,
      WidgetsData widgetData,
      TextInputType? keyboardType) {
    return StatefulBuilder(
      builder: (context, tNSetState) {
        return Padding(
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
                  if (itemColumnList.isRquired! == true)
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 10,
                    )
                ],
              ),
              CustomTextFormField(
                hintText: '',
                isValidator: itemColumnList.isRquired!,
                keyboardType: keyboardType,
                controller: TextEditingController(text: widgetData.value),
                onChanged: (value) {
                  tNSetState(() {
                    widgetData.value = "";
                    widgetData.value = value;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDateWidget(
      String title, ItemListSetupModel itemColumnList, WidgetsData widgetData) {
    String date = widgetData.value != ""
        ? DateFormat("yyyy-MM-dd", 'en')
            .format(DateTime.parse(widgetData.value))
        : "";
    return Padding(
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
              if (itemColumnList.isRquired == true)
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
                      date = DateFormat("yyyy-MM-dd", 'en').format(dateTime);
                      widgetData.value = "";
                      widgetData.value = dateTime.toString();
                    });
                  }
                },
                child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.blueDark)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      date,
                      textAlign: TextAlign.center,
                      style:
                          AppStyles.textStyle14.copyWith(color: Colors.black),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownWidget(
    String title,
    ItemListSetupModel itemColumnList,
    WidgetsData widgetData,
  ) {
    List<ListDrop>? listDrop = [];
    List<ItemDrop>? myListDrop = [];

    for (var ii in myAllDropdownModelList) {
      if (ii.listName == widget.tapData!.listName) {
        listDrop = ii.list;
      }
    }
    for (var ii in listDrop!) {
      if (ii.columnName == itemColumnList.columnName) {
        myListDrop = ii.list;
      }
    }
    String? dropValue;

    for (var i in myListDrop!) {
      if (i.id.toString() == widgetData.value.toString()) {
        dropValue = i.text ?? '';
      }
    }

    return Padding(
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
              if (itemColumnList.isRquired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                ),
            ],
          ),
          StatefulBuilder(
            builder: (context, dropSetState) {
              return SizedBox(
                  height: 40,
                  child: CustomDropdown<String>.search(
                    hintText: '',
                    initialItem: dropValue,
                    closedHeaderPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark),
                    ),
                    items: myListDrop!.isEmpty
                        ? [""]
                        : List.generate(myListDrop.length,
                            (index) => myListDrop![index].text ?? ''),
                    onChanged: (value) {
                      dropSetState(() {
                        ItemDrop ii = myListDrop!
                            .firstWhere((element) => element.text == value);
                        widgetData.value = "";
                        widgetData.value = ii.id;
                      });
                    },
                  ));
            },
          )
        ],
      ),
    );
  }

  StatefulBuilder buildCheckBoxWidget(
      WidgetsData widgetData, String title, ItemListSetupModel itemColumnList) {
    return StatefulBuilder(
      builder: (context, csetState) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: widgetData.value,
          controlAffinity: ListTileControlAffinity.leading,
          title: Row(
            children: [
              Text(
                title,
                style: AppStyles.textStyle14.copyWith(color: Colors.black),
              ),
              if (itemColumnList.isRquired == true)
                const Icon(
                  Icons.star,
                  color: Colors.red,
                  size: 10,
                )
            ],
          ),
          onChanged: (newValue) {
            csetState(() {
              widgetData.value = false;
              widgetData.value = newValue;
            });
          },
        );
      },
    );
  }
}
