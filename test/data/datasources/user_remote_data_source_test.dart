import 'dart:convert';
import 'package:ceiba_technical_test/core/api/api_provider.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/features/data/datasource/user_remote_data_source.dart';
import 'package:ceiba_technical_test/features/data/models/posts_model.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/gen/assets.gen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  late Dio dioClient;
  late DioAdapter mockDioClient;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() async {
    await Env.load(fileName: Assets.env.env);
    dioClient = ApiProvider().dio;
    mockDioClient =
        DioAdapter(dio: dioClient, matcher: const UrlRequestMatcher());
    dataSource = UserRemoteDataSourceImpl(client: dioClient);
  });

  group('get user list', () {
    final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    final List<UserModel> tUserModelList = tUserModelRawData.map((e) => UserModel.fromJson(e)).toList();

    test(
      'should return the list of users when the response code is 200',
      () async {
        mockDioClient.onGet(
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
  });

  group('get posts list', () {
    const tUserId = 1;
    final List tPostsModelRawData = json
        .decode(
          JsonHelpers.readJson(DummyData.postsListResponse),
        );
    final List<PostModel> tPostsModelList = tPostsModelRawData
        .map((e) => PostModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    test(
      'should return the list of posts when the response code is 200',
      () async {
        mockDioClient.onGet(
          "/posts",
          (server) => server.reply(
            200,
            tPostsModelRawData,
            delay: const Duration(seconds: 1),
          ),
          queryParameters: {"userId": tUserId}
        );

        // act
        final result = await dataSource.getPostsList(tUserId);

        // assert
        expect(result, equals(tPostsModelList));
      },
    );
  });
}
