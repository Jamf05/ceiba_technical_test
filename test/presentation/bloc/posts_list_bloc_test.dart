import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:ceiba_technical_test/features/data/models/posts_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPostsListUseCase mockGetPostsListUseCase;
  late PostsListBloc postsListBloc;

  setUp(() {
    mockGetPostsListUseCase = MockGetPostsListUseCase();
    postsListBloc = PostsListBloc(getPostsListUseCase: mockGetPostsListUseCase);
  });

  test(
    'initial state should be empty',
    () {
      expect(postsListBloc.state, const PostsListInitial());
    },
  );

  const tUserId = 1;
  final List tPostsModelRawData = json.decode(
    JsonHelpers.readJson(DummyData.postsListResponse),
  );
  final List<PostModel> tPostsModelList = tPostsModelRawData
      .map((e) => PostModel.fromJson(Map<String, dynamic>.from(e)))
      .toList();

  blocTest<PostsListBloc, PostsListState>(
    'should emit [loading, has data] when data is gotten successfully',
    build: () {
      when(mockGetPostsListUseCase.call(tUserId))
          .thenAnswer((_) async => Right(tPostsModelList));
      return postsListBloc;
    },
    act: (bloc) => bloc.add(const GetPostsListEvent(tUserId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const PostsListInitial(),
      const PostsListLoadingState(),
      const PostsListInitial(),
      const PostsListLoadingState(),
    ],
    verify: (bloc) {
      verify(mockGetPostsListUseCase.call(tUserId));
    },
  );

  blocTest<PostsListBloc, PostsListState>(
    'should emit [loading, error] when get data is unsuccessful',
    build: () {
      when(mockGetPostsListUseCase.call(tUserId)).thenAnswer((_) async => Left(
          DioFailure.decode(
              DioError(requestOptions: RequestOptions(path: '')))));
      return postsListBloc;
    },
    act: (bloc) => bloc.add(const GetPostsListEvent(tUserId)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const PostsListInitial(),
      const PostsListLoadingState(),
      PostsListFailureState(DioFailure.decode(
          DioError(requestOptions: RequestOptions(path: '')))),
      const PostsListInitial(),
      const PostsListLoadingState(),
    ],
    verify: (bloc) {
      verify(mockGetPostsListUseCase.call(tUserId));
    },
  );
}
