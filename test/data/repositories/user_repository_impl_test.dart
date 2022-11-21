import 'dart:convert';

import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/models/posts_model.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/features/data/repositories/user_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockUserRemoteDataSource mockUserRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late UserRepositoryImpl repository;

  setUp(() {
    mockUserRemoteDataSource = MockUserRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    repository = UserRepositoryImpl(
        userLocalDataSource: mockUserLocalDataSource,
        userRemoteDataSource: mockUserRemoteDataSource);
  });

  group('get user list', () {
    final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    final List<UserModel> tUserModelList =
        tUserModelRawData.map((e) => UserModel.fromJson(e)).toList();
    test(
      'escenario donde local data source NO tiene datos almacenados',
      () async {
        // arrange
        when(mockUserLocalDataSource.getUserList())
            .thenAnswer((_) async => []);

        when(mockUserRemoteDataSource.getUserList())
            .thenAnswer((_) async => tUserModelList);

        when(mockUserLocalDataSource.saveUserList(tUserModelList))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.getUserList();

        // assert
        verify(mockUserLocalDataSource.getUserList());
        verify(mockUserRemoteDataSource.getUserList());
        verify(mockUserLocalDataSource.saveUserList(tUserModelList));
        expect(result, equals(Right(tUserModelList)));
      },
    );

    test(
      'escenario donde local data source SI tiene datos almacenados',
      () async {
        // arrange
        when(mockUserLocalDataSource.getUserList())
            .thenAnswer((_) async => tUserModelList);

        // act
        final result = await repository.getUserList();

        // assert
        verify(mockUserLocalDataSource.getUserList());
        expect(result, equals(Right(tUserModelList)));
      },
    );

    test(
      'should return dio failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockUserLocalDataSource.getUserList())
            .thenAnswer((_) async => []);

        when(mockUserRemoteDataSource.getUserList()).thenThrow(
            DioFailure.decode(
                DioError(requestOptions: RequestOptions(path: ''))));

        // act
        final result = await repository.getUserList();

        // assert
        verify(mockUserRemoteDataSource.getUserList());
        expect(
            result,
            equals(Left(DioFailure.decode(
                DioError(requestOptions: RequestOptions(path: ''))))));
      },
    );
  });

  group('get posts list', () {
    const tUserId = 1;
    final List tPostsModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.postsListResponse),
    );
    final List<PostModel> tPostsModelList = tPostsModelRawData
        .map((e) => PostModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    test(
      'should return current weather when a call to data source is successful',
      () async {
        // arrange
        when(mockUserRemoteDataSource.getPostsList(tUserId))
            .thenAnswer((_) async => tPostsModelList);

        // act
        final result = await repository.getPostsList(tUserId);

        // assert
        verify(mockUserRemoteDataSource.getPostsList(tUserId));
        expect(result, equals(Right(tPostsModelList)));
      },
    );

    test(
      'should return dio failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockUserRemoteDataSource.getPostsList(tUserId)).thenThrow(
            DioFailure.decode(
                DioError(requestOptions: RequestOptions(path: ''))));

        // act
        final result = await repository.getPostsList(tUserId);

        // assert
        verify(mockUserRemoteDataSource.getPostsList(tUserId));
        expect(
            result,
            equals(Left(DioFailure.decode(
                DioError(requestOptions: RequestOptions(path: ''))))));
      },
    );
  });
}
