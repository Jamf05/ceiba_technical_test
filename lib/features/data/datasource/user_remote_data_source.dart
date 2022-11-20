import 'package:ceiba_technical_test/core/api/api_provider.dart';
import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/models/posts_model.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUserList();
  Future<List<PostsModel>> getPostsList(int userId);
}

class UserRemoteDataSourceImpl extends ApiProvider
    implements UserRemoteDataSource {
  @override
  Future<List<UserModel>> getUserList() async {
    try {
      final res = await dio.get("/users");
      return (res.data as List).map((e) => UserModel.fromJson(e)).toList();
    } on DioError catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<List<PostsModel>> getPostsList(int userId) async {
    try {
      final res = await dio.get("/posts", queryParameters: {"userId": userId});
      return (res.data as List).map((e) => PostsModel.fromJson(e)).toList();
    } on DioError catch (error) {
      throw DioFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
