import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

import '../../../../core/models/menu_model/pages.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../data/models/dropdown_model/all_dropdown_model.dart';
import '../../data/models/item_list_setup_model.dart';

class CustomTableAdd extends StatefulWidget {
  const CustomTableAdd({
    super.key,
    required this.listHeader,
    required this.listKey,
    required this.listColumn,
    required this.allDropdownModelList,
    required this.pageData,
  });
  final Pages pageData;
  final List<String> listHeader;
  final List<dynamic> listKey;
  final List<ItemListSetupModel> listColumn;
  final List<AllDropdownModel> allDropdownModelList;

  @override
  State<CustomTableAdd> createState() => _CustomTableAddState();
}

class _CustomTableAddState extends State<CustomTableAdd> {
  LinkedScrollControllerGroup controllerGroup = LinkedScrollControllerGroup();
  ScrollController? headerScrollController;
  ScrollController? dataScrollController;

  @override
  void initState() {
    headerScrollController = controllerGroup.addAndGet();
    dataScrollController = controllerGroup.addAndGet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //*********************** data **************************
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: dataScrollController,
          child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 15,
            dataRowMinHeight: 50,
            dataRowMaxHeight: 50,
            headingRowHeight: 35,
            headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
            columns: [
              ...List.generate(
                widget.listHeader.length,
                (index) {
                  return DataColumn(
                    label: Expanded(
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          widget.listHeader[index],
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
            rows: List.generate(
              3,
              (index) => DataRow(
                cells: [
                  ...List.generate(
                    widget.listHeader.length,
                    (i) => DataCell(
                      SizedBox(
                        width: 130,
                        child: buildMyWidget(widget.listColumn[i], index),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        //********************* header **********************
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: headerScrollController,
          child: DataTable(
            columnSpacing: 0,
            horizontalMargin: 15,
            dataRowMinHeight: 50,
            dataRowMaxHeight: 50,
            headingRowHeight: 35,
            headingRowColor: MaterialStateProperty.all(AppColors.blueLight),
            columns: [
              ...List.generate(
                widget.listHeader.length,
                (index) {
                  return DataColumn(
                    label: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 130,
                        child: Text(
                          widget.listHeader[index],
                          textAlign: TextAlign.center,
                          style: AppStyles.textStyle14,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
            rows: const [],
          ),
        )
      ],
    );
  }

  buildMyWidget(ItemListSetupModel columnList, int indexRow) {
    switch (columnList.insertType) {
      case "date":
        return const Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "date",
        );
      case "checkbox":
        return const Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "checkbox",
        );

      case "dropdown":
        List<ListDrop>? listDrop = [];
        List<ItemDrop>? myListDrop = [];

        for (var ii in widget.allDropdownModelList) {
          if (ii.listName == widget.pageData.listName) {
            listDrop = ii.list;
          }
        }
        for (var ii in listDrop!) {
          if (ii.columnName == columnList.columnName) {
            myListDrop = ii.list;
          }
        }
        return CustomDropdown<String>.search(
          hintText: '',
          decoration: CustomDropdownDecoration(
            headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
            closedFillColor: Colors.transparent,
          ),
          items: myListDrop!.isEmpty
              ? [""]
              : List.generate(
                  myListDrop.length, (index) => myListDrop![index].text ?? ''),
          onChanged: (value) {},
        );
      default:
        return const CustomTextFormField(
          hintText: '',
          isBorder: false,
        );
    }
  }
}
