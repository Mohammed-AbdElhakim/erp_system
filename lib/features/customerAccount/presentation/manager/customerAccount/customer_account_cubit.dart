import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/customer_account_model.dart';
import '../../../data/repositories/customer_account_repo.dart';

part 'customer_account_state.dart';

class CustomerAccountCubit extends Cubit<CustomerAccountState> {
  CustomerAccountCubit(this.customerAccountRepo)
      : super(CustomerAccountInitial());
  final CustomerAccountRepo customerAccountRepo;

  Future<void> getTableCustomerAccount({
    required Map<String, dynamic> objectData,
    required int numberOfPage,
    required int dropdownValueOfLimit,
  }) async {
    emit(CustomerAccountLoading());
    Either<Failure, CustomerAccountModel> result = await customerAccountRepo
        .getTableCustomerAccount(objectData: objectData);
    result.fold((failure) {
      emit(CustomerAccountFailure(failure.errorMassage));
    }, (accountProfModel) {
      emit(CustomerAccountSuccess(
          accountProfModel: accountProfModel,
          numberPage: numberOfPage,
          dropdownValue: dropdownValueOfLimit));
    });
  }
}
