part of 'posts_list_bloc.dart';

abstract class PostsListEvent extends Equatable {
  const PostsListEvent();

  @override
  List<Object> get props => [];
}

class GetPostsListEvent extends PostsListEvent {
  final int userId;
  const GetPostsListEvent(this.userId);
}

class PostsListLoadingEvent extends PostsListEvent {
  const PostsListLoadingEvent();
}
