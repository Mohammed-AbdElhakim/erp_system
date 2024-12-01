

import 'package:flutter/material.dart';

import '../../data/models/news_sections_model.dart';
import '../../data/models/numbers_sections_model.dart';
import '../../data/models/percentage_sections_model.dart';
import 'custom_news_sections.dart';
import 'custom_numbers_sections.dart';
import 'custom_percentage_sections.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody(
      {super.key, required this.listData});

  final List<Map<String,dynamic>> listData;

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
/*  final ScrollController _chartController2 = ScrollController();
  final ScrollController _tableController = ScrollController();

  @override
  void initState() {
    super.initState();
    _autoScroll(_chartController2);
    _autoScroll(_tableController);
  }

  void _autoScroll(ScrollController controller) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (controller.hasClients) {
        final maxScroll = controller.position.maxScrollExtent;
        final currentScroll = controller.offset;
        if (currentScroll < maxScroll) {
          controller.animateTo(
            currentScroll + 100,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          controller.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _chartController2.dispose();
    _tableController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          ...List.generate(
            widget.listData.length,
            (index) {
              Map<String,dynamic> listItem=widget.listData[index];
              if(listItem['Type']=="Percentages"){
                return CustomPercentageSections(
                  percentageSectionsModel: PercentageSectionsModel.fromJson(listItem),
                );
              }else if(listItem['Type']=="Numbers"){

                return CustomNumbersSections(
                  numbersSectionsModel: NumbersSectionsModel.fromJson(listItem),
                );
              }else if(listItem['Type']=="News"){
                return CustomNewsSections(
                  newsSectionsModel: NewsSectionsModel.fromJson(listItem),
                );
              }else{
                return const SizedBox();
              }


            },
          ),

         /* const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("إحصائيات"),

              _buildScrollingBar(
                  _chartController2,
                  [
                    _buildBarChart(),
                    _buildBarChart(),
                  ],
                  200),
              _buildSectionTitle("جداول"),
              _buildScrollingBar(
                  _tableController,
                  List.generate(
                    3,
                    (index) => _buildTableCard("جدول ${index + 1}", [
                      {"Name": "Flutter", "Score": 85},
                      {"Name": "Dart", "Score": 92},
                      {"Name": "Java", "Score": 78}
                    ]),
                  ),
                  150),


            ],
          ),*/
        ],
      ),
    );
  }



 /*
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildScrollingBar(
      ScrollController controller, List<Widget> items, double height) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: items[index],
          );
        },
      ),
    );
  }

 Widget _buildBarChart() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(1, 1),
                blurRadius: 1,
                spreadRadius: 1),
          ]),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: const TextStyle(color: Colors.blue, fontSize: 10),
                  );
                },
                reservedSize: 28,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  List<String> months = [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun'
                  ];
                  return getMonthLabel(value.toInt(), months);
                  // switch (value.toInt()) {
                  //   case 0:
                  //     return const Text('Jan',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   case 1:
                  //     return const Text('Feb',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   case 2:
                  //     return const Text('Mar',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   case 3:
                  //     return const Text('Apr',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   case 4:
                  //     return const Text('May',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   case 5:
                  //     return const Text('Jun',
                  //         style: TextStyle(color: Colors.blue, fontSize: 10));
                  //   default:
                  //     return const SizedBox.shrink();
                  // }
                },
                reservedSize: 28,
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(
            6,
            (index) => BarChartGroupData(x: index, barRods: [
              BarChartRodData(toY: 50, color: Colors.green, width: 16),
            ]),
          ),
        ),
      ),
    );
  }

   Widget getMonthLabel(int value, List<String> months) {
    if (value >= 0 && value < months.length) {
      return Text(
        months[value],
        style: const TextStyle(color: Colors.blue, fontSize: 10),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildTableCard(String title, List<Map<String, dynamic>> data) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueGrey,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 200,
            height: 45,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Colors.blueGrey,
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...data.map(
            (row) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    row["Name"],
                    style: const TextStyle(color: Colors.black),
                  ),
                  Text(
                    row["Score"].toString(),
                    style: TextStyle(color: AppColors.blueLight),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }*/



}
