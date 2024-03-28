import 'package:dartz/dartz.dart';
import 'package:erp_system/features/auth/data/models/login_model.dart';

import '../../../../../core/errors/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> loginUser(
      {required String username, required String password});
}
