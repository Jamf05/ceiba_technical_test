import 'dart:convert';

import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:ceiba_technical_test/gen/assets.gen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.dart';


void main() {
  late MockDatabaseHelper databaseHelperMock;
  late UserLocalDataSourceImpl userLocalDataSource;

  setUp(() async {
    await Env.load(fileName: Assets.env.env);
    databaseHelperMock = MockDatabaseHelper();
    userLocalDataSource = UserLocalDataSourceImpl(
      databaseHelper: databaseHelperMock,
    );
  });

  final List tUserModelRawData = json.decode(
    JsonHelpers.readJson(DummyData.usersListQuery),
  );

  final List<Map<dynamic, dynamic>> tUserModelQueryList =
      tUserModelRawData.map((e) => Map<dynamic, dynamic>.from(e)).toList();

  final List<UserEntity> tUserModelList = tUserModelRawData
      .map((e) => UserMapper().fromQuery(Map<String, dynamic>.from(e)))
      .toList();

  group('get user list', () {
    test(
      'should return an empty list',
      () async {
        // arrange
        when(() => databaseHelperMock.select("user")).thenAnswer((_) async => []);
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
        when(() => databaseHelperMock.select("user"))
            .thenAnswer((_) async => tUserModelQueryList);
        // act
        final result = await userLocalDataSource.getUserList();
        // assert
        expect(result, equals(tUserModelList));
      },
    );

    test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.select("user"))
          .thenThrow(MockDatabaseException());
      // act
      Object? object;
      try {
        await userLocalDataSource.getUserList();
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<SqfliteFailure>());
    });

    test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.select("user")).thenThrow(TypeError());
      // act
      Object? object;
      try {
        await userLocalDataSource.getUserList();
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<ErrorFailure>());
    });

    test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.select("user")).thenThrow(FormatException());
      // act
      Object? object;
      try {
        await userLocalDataSource.getUserList();
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<ExceptionFailure>());
    });
  });

  group('save user list', () {
    test(
      'should save a list of users in local data source',
      () async {
        final calledCounter = tUserModelList.length + 2;
        userLocalDataSource = UserLocalDataSourceImpl(
          databaseHelper: databaseHelperMock,
        );
        when(() => databaseHelperMock.execute(any())).thenAnswer((_) async {});
        // act
        await userLocalDataSource.saveUserList(tUserModelList);
        // assert
        verify(() => databaseHelperMock.execute(any())).called(calledCounter);
      },
    );
  });

  group('clean user list', () {
    test(
      'should clean the list of users in the local data source',
      () async {
        final calledCounter = tUserModelList.length + 2;
        userLocalDataSource = UserLocalDataSourceImpl(
          databaseHelper: databaseHelperMock,
        );
        when(() => databaseHelperMock.execute(any())).thenAnswer((_) async {});
        // act
        await userLocalDataSource.saveUserList(tUserModelList);
        // assert
        verify(() => databaseHelperMock.execute(any())).called(calledCounter);
      },
    );

        test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.execute(any()))
          .thenThrow(MockDatabaseException());
      // act
      Object? object;
      try {
        await userLocalDataSource.saveUserList(tUserModelList);
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<SqfliteFailure>());
    });

    test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.execute(any())).thenThrow(TypeError());
      // act
      Object? object;
      try {
        await userLocalDataSource.saveUserList(tUserModelList);
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<ErrorFailure>());
    });

    test('should return a DatabaseException', () async {
      // arrange
      when(() => databaseHelperMock.execute(any())).thenThrow(FormatException());
      // act
      Object? object;
      try {
        await userLocalDataSource.saveUserList(tUserModelList);
      } catch (e) {
        object = e;
      }
      // assert
      expect(object, isA<ExceptionFailure>());
    });
  });
}
