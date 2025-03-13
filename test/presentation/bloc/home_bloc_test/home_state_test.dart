import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

final class MockHomeEvent extends HomeEvent {}

void main() {
  setUp(() async {});

  test('should return a successful response', () async {
    // arrange
    // act
    final object = MockHomeEvent();
    // assert
    expect(object, isA<HomeEvent>());
    expect(object.props, []);
  });
}
