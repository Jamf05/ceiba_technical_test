part of 'posts_list_bloc.dart';

abstract class PostsListState extends Equatable {
  const PostsListState();
  
  @override
  List<Object> get props => [];
}

class PostsListInitial extends PostsListState {
  const PostsListInitial();
}

class PostsListLoadingState extends PostsListState {
  const PostsListLoadingState();
}

class PostsListFailureState extends PostsListState {
  final Failure failure;
  const PostsListFailureState(this.failure);
  
  @override
  List<Object> get props => [failure];
}
