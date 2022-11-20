import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> setCurrentUser(UserModel user);
  Future<UserModel?> getCurrentUser();
  Future<bool> clearCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  AuthLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      return null;
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<bool> setCurrentUser(UserModel user) async {
    try {
      return true;
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<bool> clearCurrentUser() async {
    try {
      return true;
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
