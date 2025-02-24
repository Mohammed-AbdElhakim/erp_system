import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/customer_account_model0.dart';
import '../../../data/models/customer_account_model1_and_2.dart';
import '../../../data/models/customer_account_model3.dart';
import '../../../data/models/customer_account_model4.dart';
import '../../../data/repositories/customer_account_repo.dart';

part 'customer_account_state.dart';

class CustomerAccountCubit extends Cubit<CustomerAccountState> {
  CustomerAccountCubit(this.customerAccountRepo)
      : super(CustomerAccountInitial());
  final CustomerAccountRepo customerAccountRepo;

  Future<void> getTableCustomerAccount({
    required Map<String, dynamic> objectData,
    required String link,
    required int numberOfPage,
    required int dropdownValueOfLimit,
    required int selectTab,
  }) async {
    emit(CustomerAccountLoading());
    Either<Failure, Map<String, dynamic>> result = await customerAccountRepo
        .getTableCustomerAccount(objectData: objectData, link: link);
    result.fold((failure) {
      emit(CustomerAccountFailure(failure.errorMassage));
    }, (accountProfModel) {
      if (selectTab == 0) {
        CustomerAccountModel0 customerAccountModel0 =
            CustomerAccountModel0.fromJson(accountProfModel);
        emit(CustomerAccountSuccess(
            accountProfModel: customerAccountModel0,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 1 || selectTab == 2) {
        CustomerAccountModel1and2 customerAccountModel1and2 =
            CustomerAccountModel1and2.fromJson(accountProfModel);
        emit(CustomerAccountSuccess(
            accountProfModel: customerAccountModel1and2,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 3) {
        CustomerAccountModel3 customerAccountModel3 =
            CustomerAccountModel3.fromJson(accountProfModel);
        emit(CustomerAccountSuccess(
            accountProfModel: customerAccountModel3,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      } else if (selectTab == 4) {
        CustomerAccountModel4 customerAccountModel4 =
            CustomerAccountModel4.fromJson(accountProfModel);
        emit(CustomerAccountSuccess(
            accountProfModel: customerAccountModel4,
            numberPage: numberOfPage,
            dropdownValue: dropdownValueOfLimit,
            selectTap: selectTab));
      }
    });
  }
}
