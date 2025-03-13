import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_posts_list_use_case.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_list_use_case.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqlite_api.dart';

class MockDatabaseException extends Mock implements DatabaseException {}
class MockGetPostsListUseCase extends Mock implements GetPostsListUseCase {}
class MockGetUserListUseCase extends Mock implements GetUserListUseCase {}
class MockDatabaseHelper extends Mock implements DatabaseHelper {}
class MockUserRepository extends Mock implements UserRepository {}
class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}
class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}
