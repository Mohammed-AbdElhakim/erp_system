import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/models/menu_model/pages.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../../data/models/item_list_setup_model.dart';
import '../../../data/models/tap_model.dart';

typedef OnTapAdd<T> = void Function(T data);

class AlertDialogEditWidget extends StatefulWidget {
  const AlertDialogEditWidget({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
    this.tapData,
    required this.onTapAdd,
    required this.dataOld,
  });
  final ListTaps? tapData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;
  final Pages pageData;
  final OnTapAdd<Map<String, dynamic>> onTapAdd;
  final Map<String, dynamic> dataOld;

  @override
  State<AlertDialogEditWidget> createState() => _AlertDialogEditWidgetState();
}

class _AlertDialogEditWidgetState extends State<AlertDialogEditWidget> {
  String? lang;
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic> newRowData = {};

  @override
  void didChangeDependencies() {
    lang = Localizations.localeOf(context).toString();
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
              padding: const EdgeInsets.only(bottom: 60),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...getMyWidgetList(
                        columnList: widget.listColumn,
                        show: true,
                        oldData: widget.dataOld),
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
                        print("////////////////////////");
                        print(newRowData);
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

  List<Widget> getMyWidgetList({
    required List<ItemListSetupModel> columnList,
    required bool show,
    required Map<String, dynamic> oldData,
  }) {
    List<Widget> list = [];
    for (var item in columnList) {
      String title = lang == AppStrings.arLangKey
          ? item.arColumnLabel!
          : item.enColumnLabel!;
      //text
      if (item.insertType == "text") {
        TextEditingController controller = TextEditingController(
            text: oldData[item.columnName].toString() == "null"
                ? ''
                : oldData[item.columnName]);
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
                  controller: controller,
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.text,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      if (oldData.containsKey(item.columnName)) {
                        setState(() {
                          oldData.updateAll((key, value) =>
                              key == item.columnName!.toString()
                                  ? value = controller.text
                                  : value);
                          newRowData = oldData;
                        });
                      } else {
                        setState(() {
                          oldData[item.columnName!.toString()] = newValue;
                          newRowData = oldData;
                          // newRowData
                          //     .addAll({item.columnName!.toString(): newValue});
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //number
      if (item.insertType == "number") {
        TextEditingController controller = TextEditingController(
            text: oldData[item.columnName].toString() == "null"
                ? ''
                : oldData[item.columnName].toString());
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
                  controller: controller,
                  isValidator: item.isRquired!,
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    if (newValue!.isNotEmpty) {
                      if (oldData.containsKey(item.columnName)) {
                        setState(() {
                          oldData.updateAll((key, value) =>
                              key == item.columnName!.toString()
                                  ? value = controller.text
                                  : value);
                          newRowData = oldData;
                        });
                      } else {
                        setState(() {
                          oldData[item.columnName!.toString()] = newValue;
                          newRowData = oldData;
                          // newRowData
                          //     .addAll({item.columnName!.toString(): newValue});
                        });
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //Date
      if (item.insertType == "date") {
        String date;
        if (oldData[item.columnName] != null) {
          date = DateFormat("yyyy-MM-dd", 'en').format(
              DateTime.parse(oldData[item.columnName].toString()).toLocal());
        } else {
          // date = DateFormat("yyyy-MM-dd", 'en').format(DateTime.now());
          date = '';
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
                            oldData.updateAll((key, value) =>
                                key == item.columnName!.toString()
                                    ? value = dateTime.toString()
                                    : value);
                            newRowData = oldData;
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
      if (item.insertType == "dropdown") {
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];

        for (var ii in widget.allDropdownModelList) {
          if (widget.tapData == null) {
            if (ii.listName == widget.pageData.listName) {
              listDrop = ii.list;
            }
          } else {
            if (ii.listName == widget.tapData!.listName) {
              listDrop = ii.list;
            }
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == item.columnName) {
            myListDrop = ii.list;
          }
        }
        String? dropValue;
        for (var i in myListDrop!) {
          if (i.id.toString() == oldData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.searchName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.columnName].toString()) {
            dropValue = i.text ?? '';
          }
          if (i.id.toString() == oldData[item.columnName].toString()) {
            dropValue = i.text ?? '';
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
                  initialItem: dropValue,
                  decoration: CustomDropdownDecoration(
                      headerStyle:
                          AppStyles.textStyle16.copyWith(color: Colors.black),
                      closedFillColor: Colors.transparent,
                      closedBorder: Border.all(color: AppColors.blueDark)),
                  items: myListDrop.isEmpty
                      ? [""]
                      : List.generate(myListDrop.length,
                          (index) => myListDrop![index].text ?? ''),
                  onChanged: (value) {
                    ItemDrop ii = myListDrop!
                        .firstWhere((element) => element.text == value);

                    if (oldData.containsKey(item.columnName)) {
                      setState(() {
                        oldData.updateAll((key, value) =>
                            key == item.columnName!.toString()
                                ? value = ii.id.toString()
                                : value);
                        newRowData = oldData;
                      });
                    } else {
                      // newRowData.addAll({item.columnName!.toString(): ii.id});
                      oldData[item.columnName!.toString()] = ii.id;
                      newRowData = oldData;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }
      //checkbox
      if (item.insertType == "checkbox") {
        bool checkboxValue = oldData[item.columnName] ?? false;
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
                      oldData.updateAll((key, value) =>
                          key == item.columnName!.toString()
                              ? value = checkboxValue
                              : value);
                      newRowData = oldData;
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