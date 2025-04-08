import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/models/menu_model/pages.dart';
import '../../../data/repositories/screen_repo.dart';

part 'get_file_pdf_print_state.dart';

class GetFilePdfPrintCubit extends Cubit<GetFilePdfPrintState> {
  GetFilePdfPrintCubit(this.screenRepo) : super(GetFilePdfPrintInitial());
  final ScreenRepo screenRepo;
  Future<void> getFilePdfPrint({
    required Pages pageData,
    required int id,
  }) async {
    emit(GetFilePdfPrintLoading());
    Either<Failure, Uint8List > result = await screenRepo.getFilePdfPrint(
      pageId: pageData.pageId.toString(),
        id: id,
    );
    result.fold((failure) {
      emit(GetFilePdfPrintFailure(failure.errorMassage));
    }, (data) {
      emit(GetFilePdfPrintSuccess(data));
    });
  }

}
