import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getUserList();
  // Future<bool> checkIfUserListIsValid();
  Future<bool> saveUserList(List<UserModel> list);
  Future<bool> cleanUserList();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseHelper databaseHelper;
  UserLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UserModel>> getUserList() async {
    try {
      List<UserModel>? list = [];
      final res = await databaseHelper.select("user");
      if (res != null && res.isNotEmpty) {
        var listElement = List<Map<String, dynamic>>.generate(
            res.length, (index) => Map<String, dynamic>.from(res[index]),
            growable: true);
        for (var element in listElement) {
          final user = Map<String, dynamic>.from(element);
          list.add(UserModel.fromQuery(user));
        }
      }
      return list;
    } on DatabaseException catch (error) {
      throw SqfliteFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<bool> saveUserList(List<UserModel> list) async {
    try {
      await databaseHelper.execute('''BEGIN TRANSACTION;''');
      for (var item in list) {
        await databaseHelper.execute(
          '''INSERT OR REPLACE INTO user (id, name, username, email, phone) VALUES(${item.id}, '${item.name}', '${item.username}', '${item.email}', '${item.phone}')''',
        );
      }
      await databaseHelper.execute('''COMMIT;''');
      return true;
    } on DatabaseException catch (error) {
      throw SqfliteFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }

  @override
  Future<bool> cleanUserList() async {
    try {
      await databaseHelper.execute(
        '''DELETE FROM user''',
      );
      return true;
    } on DatabaseException catch (error) {
      throw SqfliteFailure.decode(error);
    } on Error catch (error) {
      throw ErrorFailure.decode(error);
    } on Exception catch (error) {
      throw ExceptionFailure.decode(error);
    }
  }
}
