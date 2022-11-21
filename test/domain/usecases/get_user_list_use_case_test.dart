import 'dart:convert';

import 'package:ceiba_technical_test/core/usecase/usecase.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_user_list_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockUserRepository mockRepository;
  late GetUserListUseCase usecase;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = GetUserListUseCase(mockRepository);
  });

  final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    final List<UserModel> tUserModelList =
        tUserModelRawData.map((e) => UserModel.fromJson(e)).toList();

  test(
    'should get current weather detail from the repository',
    () async {
      // arrange
      when(mockRepository.getUserList())
          .thenAnswer((_) async => Right(tUserModelList));

      // act
      final result = await usecase.call(NoParams());

      // assert
      expect(result, equals(Right(tUserModelList)));
    },
  );
}