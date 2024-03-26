import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> loginUser(
      {required String username, required String password});
}
