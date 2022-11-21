import 'dart:convert';

import 'package:ceiba_technical_test/features/data/models/posts_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/dummy_data.dart';
import '../../helpers/json_reader.dart';

void main() {
  const tCompanyModelFromJson = PostModel(
    userId: 1,
    id: 1,
    title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
  );

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          JsonHelpers.readJson(DummyData.postResponse),
        );

        // act
        final result = PostModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tCompanyModelFromJson));
      },
    );
  });
}
