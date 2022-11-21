// Mocks generated by Mockito 5.3.2 from annotations
// in ceiba_technical_test/test/helpers/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:ceiba_technical_test/core/database/database_helper.dart' as _i3;
import 'package:ceiba_technical_test/core/failures/failure.dart' as _i7;
import 'package:ceiba_technical_test/features/data/datasource/user_local_data_source.dart'
    as _i13;
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart'
    as _i10;
import 'package:ceiba_technical_test/features/data/models/posts_model.dart'
    as _i12;
import 'package:ceiba_technical_test/features/data/models/user_model.dart'
    as _i11;
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart'
    as _i9;
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart'
    as _i8;
import 'package:ceiba_technical_test/features/domain/repositories/user_repository.dart'
    as _i6;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i3.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<int> insert(
    String? table,
    Map<String, dynamic>? values,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #insert,
          [
            table,
            values,
          ],
        ),
        returnValue: _i4.Future<int>.value(0),
      ) as _i4.Future<int>);
  @override
  _i4.Future<List<Map<dynamic, dynamic>>?> select(
    String? table, {
    List<String>? cols,
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #select,
          [table],
          {
            #cols: cols,
            #where: where,
            #whereArgs: whereArgs,
            #orderBy: orderBy,
            #limit: limit,
          },
        ),
        returnValue: _i4.Future<List<Map<dynamic, dynamic>>?>.value(),
      ) as _i4.Future<List<Map<dynamic, dynamic>>?>);
  @override
  _i4.Future<void> update(
    String? table,
    Map<String, dynamic>? values,
    String? where,
    List<dynamic>? whereArgs,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #update,
          [
            table,
            values,
            where,
            whereArgs,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> execute(
    String? sql, {
    _i5.Database? db,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [sql],
          {#db: db},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<void> delete(
    String? table, {
    _i5.Database? db,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [table],
          {#db: db},
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [UserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepository extends _i1.Mock implements _i6.UserRepository {
  MockUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i7.Failure, List<_i8.UserEntity>>> getUserList() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserList,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i7.Failure, List<_i8.UserEntity>>>.value(
                _FakeEither_0<_i7.Failure, List<_i8.UserEntity>>(
          this,
          Invocation.method(
            #getUserList,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i7.Failure, List<_i8.UserEntity>>>);
  @override
  _i4.Future<_i2.Either<_i7.Failure, List<_i9.PostEntity>>> getPostsList(
          int? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPostsList,
          [userId],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i7.Failure, List<_i9.PostEntity>>>.value(
                _FakeEither_0<_i7.Failure, List<_i9.PostEntity>>(
          this,
          Invocation.method(
            #getPostsList,
            [userId],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i7.Failure, List<_i9.PostEntity>>>);
}

/// A class which mocks [UserRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRemoteDataSource extends _i1.Mock
    implements _i10.UserRemoteDataSource {
  MockUserRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i11.UserModel>> getUserList() => (super.noSuchMethod(
        Invocation.method(
          #getUserList,
          [],
        ),
        returnValue: _i4.Future<List<_i11.UserModel>>.value(<_i11.UserModel>[]),
      ) as _i4.Future<List<_i11.UserModel>>);
  @override
  _i4.Future<List<_i12.PostModel>> getPostsList(int? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPostsList,
          [userId],
        ),
        returnValue: _i4.Future<List<_i12.PostModel>>.value(<_i12.PostModel>[]),
      ) as _i4.Future<List<_i12.PostModel>>);
}

/// A class which mocks [UserLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserLocalDataSource extends _i1.Mock
    implements _i13.UserLocalDataSource {
  MockUserLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i11.UserModel>> getUserList() => (super.noSuchMethod(
        Invocation.method(
          #getUserList,
          [],
        ),
        returnValue: _i4.Future<List<_i11.UserModel>>.value(<_i11.UserModel>[]),
      ) as _i4.Future<List<_i11.UserModel>>);
  @override
  _i4.Future<bool> saveUserList(List<_i11.UserModel>? list) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUserList,
          [list],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  _i4.Future<bool> cleanUserList() => (super.noSuchMethod(
        Invocation.method(
          #cleanUserList,
          [],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}