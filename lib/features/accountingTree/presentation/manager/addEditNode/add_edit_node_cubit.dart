import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/account_view_model.dart';
import '../../../data/repositories/account_tree_repo.dart';

part 'add_edit_node_state.dart';

class AddEditNodeCubit extends Cubit<AddEditNodeState> {
  AddEditNodeCubit(this.accountTreeRepo) : super(AddEditNodeInitial());
  final AccountTreeRepo accountTreeRepo;

  Future<void> delete({required int id}) async {
    Either<Failure, String> result = await accountTreeRepo.delete(id: id);
    result.fold((failure) {
      emit(NodeFailure(failure.errorMassage));
    }, (data) {
      emit(const DeleteNodeSuccess());
    });
  }

  Future<void> add({required Map<String, dynamic> newData}) async {
    emit(AddEditNodeLoading());
    Either<Failure, AccountTreeModel> result = await accountTreeRepo.add(data: newData);
    result.fold((failure) {
      emit(NodeFailure(failure.errorMassage));
    }, (data) {
      emit(AddNodeSuccess(data));
    });
  }

  Future<void> edit({required Map<String, dynamic> newData}) async {
    emit(AddEditNodeLoading());
    Either<Failure, AccountTreeModel> result = await accountTreeRepo.edit(data: newData);
    result.fold((failure) {
      emit(NodeFailure(failure.errorMassage));
    }, (data) {
      emit(EditNodeSuccess(data));
    });
  }
}
