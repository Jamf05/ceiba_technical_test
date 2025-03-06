import 'dart:convert';

import 'package:ceiba_technical_test/features/data/mappers/address_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/address_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/lat_lng.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tAddressModelFromJson = AddressEntity(
    street: "Kulas Light",
    suite: "Apt. 556",
    city: "Gwenborough",
    zipcode: "92998-3874",
    geo: LatLng(-37.3159, 81.1496),
  );

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.addressResponse),
        );

        // act
        final result = AddressMapper().fromJson(jsonMap);

        // assert
        expect(result, equals(tAddressModelFromJson));
      },
    );
  });
}
