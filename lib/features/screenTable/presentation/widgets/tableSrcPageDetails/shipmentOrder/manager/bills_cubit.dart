import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/helper/SharedPreferences/pref.dart';
import '../../../../../../../core/utils/api_service.dart';
import '../../../../../../../core/utils/app_strings.dart';
import '../models/bills_data_model.dart';
import '../models/bills_header_model.dart';

part 'bills_state.dart';

class BillsCubit extends Cubit<BillsState> {
  BillsCubit() : super(BillsInitial());

  Future<void> getBillsTable() async {
    emit(BillsLoading());

    try {
      String companyKey = await Pref.getStringFromPref(key: AppStrings.companyIdentifierKey) ?? "";
      String token = await Pref.getStringFromPref(key: AppStrings.tokenKey) ?? "";
      List<dynamic> dataHeader = await ApiService(Dio()).get(
        endPoint: "web/Structure/getListSetups/ShipmentOrderDetialsViews",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<BillsHeaderModel> billsHeaderList = [];
      for (var i in dataHeader) {
        billsHeaderList.add(BillsHeaderModel.fromJson(i));
      }
      List<dynamic> data = await ApiService(Dio()).get(
        endPoint: "web/ContractStates",
        headers: {
          "Authorization": "Bearer $token",
          "CompanyKey": companyKey,
        },
      );

      List<BillsDataModel> billsDataList = [];
      for (var i in data) {
        billsDataList.add(BillsDataModel.fromJson(i));
      }
      emit(BillsSuccess(billsHeaderList: billsHeaderList, billsDataList: billsDataList));
    } catch (e) {
      if (e is DioException) {
        ServerFailure er = ServerFailure.fromDioException(e);
        emit(BillsFailure(er.errorMassage));
      }
      log('Error fetching data: $e');
    }
  }
}
