import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

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
      tUserModelRawData.map((e) => UserModel.fromJson(e)).toList();

  test(
    'initial state should be empty',
    () {
      expect(homeBloc.state, const HomeInitial());
    },
  );

  blocTest<HomeBloc, HomeState>(
    'should emit [loading, has data] when data is gotten successfully',
    build: () {
      when(mockGetUserListUseCase.call(NoParams()))
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
      verify(mockGetUserListUseCase.call(NoParams()));
    },
  );

  blocTest<HomeBloc, HomeState>(
    'should emit [loading, error] when get data is unsuccessful',
    build: () {
      when(mockGetUserListUseCase.call(NoParams())).thenAnswer((_) async =>
          Left(DioFailure.decode(
              DioError(requestOptions: RequestOptions(path: '')))));
      return homeBloc;
    },
    act: (bloc) => bloc.add(const GetUserDataEvent()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      const HomeInitial(),
      const HomeLoadingState(),
      HomeFailureState(DioFailure.decode(
          DioError(requestOptions: RequestOptions(path: '')))),
      const HomeInitial(),
      const HomeLoadingState(),
    ],
    verify: (bloc) {
      verify(mockGetUserListUseCase.call(NoParams()));
    },
  );
}
