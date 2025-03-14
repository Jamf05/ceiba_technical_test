import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

final class MockPostsListEvent extends PostsListEvent {}

void main() {
  test('should return a successful response', () async {
    // arrange
    final object = MockPostsListEvent();
    // act
    final result = object.props;
    // assert
    expect(result, []);
  });
}
