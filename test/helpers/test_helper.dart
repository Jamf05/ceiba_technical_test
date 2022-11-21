import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  DatabaseHelper,
  UserRepository,
  UserRemoteDataSource,
  UserLocalDataSource,
])

void main() {}

