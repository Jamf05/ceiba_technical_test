import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';

class GetPostsListUseCase implements UseCase<List<PostEntity>?, int> {
  final UserRepository authRepository;
  GetPostsListUseCase(this.authRepository);
  @override
  Future<Either<Failure, List<PostEntity>?>> call(int userId) {
    return authRepository.getPostsList(userId);
  }
}
