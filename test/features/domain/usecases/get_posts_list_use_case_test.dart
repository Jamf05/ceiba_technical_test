import 'dart:convert';

import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/data/mappers/posts_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_posts_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetPostsListUseCase usecase;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetPostsListUseCase(mockRepository);
  });

  const tUserId = 1;
  final List tPostsModelRawData = json.decode(
    JsonHelpers.readJson(DummyData.postsListResponse),
  );
  final List<PostEntity> tPostsModelList = tPostsModelRawData
      .map((e) => PostMapper().fromJson(Map<String, dynamic>.from(e)))
      .toList();

  test(
    'should the current list of posts from the repository',
    () async {
      // arrange
      when(() => mockRepository.getPostsList(tUserId))
          .thenAnswer((_) async => Right(tPostsModelList));

      // act
      final result = await usecase.call(tUserId);

      // assert
      expect(result, equals(Right(tPostsModelList)));
    },
  );

  test(
    'should return Dio Failure when a call to repository is unsuccessful',
    () async {
      // arrange
      when(() => mockRepository.getPostsList(tUserId)).thenAnswer((_) async => Left(
          DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: '')))));

      // act
      final result = await usecase.call(tUserId);

      // assert
      expect(
          Left(DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: '')))),
          equals(result));
    },
  );
}
