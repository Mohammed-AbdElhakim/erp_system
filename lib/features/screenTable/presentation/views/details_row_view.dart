import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/change_status_bar_color.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class DetailsRowView extends StatelessWidget {
  const DetailsRowView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeStatusBarColor(
      child: Scaffold(
        appBar: const CustomAppBar(
          isPortrait: true,
          title: "",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                5,
                (index) => Card(
                  elevation: 2,
                  child: ExpansionTile(
                    collapsedShape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    title: Text(
                      "Tab $index",
                      style:
                          AppStyles.textStyle18.copyWith(color: Colors.black),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columnSpacing: 0,
                            horizontalMargin: 15,
                            dataRowMinHeight: 35,
                            dataRowMaxHeight: 35,
                            headingRowHeight: 35,
                            headingRowColor:
                                MaterialStateProperty.all(AppColors.blueLight),
                            columns: [
                              ...List.generate(
                                12,
                                (index) {
                                  return DataColumn(
                                    label: Expanded(
                                      child: SizedBox(
                                        width: 130,
                                        child: Text(
                                          "column $index",
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
                              5,
                              (index) => DataRow(
                                cells: [
                                  ...List.generate(
                                    12,
                                    (i) => DataCell(
                                      SizedBox(
                                        width: 130,
                                        child: InkWell(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text("text"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
