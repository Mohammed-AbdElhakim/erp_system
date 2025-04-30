import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../generated/l10n.dart';

typedef OnChangeLimit<int> = void Function(int limit);

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    super.key,
    required this.numberOfRecords,
    required this.onChangeLimit,
    required this.listNumberItemInList,
    required this.dropdownValue,
    required this.myPage,
    required this.allPages,
    required this.onTapMin,
    required this.onTapAdd,
  });

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
    return Column(
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
                    color: (widget.myPage > 1 && widget.myPage <= widget.allPages)
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
                onTap: (widget.allPages > 1 && widget.myPage < widget.allPages)
                    ? widget.onTapAdd
                    : () {},
                child: Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.arrow_right,
                    color: (widget.allPages > 1 && widget.myPage < widget.allPages)
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
          padding: const EdgeInsetsDirectional.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${S.of(context).Total_number_of_entries}  ${widget.numberOfRecords}"),
              SizedBox(
                height: 50.0,
                width: 110.0,
                child: CustomDropdown<int>(
                  hintText: '',
                  initialItem: widget.dropdownValue,
                  closedHeaderPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: CustomDropdownDecoration(
                    headerStyle: AppStyles.textStyle16.copyWith(color: Colors.black),
                    closedFillColor: Colors.transparent,
                  ),
                  items: widget.listNumberItemInList,
                  onChanged: (selectValue) {
                    widget.onChangeLimit(selectValue!);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
