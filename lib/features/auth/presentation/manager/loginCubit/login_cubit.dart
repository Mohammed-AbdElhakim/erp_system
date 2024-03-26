import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/repositories/login/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;
  Future<void> loginUser(
      {required String username, required String password}) async {
    emit(LoginLoading());
    Either<Failure, String> result =
        await loginRepo.loginUser(username: username, password: password);
    result.fold((failure) {
      emit(LoginFailure(failure.errorMassage));
    }, (detailsMeal) {
      emit(LoginSuccess(detailsMeal));
    });
  }
}
