import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfileData();
}
