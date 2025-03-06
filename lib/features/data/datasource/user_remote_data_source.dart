import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/mappers/posts_mapper.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<List<UserEntity>> getUserList();
  Future<List<PostEntity>> getPostsList(int userId);
}

class UserRemoteDataSourceImpl
    implements UserRemoteDataSource {
  final Dio client;
  UserRemoteDataSourceImpl({required this.client});
  @override
  Future<List<UserEntity>> getUserList() async {
    try {
      final res = await client.get("/users");
      return (res.data as List).map((e) => UserMapper().fromJson(e)).toList();
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<PostEntity>> getPostsList(int userId) async {
    try {
      final res = await client.get("/posts", queryParameters: {"userId": userId});
      return (res.data as List).map((e) => PostMapper().fromJson(e)).toList();
    } on DioException catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
