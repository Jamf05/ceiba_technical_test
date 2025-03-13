import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

final class MockPostsListState extends PostsListState {}

void main() {
  test('should return a empty list', () async {
    // arrange
    final object = MockPostsListState();
    // act
    final result = object.props;
    // assert
    expect(result, []);
  });

  test('should return a list of failure', () async {
    // arrange
    final exception = Exception();
    final failure = ExceptionFailure.decode(exception);
    final object = PostsListFailureState(failure);
    // act
    final result = object.props;
    // assert
    expect(result, [failure]);
  });
}
