import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/chart_data_model.dart';
import '../../../data/models/chart_master_model.dart';
import '../../../data/models/chart_model.dart';
import '../../../data/models/chart_page_model.dart';
import '../../../data/repositories/chart_repo.dart';

part 'chart_page_state.dart';

class ChartPageCubit extends Cubit<ChartPageState> {
  ChartPageCubit(this.chartRepo) : super(ChartPageInitial());
  final ChartRepo chartRepo;

  Future<void> getChartPage({required int pageId}) async {
    emit(ChartPageLoading());
    Either<Failure, ChartPageModel> chartPages = await chartRepo.getChartPage();

    chartPages.fold((failure) {
      emit(ChartPageFailure(failure.errorMassage));
    }, (chartPage) {
      getChartMaster(pageId: pageId, chartPage: chartPage);
    });
  }

  void getChartMaster(
      {required int pageId, required ChartPageModel chartPage}) async {
    List<ChartPageData> chartPageList = chartPage.dynamicList!;
    List<int> chartIdList = [];
    for (var item in chartPageList) {
      if (item.pageId == pageId) {
        chartIdList.add(item.chartId!);
      }
    }
    Either<Failure, ChartMasterModel> chartMasters =
        await chartRepo.getChartMaster();

    chartMasters.fold(
      (failure) {
        emit(ChartPageFailure(failure.errorMassage));
      },
      (chartMaster) {
        getChartData(chartIdList: chartIdList, chartMaster: chartMaster);
      },
    );
  }

  void getChartData(
      {required ChartMasterModel chartMaster,
      required List<int> chartIdList}) async {
    List<ChartMasterData> chartMasterList = chartMaster.dynamicList!;
    List<ChartDataModel> chartInPage = [];
    for (var id in chartIdList) {
      for (var item in chartMasterList) {
        if (item.id == id) {
          Either<Failure, ChartModel> chartsData =
              await chartRepo.getChartData(tableOrView: item.tableOrView!);
          chartsData.fold(
            (failure) {
              emit(ChartPageFailure(failure.errorMassage));
            },
            (chartData) {
              List<Map<String, dynamic>> chartDataList =
                  chartData.dynamicList ?? [];
              List<XY> xyData = [];
              for (var xy in chartDataList) {
                xyData.add(
                  XY(
                    x: "${xy['${item.x}']}",
                    y: double.parse("${xy['${item.value}'] ?? 0.0}"),
                  ),
                );
              }
              ChartDataModel chartDataModel = ChartDataModel(
                chartMasterData: item,
                dataList: xyData,
              );
              chartInPage.add(chartDataModel);
            },
          );
        }
      }
    }
    emit(ChartPageSuccess(chartInPage));
  }
}
