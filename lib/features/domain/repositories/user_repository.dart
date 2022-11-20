

import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUserList();
}