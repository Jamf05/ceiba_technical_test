import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;
  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getUserList() async {
    try {
      final responseLocal = await userLocalDataSource.getUserList();
      if (responseLocal.isEmpty) {
        final responseRemote = await userRemoteDataSource.getUserList();
        await userLocalDataSource.saveUserList(responseRemote);
        return Right(responseRemote);
      }
      return Right(responseLocal);
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<PostsEntity>>> getPostsList(int userId) async {
    try {
      final response = await userRemoteDataSource.getPostsList(userId);
      return Right(response);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
