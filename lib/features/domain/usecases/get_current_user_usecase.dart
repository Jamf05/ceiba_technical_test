import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:ceiba_technical_test/features/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository authRepository;
  GetCurrentUserUsecase(this.authRepository);
  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) {
    return authRepository.getCurrentUser();
  }
}
