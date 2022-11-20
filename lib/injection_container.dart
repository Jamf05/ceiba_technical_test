import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_publications_list_use_case.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_list_use_case_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ceiba_technical_test/features/app/blocs/splash_bloc/splash_bloc.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/data/repositories/user_repository_impl.dart';
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * Blocs
   */

  sl.registerFactory(() => SplashBloc());
  sl.registerFactory(() => HomeBloc(getUserUseCase: sl()));
  sl.registerFactory(() => PostsListBloc(getPostsListUseCase: sl()));

  /**
   * Use Cases
   */

  sl.registerLazySingleton(() => GetUserListUseCase(sl()));
  sl.registerLazySingleton(() => GetPostsListUseCase(sl()));

  /** 
   * Repositories
   */

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDataSource: sl(), userLocalDataSource: sl()));

  /**
   * Data Sources
   */
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(databaseHelper: sl()));

  /**
   * Database 
   */
  final databaseHelper = await DatabaseHelper.init();
  sl.registerLazySingleton(() => databaseHelper);

  /**
   * Externals
   */
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
