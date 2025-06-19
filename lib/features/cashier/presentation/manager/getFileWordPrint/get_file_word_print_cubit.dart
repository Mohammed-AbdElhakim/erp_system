import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../data/repositories/cashier_repo.dart';

part 'get_file_word_print_state.dart';

class GetFileWordPrintCubit extends Cubit<GetFileWordPrintState> {
  GetFileWordPrintCubit(this.cashierRepo) : super(GetFileWordPrintInitial());
  final CashierRepo cashierRepo;

  Future<void> getFileWordPrint({
    required Pages pageData,
    required int id,
  }) async {
    emit(GetFileWordPrintLoading());
    Either<Failure, Uint8List> result = await cashierRepo.getFileWordPrint(
      pageId: pageData.pageId.toString(),
      id: id,
    );
    result.fold((failure) {
      emit(GetFileWordPrintFailure(failure.errorMassage));
    }, (data) {
      emit(GetFileWordPrintSuccess(data));
    });
  }
}
