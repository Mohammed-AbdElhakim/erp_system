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
      required this.onTapAdd,
      this.paddingBottom});

  final int numberOfRecords;
  final OnChangeLimit<int> onChangeLimit;
  final List<int> listNumberItemInList;
  final int dropdownValue;
  final int myPage;
  final int allPages;
  final double? paddingBottom;
  final void Function() onTapMin;
  final void Function() onTapAdd;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          bottom: widget.paddingBottom ?? 8, end: 8, start: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * .65,
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
                // if (widget.myPage > 1 && widget.myPage <= widget.allPages)
                InkWell(
                  onTap: (widget.myPage > 1 && widget.myPage <= widget.allPages)
                      ? widget.onTapMin
                      : () {},
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_left,
                      color: (widget.myPage > 1 &&
                              widget.myPage <= widget.allPages)
                          ? AppColors.blueLight
                          : Colors.transparent,
                      size: 30,
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  "${widget.myPage} ... ${widget.allPages}",
                  textAlign: TextAlign.center,
                )),
                // if (widget.allPages > 1 && widget.myPage < widget.allPages)
                InkWell(
                  onTap:
                      (widget.allPages > 1 && widget.myPage < widget.allPages)
                          ? widget.onTapAdd
                          : () {},
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_right,
                      color: (widget.allPages > 1 &&
                              widget.myPage < widget.allPages)
                          ? AppColors.blueLight
                          : Colors.transparent,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                    "${S.of(context).Total_number_of_entries}  ${widget.numberOfRecords}"),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
