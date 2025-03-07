import 'dart:convert';

import 'package:ceiba_technical_test/features/data/mappers/company_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/company_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tCompanyModelFromJson = CompanyEntity(
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
        final result = CompanyMapper().fromJson(jsonMap);

        // assert
        expect(result, equals(tCompanyModelFromJson));
      },
    );
  });

  group('to json', (){
    test(
      'should return a valid json from model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.companyResponse),
        );

        // act
        final result = CompanyMapper().toJson(tCompanyModelFromJson);

        // assert
        expect(result, equals(jsonMap));
      },
    );
  });
}
