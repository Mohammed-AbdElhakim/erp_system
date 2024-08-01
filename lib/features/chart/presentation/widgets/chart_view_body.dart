import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_error_massage.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../../../core/widgets/custom_text_form_field_search.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/chart_data_model.dart';
import '../manager/chartPage/chart_page_cubit.dart';
import 'chart.dart';

class ChartViewBody extends StatefulWidget {
  const ChartViewBody({super.key});

  @override
  State<ChartViewBody> createState() => _ChartViewBodyState();
}

class _ChartViewBodyState extends State<ChartViewBody> {
  List<ChartDataModel> chartListSearch = [];
  TextEditingController controllerSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChartPageCubit, ChartPageState>(
      builder: (context, state) {
        List<ChartDataModel> myChartList = [];
        if (state is ChartPageSuccess) {
          for (var i in state.chartInPage) {
            if (i.chartMasterData.isVisible == true && i.dataList.isNotEmpty) {
              myChartList.add(i);
            }
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 15),
                  child: CustomTextFormFieldSearch(
                    hintText: S.of(context).search,
                    controller: controllerSearch,
                    onChanged: (value) {
                      chartListSearch = myChartList
                          .where((item) =>
                              item.chartMasterData.arName!.contains(value))
                          .toList();

                      setState(() {});
                    },
                  ),
                ),
                ...List.generate(
                  controllerSearch.text.isNotEmpty
                      ? chartListSearch.isEmpty
                          ? 0
                          : chartListSearch.length
                      : myChartList.length,
                  (index) {
                    return Chart(
                      chartDataModel: controllerSearch.text.isNotEmpty
                          ? chartListSearch[index]
                          : myChartList[index],
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is ChartPageFailure) {
          return CustomErrorMassage(errorMassage: state.errorMassage);
        } else {
          return const CustomLoadingWidget();
        }
      },
    );
  }
}
