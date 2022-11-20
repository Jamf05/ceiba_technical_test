import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUserList() async {
    try {
      final response = await userRemoteDataSource.getUserList();
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
