import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/core/types/usecase.dart';
import 'package:ceiba_technical_test/core/validators/text_input.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.dart';

void main() {
  late MockGetUserListUseCase mockGetUserListUseCase;
  late HomeBloc homeBloc;

  setUp(() {
    mockGetUserListUseCase = MockGetUserListUseCase();
    homeBloc = HomeBloc(getUserUseCase: mockGetUserListUseCase);
  });

  final List tUserModelRawData = json.decode(
    JsonHelpers.readJson(DummyData.usersListResponse),
  );
  final List<UserEntity> tUserModelList =
      tUserModelRawData.map((e) => UserMapper().fromJson(e)).toList();

  const tQuery = TextFormInput.dirty("a");

  test(
    'initial state should be empty',
    () {
      expect(homeBloc.state, const HomeInitial());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'should emit [Initial, LoadingState, Initial, LoadingState] when data is gotten successfully',
    build: () {
      when(() => mockGetUserListUseCase.call(NoParams()))
          .thenAnswer((_) async => Right(tUserModelList));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const GetUserDataEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const HomeInitial(),
      const HomeLoadingState(),
      const HomeInitial(),
      const HomeLoadingState(),
    ],
    verify: (bloc) {
      verify(() => mockGetUserListUseCase.call(NoParams()));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'should emit [Initial, LoadingState, FailureState, Initial, LoadingState] when get data is unsuccessful',
    build: () {
      when(() => mockGetUserListUseCase.call(NoParams())).thenAnswer(
          (_) async => Left(DioFailure.decode(
              DioException(requestOptions: RequestOptions(path: '')))));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const GetUserDataEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const HomeInitial(),
      const HomeLoadingState(),
      HomeFailureState(DioFailure.decode(
          DioException(requestOptions: RequestOptions(path: '')))),
      const HomeInitial(),
      const HomeLoadingState(),
    ],
    verify: (bloc) {
      verify(() => mockGetUserListUseCase.call(NoParams()));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'should emit states when query is set',
    build: () {
      when(() => mockGetUserListUseCase.call(NoParams()))
          .thenAnswer((_) async => Right(tUserModelList));
      return homeBloc;
    },
    act: (bloc) async {
      bloc.add(const GetUserDataEvent());
      await Future.delayed(const Duration(milliseconds: 500));
      bloc.query = tQuery;
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const HomeInitial(),
      const HomeLoadingState(),
      const HomeInitial(),
      const HomeLoadingState(),
      const HomeInitial(),
      const HomeLoadingState(),
    ],
    verify: (bloc) {
      final tFilteredList = tUserModelList
          .where((e) =>
              e.name?.toLowerCase().contains(tQuery.value.toLowerCase()) ==
              true)
          .toList();

      verify(() => mockGetUserListUseCase.call(NoParams()));
      expect(bloc.filteredList.length, tFilteredList.length);
    },
  );

  test('should can get the query', (){
    homeBloc.query = tQuery;
    expect(homeBloc.query, tQuery);
  });
}
