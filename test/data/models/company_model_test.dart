import 'dart:convert';

import 'package:ceiba_technical_test/features/data/models/company_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tCompanyModelFromJson = CompanyModel(
        name: "Romaguera-Crona",
        catchPhrase: "Multi-layered client-server neural-net",
        bs: "harness real-time e-markets");

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.companyResponse),
        );

        // act
        final result = CompanyModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tCompanyModelFromJson));
      },
    );
  });
}
