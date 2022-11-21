import 'dart:convert';

import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/gen/assets.gen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  // Init ffi loader if needed.
  late DatabaseHelper databaseHelper;
  late MockDatabaseHelper mockdatabaseHelper;
  late UserLocalDataSourceImpl userLocalDataSource;

  setUp(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
    await Env.load(fileName: Assets.env.env);
    DatabaseHelper.deleteDatabase();
    databaseHelper = await DatabaseHelper.init();
    mockdatabaseHelper = MockDatabaseHelper();
    userLocalDataSource =
        UserLocalDataSourceImpl(databaseHelper: mockdatabaseHelper);
  });

  final List tUserModelRawData = json.decode(
    JsonHelpers.readJson(DummyData.usersListQuery),
  );

  final List<Map<dynamic, dynamic>> tUserModelQueryList =
      tUserModelRawData.map((e) => Map<dynamic, dynamic>.from(e)).toList();

  final List<UserModel> tUserModelList = tUserModelRawData
      .map((e) => UserModel.fromQuery(Map<String, dynamic>.from(e)))
      .toList();

  group('get user list', () {
    test(
      'should return an empty list',
      () async {
        // arrange
        when(mockdatabaseHelper.select("user")).thenAnswer((_) async => []);
        // act
        final result = await userLocalDataSource.getUserList();
        // assert
        expect(result, equals([]));
      },
    );

    test(
      'should return a valid list of users',
      () async {
        // arrange
        when(mockdatabaseHelper.select("user"))
            .thenAnswer((_) async => tUserModelQueryList);
        // act
        final result = await userLocalDataSource.getUserList();
        // assert
        expect(result, equals(tUserModelList));
      },
    );
  });

  group('save user list', () {
    test(
      'should save a list of users in local data source',
      () async {
        userLocalDataSource =
          UserLocalDataSourceImpl(databaseHelper: databaseHelper);
        // act
        await userLocalDataSource.saveUserList(tUserModelList);
        final result = await userLocalDataSource.getUserList();
        // assert
        expect(result, equals(tUserModelList));
      },
    );
  });

  group('clean user list', () {
    test(
      'should clean the list of users in the local data source',
      () async {
        userLocalDataSource =
          UserLocalDataSourceImpl(databaseHelper: databaseHelper);
        // act
        await userLocalDataSource.saveUserList(tUserModelList);
        await userLocalDataSource.cleanUserList();
        final result = await userLocalDataSource.getUserList();
        // assert
        expect(result, equals([]));
      },
    );
  });
}
