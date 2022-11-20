import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';

class GetUserListUseCase implements UseCase<List<UserEntity>?, NoParams> {
  final UserRepository repository;
  GetUserListUseCase(this.repository);
  @override
  Future<Either<Failure, List<UserEntity>?>> call(NoParams params) {
    return repository.getUserList();
  }
}
