import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:sqflite/sqlite_api.dart';

abstract class UserLocalDataSource {
  Future<List<UserEntity>> getUserList();
  Future<bool> saveUserList(List<UserEntity> list);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final DatabaseHelper databaseHelper;
  UserLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<UserEntity>> getUserList() async {
    try {
      List<UserEntity>? list = [];
      final res = await databaseHelper.select("user");
      if (res != null && res.isNotEmpty) {
        var listElement = List<Map<String, dynamic>>.generate(
            res.length, (index) => Map<String, dynamic>.from(res[index]),
            growable: true);
        for (var element in listElement) {
          final user = Map<String, dynamic>.from(element);
          list.add(UserMapper().fromQuery(user));
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
  Future<bool> saveUserList(List<UserEntity> list) async {
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
}
