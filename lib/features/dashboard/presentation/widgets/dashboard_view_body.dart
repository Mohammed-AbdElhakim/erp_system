import 'package:flutter/material.dart';

import '../../data/models/graph_sections_model.dart';
import '../../data/models/news_sections_model.dart';
import '../../data/models/numbers_sections_model.dart';
import '../../data/models/percentage_sections_model.dart';
import '../../data/models/tables_sections_model.dart';
import 'custom_graphs_sections.dart';
import 'custom_news_sections.dart';
import 'custom_numbers_sections.dart';
import 'custom_percentage_sections.dart';
import 'custom_tables_sections.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key, required this.listData});

  final List<Map<String, dynamic>> listData;

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(
            widget.listData.length,
            (index) {
              Map<String, dynamic> listItem = widget.listData[index];
              if (listItem['Type'] == "Percentages") {
                return CustomPercentageSections(
                  percentageSectionsModel:
                      PercentageSectionsModel.fromJson(listItem),
                );
              } else if (listItem['Type'] == "Numbers") {
                return CustomNumbersSections(
                  numbersSectionsModel: NumbersSectionsModel.fromJson(listItem),
                );
              } else if (listItem['Type'] == "News") {
                return CustomNewsSections(
                  newsSectionsModel: NewsSectionsModel.fromJson(listItem),
                );
              } else if (listItem['Type'] == "Graphs") {
                return CustomGraphsSections(
                  graphSectionsModel: GraphSectionsModel.fromJson(listItem),
                );
              } else if (listItem['Type'] == "Tables") {
                return CustomTablesSections(
                  tablesSectionsModel: TablesSectionsModel.fromJson(listItem),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
