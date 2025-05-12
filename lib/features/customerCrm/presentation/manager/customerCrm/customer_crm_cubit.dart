import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/calls_view_model2.dart';
import '../../../data/models/contract_view_model1.dart';
import '../../../data/models/customer_account_view_model0.dart';
import '../../../data/repositories/customer_crm_repo.dart';

part 'customer_crm_state.dart';

class CustomerCrmCubit extends Cubit<CustomerCrmState> {
  CustomerCrmCubit(this.customerAccountRepo) : super(CustomerCrmInitial());
  final CustomerCrmRepo customerAccountRepo;

  Future<void> getTableCustomerCrm({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(CustomerCrmLoading());
    Either<Failure, Map<String, dynamic>> result =
        await customerAccountRepo.getTableCustomerCrm(objectData: objectData, link: link);
    result.fold((failure) {
      emit(CustomerCrmFailure(failure.errorMassage));
    }, (accountProfModel) {
      if (selectTab == 0) {
        CustomerAccountViewModel0 customerAccountViewModel0 = CustomerAccountViewModel0.fromJson(accountProfModel);
        emit(CustomerCrmSuccess(
            accountProfModel: customerAccountViewModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1) {
        ContractViewModel1 contractViewModel1 = ContractViewModel1.fromJson(accountProfModel);
        emit(CustomerCrmSuccess(
            accountProfModel: contractViewModel1,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 2) {
        CallsViewModel2 callsViewModel2 = CallsViewModel2.fromJson(accountProfModel);
        emit(CustomerCrmSuccess(
            accountProfModel: callsViewModel2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
