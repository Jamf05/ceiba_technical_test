import 'package:bloc/bloc.dart';
import 'package:ceiba_technical_test/core/failures/failure.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/usecases/get_posts_list_use_case.dart';
import 'package:equatable/equatable.dart';

part '../posts_list_bloc/posts_list_event.dart';
part '../posts_list_bloc/posts_list_state.dart';

class PostsListBloc
    extends Bloc<PostsListEvent, PostsListState> {
  final GetPostsListUseCase _getPostsListUseCase;
  PostsListBloc(
      {required GetPostsListUseCase getPostsListUseCase})
      : _getPostsListUseCase = getPostsListUseCase,
        super(const PostsListInitial()) {
    on<PostsListLoadingEvent>(_mapPostsListLoadingEventToState);
    on<GetPostsListEvent>(_mapGetPostsListEventToState);
  }

  bool isLoadingPage = true;
  bool sendingData = false;
  List<PostEntity> postsList = [];

  void _mapPostsListLoadingEventToState(
      PostsListLoadingEvent event, Emitter<PostsListState> emit) async {
    emit(const PostsListInitial());
    emit(const PostsListLoadingState());
  }

  void _mapGetPostsListEventToState(
      GetPostsListEvent event, Emitter<PostsListState> emit) async {
    isLoadingPage = true;
    add(const PostsListLoadingEvent());
    final response = await _getPostsListUseCase.call(event.userId);
    response.fold((l) => emit(PostsListFailureState(l)), (r) {
      postsList = r ?? [];
    });
    isLoadingPage = false;
    add(const PostsListLoadingEvent());
  }
}
