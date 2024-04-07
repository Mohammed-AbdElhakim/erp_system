import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class CustomTable extends StatefulWidget {
  const CustomTable(
      {super.key,
      required this.listHeader,
      required this.listData,
      required this.listKey});
  final List<String> listHeader;
  final List<dynamic> listData;
  final List<dynamic> listKey;

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  late List subList;
  late int start;
  late int end;
  late Color colorEnd;
  late Color colorStart;
  late int numberPage;
  late int numberItemInList;
  ScrollController controller = ScrollController();
  List<int> listNumberItemInList = [10, 25, 50, 100];

  @override
  void initState() {
    initValues(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            controller: controller,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) {
                    return Colors.blue;
                  },
                ),
                border: TableBorder.all(color: Colors.grey.shade400),
                columns: List.generate(
                  widget.listHeader.length,
                  (index) => DataColumn(
                    label: Expanded(
                      child: InkWell(
                        onTap: () {
                          print("****************************");
                          print(widget.listHeader[index]);
                          print("*****************************");
                        },
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.listHeader[index],
                          style: AppStyles.textStyle18,
                        ),
                      ),
                    ),
                  ),
                ),
                rows: List.generate(
                  subList.length,
                  (index) => DataRow(
                      cells: List.generate(
                    widget.listHeader.length,
                    (i) => DataCell(Container(
                      width: subList[index]['${widget.listKey[i]}']
                                  .toString()
                                  .length >
                              30
                          ? 250
                          : null,
                      alignment: Alignment.center,
                      child: Text(
                          textAlign: TextAlign.center,
                          "${subList[index][widget.listKey[i]]}"),
                    )),
                  )),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                bottom: 5, top: 5, start: 10, end: 85),
            child: Column(
              children: [
                Container(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //     border: Border.all(color: AppColors.blueLight, width: 1)),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_left,
                            color: colorStart,
                            size: 30,
                          ),
                        ),
                        onTap: () {
                          if (subList.first != widget.listData.first) {
                            setState(() {
                              start = start - numberItemInList;
                              end = end - numberItemInList;
                              numberPage--;
                              if (start > widget.listData.length) {
                                subList = widget.listData.sublist(start);
                                colorStart = AppColors.blueLight;
                                colorEnd = AppColors.white;
                              } else {
                                subList = widget.listData.sublist(start, end);
                                controller.jumpTo(0);
                                if (start == 0) {
                                  colorStart = AppColors.white;
                                } else {
                                  colorEnd = AppColors.blueLight;
                                  colorStart = AppColors.blueLight;
                                }
                              }
                            });
                          }
                        },
                      ),
                      Expanded(
                          child: Text(
                        "Pages $numberPage From ${(widget.listData.length ~/ numberItemInList) + 1} ",
                        textAlign: TextAlign.center,
                      )),
                      InkWell(
                        child: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_right,
                            color: end >= widget.listData.length
                                ? AppColors.white
                                : AppColors.blueLight,
                            size: 30,
                          ),
                        ),
                        onTap: () {
                          if (subList.last != widget.listData.last) {
                            setState(() {
                              start = start + numberItemInList;
                              end = end + numberItemInList;
                              numberPage++;
                              if (end >= widget.listData.length) {
                                subList = widget.listData.sublist(start);
                                colorStart = AppColors.blueLight;
                                colorEnd = AppColors.white;
                              } else {
                                subList = widget.listData.sublist(start, end);
                                controller.jumpTo(0);
                                colorStart = AppColors.blueLight;
                                colorEnd = AppColors.blueLight;
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    listNumberItemInList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text("${listNumberItemInList[index]}"),
                        ),
                        onTap: () {
                          setState(() {
                            initValues(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void initValues(int index) {
    start = 0;
    numberItemInList = listNumberItemInList[index];
    end = numberItemInList > widget.listData.length
        ? widget.listData.length
        : numberItemInList;
    subList = widget.listData.sublist(start, end);
    colorEnd = numberItemInList > widget.listData.length
        ? AppColors.white
        : AppColors.blueLight;
    colorStart = AppColors.white;
    numberPage = 1;
  }
}
