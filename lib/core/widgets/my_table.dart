import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
// import 'package:sweetalert/sweetalert./dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

typedef ValueChanged<Map> = void Function(Map? value);

class MyTable extends StatefulWidget {
  final List list;
  final List? searchList;
  final String? searchWord;
  final String? getSearchWord;
  final List<String> listHeader;
  final List listData;
  final int columnNumber;
  final int numberItemInList;
  final double widthFirstColumn;
  final double widthOtherColumn;
  final double heightHeader;
  final double heightRow;
  final ValueChanged<Map>? onTap;
  const MyTable({
    super.key,
    required this.columnNumber,
    required this.list,
    this.searchList,
    this.getSearchWord,
    this.searchWord,
    required this.numberItemInList,
    this.widthFirstColumn = 100,
    this.widthOtherColumn = 150,
    this.heightHeader = 35,
    this.heightRow = 35,
    required this.listHeader,
    required this.listData,
    required this.onTap,
  });

  @override
  State<MyTable> createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  int? indexColor;
  late Map<String, dynamic>? rowData;
  ScrollController controller1 = ScrollController();
  ScrollController controller2 = ScrollController();
  late List subList;
  late int start;
  late int end;
  late int numberPage;
  ScrollController controller = ScrollController();
  late Color colorEnd;
  late Color colorStart;
  @override
  void initState() {
    super.initState();
    controller2.addListener(() {
      controller1.jumpTo(controller2.offset);
    });
    start = 0;
    end = widget.numberItemInList > widget.list.length
        ? widget.list.length
        : widget.numberItemInList;
    subList = widget.list.sublist(start, end);

    colorEnd = widget.numberItemInList > widget.list.length
        ? Colors.white
        : AppColors.blueLight;
    colorStart = AppColors.blueLight;
    numberPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    colorEnd = widget.numberItemInList > widget.list.length
        ? Colors.teal.shade50
        : AppColors.blueLight;
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          controller: controller1,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blue,
              border: Border.all(color: Colors.white, width: 1),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            height: widget.heightHeader,
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(0),
                  width: widget.widthFirstColumn,
                  child: Text(
                    widget.listHeader[0],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.maxFinite,
                  color: AppColors.white,
                ),
                ...List.generate(
                  widget.columnNumber - 1,
                  (index) => Row(
                    children: [
                      SizedBox(
                          width: widget.widthOtherColumn,
                          child: Text(
                            widget.listHeader[index + 1],
                            textAlign: TextAlign.center,
                            style: AppStyles.textStyle14,
                          )),
                      if (index != widget.columnNumber - 2)
                        Container(
                          width: 1,
                          height: double.maxFinite,
                          color: AppColors.white,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (context, upDate) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      controller: controller2,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: controller,
                        child: Column(
                          children: <Widget>[
                            ...widget.list.map((e) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: const Border.symmetric(
                                      horizontal: BorderSide(
                                          color: Colors.white, width: 1)),
                                  color: widget.list.indexOf(e).isEven
                                      ? widget.list.indexOf(e) == indexColor
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.25)
                                      : widget.list.indexOf(e) == indexColor
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(
                                      widget.list.indexOf(e) == indexColor
                                          ? 10
                                          : 0),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: widget.list.indexOf(e) == indexColor
                                    ? widget.heightRow + 15
                                    : widget.heightRow,
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                          width: widget.widthFirstColumn,
                                          child: AnimatedDefaultTextStyle(
                                            style: TextStyle(
                                                color: widget.list.indexOf(e) ==
                                                        indexColor
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize:
                                                    widget.list.indexOf(e) ==
                                                            indexColor
                                                        ? 17
                                                        : 16,
                                                fontWeight:
                                                    widget.list.indexOf(e) ==
                                                            indexColor
                                                        ? FontWeight.w400
                                                        : FontWeight.normal),
                                            duration: const Duration(
                                                milliseconds: 200),
                                            child: Text(
                                              e[widget.listData[0]].toString(),
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                      Container(
                                        width: 1,
                                        height: double.maxFinite,
                                        color: Colors.white,
                                      ),
                                      ...List.generate(
                                        widget.columnNumber - 1,
                                        (index) => Row(
                                          children: [
                                            SizedBox(
                                              width: widget.widthOtherColumn,
                                              child: AnimatedDefaultTextStyle(
                                                style: TextStyle(
                                                    color: widget.list
                                                                .indexOf(e) ==
                                                            indexColor
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: widget.list
                                                                .indexOf(e) ==
                                                            indexColor
                                                        ? 17
                                                        : 16,
                                                    fontWeight: widget.list
                                                                .indexOf(e) ==
                                                            indexColor
                                                        ? FontWeight.w400
                                                        : FontWeight.normal),
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                child: Text(
                                                  e[widget.listData[index + 1]]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            if (index !=
                                                widget.columnNumber - 2)
                                              Container(
                                                width: 1,
                                                height: double.maxFinite,
                                                color: Colors.white,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    upDate(() {
                                      if (indexColor ==
                                          widget.list.indexOf(e)) {
                                        indexColor = -1;
                                        rowData = null;
                                      } else {
                                        indexColor = widget.list.indexOf(e);
                                        rowData = e /*[widget.listData[
                                            widget.listData.length - 1]]*/
                                            ;
                                      }
                                      //TODO: القيمة اللى هترجع
                                    });
                                    onTap(rowData);
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    // // الصفحات
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 5, horizontal: 10),
                    //   child: Container(
                    //     height: 35,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         border: Border.all(
                    //             color: AppColors.blueLight, width: 1.5)),
                    //     margin: EdgeInsets.symmetric(vertical: 5),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //       children: <Widget>[
                    //         InkWell(
                    //           child: Container(
                    //             width: 60,
                    //             alignment: Alignment.center,
                    //             child: Icon(
                    //               Icons.arrow_left,
                    //               color: colorStart,
                    //               size: 30,
                    //             ),
                    //           ),
                    //           onTap: () {
                    //             if (subList.first != widget.list.first) {
                    //               setState(() {
                    //                 start = start - widget.numberItemInList;
                    //                 end = end - widget.numberItemInList;
                    //                 numberPage--;
                    //                 if (start > widget.list.length) {
                    //                   subList = widget.list.sublist(start);
                    //                   colorEnd = AppColors.blueLight;
                    //                   colorStart = Colors.white;
                    //                 } else {
                    //                   subList = widget.list.sublist(start, end);
                    //                   _controller.jumpTo(0);
                    //                   if (start == 0) {
                    //                     colorStart = Colors.teal.shade50;
                    //                   } else {
                    //                     colorEnd = AppColors.blueLight;
                    //                     colorStart = AppColors.blueLight;
                    //                   }
                    //                 }
                    //               });
                    //             }
                    //           },
                    //         ),
                    //         Expanded(
                    //             child: Text(
                    //           "Pages $numberPage From ${(widget.list.length ~/ widget.numberItemInList) + 1} ",
                    //           textAlign: TextAlign.center,
                    //         )),
                    //         InkWell(
                    //           child: Container(
                    //             width: 60,
                    //             alignment: Alignment.center,
                    //             child: Icon(
                    //               Icons.arrow_right,
                    //               color: end >= widget.list.length
                    //                   ? Colors.white
                    //                   : Colors.black,
                    //               size: 30,
                    //             ),
                    //           ),
                    //           onTap: () {
                    //             if (subList.last != widget.list.last) {
                    //               setState(() {
                    //                 start = start + widget.numberItemInList;
                    //                 end = end + widget.numberItemInList;
                    //                 numberPage++;
                    //                 if (end >= widget.list.length) {
                    //                   subList = widget.list.sublist(start);
                    //                   colorEnd = Colors.teal.shade50;
                    //                   colorStart = Colors.green.shade600;
                    //                 } else {
                    //                   subList = widget.list.sublist(start, end);
                    //                   _controller.jumpTo(0);
                    //                   colorEnd = Colors.green.shade600;
                    //                   colorStart = Colors.green.shade600;
                    //                 }
                    //               });
                    //             }
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  onTap(Map? st) {
    widget.onTap!(st);
  }
}
