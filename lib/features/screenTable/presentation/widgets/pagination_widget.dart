import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../generated/l10n.dart';

typedef OnChangeLimit<int> = void Function(int limit);

class PaginationWidget extends StatefulWidget {
  const PaginationWidget(
      {super.key,
      required this.numberOfRecords,
      required this.onChangeLimit,
      required this.listNumberItemInList,
      required this.dropdownValue,
      required this.myPage,
      required this.allPages,
      required this.onTapMin,
      required this.onTapAdd});

  final int numberOfRecords;
  final OnChangeLimit<int> onChangeLimit;
  final List<int> listNumberItemInList;
  final int dropdownValue;
  final int myPage;
  final int allPages;
  final void Function() onTapMin;
  final void Function() onTapAdd;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 85, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.blueLight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.only(
              top: 12,
              bottom: 12,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                    height: 50.0,
                    width: 110.0,
                    child: DropdownButton(
                      value: widget.dropdownValue,
                      elevation: 16,
                      isExpanded: true,
                      underline: const SizedBox(),
                      onChanged: (int? newValue) {
                        widget.onChangeLimit(newValue!);
                      },
                      items: widget.listNumberItemInList
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Center(child: Text(value.toString())),
                        );
                      }).toList(),
                    )),
                const SizedBox(width: 25),
                if (widget.myPage > 1 && widget.myPage <= widget.allPages)
                  InkWell(
                    onTap: widget.onTapMin,
                    child: Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_left,
                        color: AppColors.blueLight,
                        size: 30,
                      ),
                    ),
                  ),
                Expanded(
                    child: Text(
                  "${widget.myPage} ... ${widget.allPages}",
                  textAlign: TextAlign.center,
                )),
                if (widget.allPages > 1 && widget.myPage < widget.allPages)
                  InkWell(
                    onTap: widget.onTapAdd,
                    child: Container(
                      width: 40,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.arrow_right,
                        color: AppColors.blueLight,
                        size: 30,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Text(
              "${S.of(context).Total_number_of_entries}  ${widget.numberOfRecords}")
        ],
      ),
    );
  }
}
