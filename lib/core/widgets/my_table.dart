import 'package:erp_system/core/utils/app_colors.dart';
import 'package:erp_system/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:sweetalert/sweetalert./dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

typedef onSelect = void Function(String);

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
  // final onSelect onTap;
  MyTable({
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
    // this.onTap,
  });

  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  int? indexColor;
  late String id;
  ScrollController _1controller = ScrollController();
  ScrollController _2controller = ScrollController();
  late List subList;
  late int start;
  late int end;
  late int numberPage;
  ScrollController _controller = ScrollController();
  late Color colorEnd;
  late Color colorStart;
  late String myValue = "";
  void initState() {
    super.initState();
    _2controller.addListener(() {
      _1controller.jumpTo(_2controller.offset);
    });
    start = 0;
    end = widget.numberItemInList > widget.list.length
        ? widget.list.length
        : widget.numberItemInList;
    subList = widget.list.sublist(start, end);

    // colorEnd = widget.numberItemInList > widget.list.length
    //     ? Colors.white
    //     : Theme.of(context).primaryColor;
    colorStart = Colors.teal.shade50;
    numberPage = 1;
  }

  @override
  Widget build(BuildContext context) {
    colorEnd = widget.numberItemInList > widget.list.length
        ? Colors.teal.shade50
        : Colors.green.shade600;
    return Column(
      children: <Widget>[
        SingleChildScrollView(
          controller: _1controller,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                bottom: BorderSide(color: AppColors.white, width: 1),
                top: BorderSide(color: AppColors.white, width: 1),
              ),
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
                    style: AppStyles.textStyle14,
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
                      controller: _2controller,
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        controller: _controller,
                        child: Column(
                          children: <Widget>[
                            ...widget.list.map((e) {
                              return Container(
                                color: widget.list.indexOf(e).isEven
                                    ? widget.list.indexOf(e) == indexColor
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context)
                                            .primaryColor
                                            .withOpacity(.25)
                                    : widget.list.indexOf(e) == indexColor
                                        ? Colors.green.shade600
                                        : Colors.white,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: widget.list.indexOf(e) == indexColor
                                    ? widget.heightRow + 15
                                    : widget.heightRow,
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                          width: widget.widthFirstColumn,
                                          child: AnimatedDefaultTextStyle(
                                            child: Text(
                                              e[widget.listData[0]["data"]]
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                            ),
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
                                          )),
                                      Container(
                                        width: 1,
                                        height: double.maxFinite,
                                        color: Colors.grey,
                                      ),
                                      ...List.generate(
                                        widget.columnNumber - 1,
                                        (index) => Container(
                                            width: widget.widthOtherColumn,
                                            child:
                                                widget.listData[index + 1]
                                                            ["type"] ==
                                                        "answer"
                                                    ? AnimatedDefaultTextStyle(
                                                        child: Text(
                                                          e[widget.listData[index +
                                                                              1]
                                                                          [
                                                                          "data"]]
                                                                      .toString() ==
                                                                  "NO"
                                                              ? "لا"
                                                              : "نعم",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        style: TextStyle(
                                                            color: widget.list
                                                                        .indexOf(
                                                                            e) ==
                                                                    indexColor
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontSize: widget
                                                                        .list
                                                                        .indexOf(
                                                                            e) ==
                                                                    indexColor
                                                                ? 17
                                                                : 16,
                                                            fontWeight: widget
                                                                        .list
                                                                        .indexOf(
                                                                            e) ==
                                                                    indexColor
                                                                ? FontWeight
                                                                    .w400
                                                                : FontWeight
                                                                    .normal),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    200),
                                                      )
                                                    : widget.listData[index + 1]
                                                                ["type"] ==
                                                            "bool"
                                                        ? AnimatedDefaultTextStyle(
                                                            child: Text(
                                                              e[widget.listData[index + 1]
                                                                              [
                                                                              "data"]]
                                                                          .toString() ==
                                                                      "False"
                                                                  ? "لا"
                                                                  : "نعم",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            style: TextStyle(
                                                                color: widget.list.indexOf(
                                                                            e) ==
                                                                        indexColor
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                                fontSize: widget
                                                                            .list
                                                                            .indexOf(
                                                                                e) ==
                                                                        indexColor
                                                                    ? 17
                                                                    : 16,
                                                                fontWeight: widget
                                                                            .list
                                                                            .indexOf(
                                                                                e) ==
                                                                        indexColor
                                                                    ? FontWeight
                                                                        .w400
                                                                    : FontWeight
                                                                        .normal),
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        200),
                                                          )
                                                        : widget.listData[index + 1]
                                                                    ["type"] ==
                                                                "date"
                                                            ? AnimatedDefaultTextStyle(
                                                                child: Text(
                                                                  "${DateFormat("yyyy-MM-dd").format(DateTime.parse(e[widget.listData[index + 1]["data"]]))}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                style: TextStyle(
                                                                    color: widget.list.indexOf(e) ==
                                                                            indexColor
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        widget.list.indexOf(e) ==
                                                                                indexColor
                                                                            ? 17
                                                                            : 16,
                                                                    fontWeight: widget.list.indexOf(e) ==
                                                                            indexColor
                                                                        ? FontWeight
                                                                            .w400
                                                                        : FontWeight
                                                                            .normal),
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            200),
                                                              )
                                                            : widget.listData[index + 1][
                                                                        "type"] ==
                                                                    "elc"
                                                                ? AnimatedDefaultTextStyle(
                                                                    child: Text(
                                                                      e[widget.listData[index + 1]["data"]].toString() ==
                                                                              "true"
                                                                          ? "إلكترونى"
                                                                          : "عند الاستلام",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    style: TextStyle(
                                                                        color: widget.list.indexOf(e) ==
                                                                                indexColor
                                                                            ? Colors
                                                                                .white
                                                                            : Colors
                                                                                .black,
                                                                        fontSize: widget.list.indexOf(e) ==
                                                                                indexColor
                                                                            ? 17
                                                                            : 16,
                                                                        fontWeight: widget.list.indexOf(e) ==
                                                                                indexColor
                                                                            ? FontWeight.w400
                                                                            : FontWeight.normal),
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            200),
                                                                  )
                                                                : widget.listData[index + 1][
                                                                            "type"] ==
                                                                        "listItem"
                                                                    ? AnimatedDefaultTextStyle(
                                                                        child:
                                                                            Text(
                                                                          e[widget.listData[index + 1]["data"]]
                                                                              .length
                                                                              .toString(),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        style: TextStyle(
                                                                            color: widget.list.indexOf(e) == indexColor
                                                                                ? Colors.white
                                                                                : Colors.black,
                                                                            fontSize: widget.list.indexOf(e) == indexColor ? 17 : 16,
                                                                            fontWeight: widget.list.indexOf(e) == indexColor ? FontWeight.w400 : FontWeight.normal),
                                                                        duration:
                                                                            const Duration(milliseconds: 200),
                                                                      )
                                                                    : widget.listData[index + 1]["type"] ==
                                                                            "search"
                                                                        ? AnimatedDefaultTextStyle(
                                                                            child:
                                                                                Text(
                                                                              getDataSesrch(searchList: widget.searchList, string: e[widget.listData[index + 1]["data"]].toString()),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            style: TextStyle(
                                                                                color: widget.list.indexOf(e) == indexColor ? Colors.white : Colors.black,
                                                                                fontSize: widget.list.indexOf(e) == indexColor ? 17 : 16,
                                                                                fontWeight: widget.list.indexOf(e) == indexColor ? FontWeight.w400 : FontWeight.normal),
                                                                            duration:
                                                                                const Duration(milliseconds: 200),
                                                                          )
                                                                        : AnimatedDefaultTextStyle(
                                                                            child:
                                                                                Text(
                                                                              e[widget.listData[index + 1]["data"]].toString(),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                            style: TextStyle(
                                                                                color: widget.list.indexOf(e) == indexColor ? Colors.white : Colors.black,
                                                                                fontSize: widget.list.indexOf(e) == indexColor ? 17 : 16,
                                                                                fontWeight: widget.list.indexOf(e) == indexColor ? FontWeight.w400 : FontWeight.normal),
                                                                            duration:
                                                                                const Duration(milliseconds: 200),
                                                                          )),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    upDate(() {
                                      indexColor = widget.list.indexOf(e);

                                      id = e[widget.listData[
                                          widget.listData.length - 1]['data']];
                                      // print(id);
                                    });
                                    onTap(id);
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ),
                    // الصفحات
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 5, horizontal: 10),
                    //   child: Container(
                    //     height: 35,
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(15),
                    //         border: Border.all(
                    //             color: Colors.green.shade600, width: 1.5)),
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
                    //                   // colorEnd = Colors.green[700];
                    //                   // colorStart = Colors.white;
                    //                 } else {
                    //                   subList = widget.list.sublist(start, end);
                    //                   _controller.jumpTo(0);
                    //                   if (start == 0) {
                    //                     colorStart = Colors.teal.shade50;
                    //                   } else {
                    //                     colorEnd = Colors.green.shade600;
                    //                     colorStart = Colors.green.shade600;
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

  onTap(String st) {
    // widget.onTap(st);
  }

  String getDataSesrch({required List? searchList, required String string}) {
    for (int current = 0; current < searchList!.length; current++) {
      if (searchList[current]['${widget.searchWord}'].toString() == string) {
        myValue = searchList[current]['${widget.getSearchWord}'];
      }
    }
    return myValue;
  }
}
