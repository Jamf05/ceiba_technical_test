import 'dart:convert';
import 'package:ceiba_technical_test/core/api/api_provider.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/core/failures/error.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/data/mappers/posts_mapper.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:ceiba_technical_test/gen/assets.gen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late Dio dioClient;
  late MockDio mockDioClient;
  late DioAdapter mockDioAdapter;
  late UserRemoteDataSourceImpl dataSource;
  late UserRemoteDataSourceImpl alterDataSource;

  setUp(() async {
    await Env.load(fileName: Assets.env.env);
    dioClient = ApiProvider().dio;
    mockDioAdapter =
        DioAdapter(dio: dioClient, matcher: const UrlRequestMatcher());
    mockDioClient = MockDio();
    dataSource = UserRemoteDataSourceImpl(client: dioClient);
    alterDataSource = UserRemoteDataSourceImpl(client: mockDioClient);
  });

  group('get user list', () {
    final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    final List<UserEntity> tUserModelList =
        tUserModelRawData.map((e) => UserMapper().fromJson(e)).toList();

    test(
      'should return the list of users when the response code is 200',
      () async {
        mockDioAdapter.onGet(
          "/users",
          (server) => server.reply(
            200,
            tUserModelRawData,
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        final result = await dataSource.getUserList();

        // assert
        expect(result, equals(tUserModelList));
      },
    );

    test(
      'should throw an exception when the response code is 500',
      () async {
        mockDioAdapter.onGet(
          "/users",
          (server) => server.reply(
            500,
            {
              "message": "Internal Server Error",
            },
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        Object? object;
        try {
          await dataSource.getUserList.call();
        } catch (e) {
          object = e;
        }

        // assert
        expect(object, isA<DioFailure>());
      },
    );

    test(
      'should throw an exception when the data response is not a list',
      () async {
        mockDioAdapter.onGet(
          "/users",
          (server) => server.reply(
            200,
            {
              "message": "Internal Server Error",
            },
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        Object? object;
        try {
          await dataSource.getUserList.call();
        } catch (e) {
          object = e;
        }

        // assert
        expect(object, isA<ErrorFailure>());
      },
    );

    test('should throw an exception', () async {
      when(() => mockDioClient.get("/users")).thenThrow(Exception());

      // act
      Object? object;
      try {
        await alterDataSource.getUserList.call();
      } catch (e) {
        object = e;
      }

      // assert
      expect(object, isA<ExceptionFailure>());
    });
  });

  group('get posts list', () {
    const tUserId = 1;
    final List tPostsModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.postsListResponse),
    );
    final List<PostEntity> tPostsModelList = tPostsModelRawData
        .map((e) => PostMapper().fromJson(Map<String, dynamic>.from(e)))
        .toList();

    test(
      'should return the list of posts when the response code is 200',
      () async {
        mockDioAdapter.onGet(
            "/posts",
            (server) => server.reply(
                  200,
                  tPostsModelRawData,
                  delay: const Duration(seconds: 1),
                ),
            queryParameters: {"userId": tUserId});

        // act
        final result = await dataSource.getPostsList(tUserId);

        // assert
        expect(result, equals(tPostsModelList));
      },
    );

    test(
      'should throw an exception when the response code is 500',
      () async {
        const tUserId = 1;
        mockDioAdapter.onGet(
          "/posts",
          queryParameters: {"userId": tUserId},
          (server) => server.reply(
            500,
            {
              "message": "Internal Server Error",
            },
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        Object? object;
        try {
          await dataSource.getPostsList.call(tUserId);
        } catch (e) {
          object = e;
        }

        // assert
        expect(object, isA<DioFailure>());
      },
    );

    test(
      'should throw an exception when the data response is not a list',
      () async {
        const tUserId = 1;
        mockDioAdapter.onGet(
          "/posts",
          queryParameters: {"userId": tUserId},
          (server) => server.reply(
            200,
            {
              "message": "Internal Server Error",
            },
            delay: const Duration(seconds: 1),
          ),
        );

        // act
        Object? object;
        try {
          await dataSource.getPostsList.call(tUserId);
        } catch (e) {
          object = e;
        }

        // assert
        expect(object, isA<ErrorFailure>());
      },
    );

    test('should throw an exception', () async {
      const tUserId = 1;
      when(() => mockDioClient.get(
            "/posts",
            queryParameters: {"userId": tUserId},
          )).thenThrow(Exception());

      // act
      Object? object;
      try {
        await alterDataSource.getPostsList.call(tUserId);
      } catch (e) {
        object = e;
      }

      // assert
      expect(object, isA<ExceptionFailure>());
    });
  });
}
