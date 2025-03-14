import 'dart:convert';

import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/company_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/dummy_data.dart';
import '../../../helpers/json_reader.dart';

void main() {
  const tUserModelFromJson = UserEntity(
    id: 1,
    name: "Leanne Graham",
    username: "Bret",
    email: "Sincere@april.biz",
    address: AddressEntity(
      street: "Kulas Light",
      suite: "Apt. 556",
      city: "Gwenborough",
      zipcode: "92998-3874",
      geo: LatLng(-37.3159, 81.1496),
    ),
    phone: "1-770-736-8031 x56442",
    website: "hildegard.org",
    company: CompanyEntity(
      name: "Romaguera-Crona",
      catchPhrase: "Multi-layered client-server neural-net",
      bs: "harness real-time e-markets",
    ),
  );

  const tUserModelFromQuery = UserEntity(
    id: 1,
    name: "Leanne Graham",
    username: "Bret",
    email: "Sincere@april.biz",
    phone: "1-770-736-8031 x56442",
  );

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.userResponse),
        );

        // act
        final result = UserMapper().fromJson(jsonMap);

        // assert
        expect(result, equals(tUserModelFromJson));
      },
    );
  });

  group('from query', () {
    test(
      'should return a valid model from db query',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.userQuery),
        );

        // act
        final result = UserMapper().fromQuery(jsonMap);

        // assert
        expect(result, equals(tUserModelFromQuery));
      },
    );
  });

  group('to json', () {
    test(
      'should return a valid json from model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.userResponse),
        );

        // act
        final result = UserMapper().toJson(tUserModelFromJson);

        // assert
        expect(result, equals(jsonMap));
      },
    );
  });
}
