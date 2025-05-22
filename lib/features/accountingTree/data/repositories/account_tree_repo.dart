import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/account_view_model.dart';

abstract class AccountTreeRepo {
  Future<Either<Failure, List<AccountTreeModel>>> getAllAccountTree();

  Future<Either<Failure, String>> delete({required int id});

  Future<Either<Failure, AccountTreeModel>> add({required Map<String, dynamic> data});

  Future<Either<Failure, AccountTreeModel>> edit({required Map<String, dynamic> data});
}
