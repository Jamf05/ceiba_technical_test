import 'dart:convert';

import 'package:ceiba_technical_test/features/data/models/address_model.dart';
import 'package:ceiba_technical_test/features/data/models/company_model.dart';
import 'package:ceiba_technical_test/features/data/models/user_model.dart';
import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tUserModelFromJson = UserModel(
    id: 1,
    name: "Leanne Graham",
    username: "Bret",
    email: "Sincere@april.biz",
    address: AddressModel(
        street: "Kulas Light",
        suite: "Apt. 556",
        city: "Gwenborough",
        zipcode: "92998-3874",
        geo: LatLng(-37.3159, 81.1496)),
    phone: "1-770-736-8031 x56442",
    website: "hildegard.org",
    company: CompanyModel(
        name: "Romaguera-Crona",
        catchPhrase: "Multi-layered client-server neural-net",
        bs: "harness real-time e-markets"),
  );

  const tUserModelFromQuery = UserModel(
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
        final result = UserModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tUserModelFromJson));
      },
    );
  });

  group('from query', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.userQuery),
        );

        // act
        final result = UserModel.fromQuery(jsonMap);

        // assert
        expect(result, equals(tUserModelFromQuery));
      },
    );
  });
}
