import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_posts_list_use_case.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_list_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  GetPostsListUseCase,
  GetUserListUseCase,
  DatabaseHelper,
  UserRepository,
  UserRemoteDataSource,
  UserLocalDataSource,
])

void main() {}

