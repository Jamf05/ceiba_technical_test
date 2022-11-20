import 'package:ceiba_technical_test/core/page/base_bloc_state.dart';
import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:ceiba_technical_test/features/app/custom/components/custom_app_bar.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/circular_progress_indicator_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/refresh_indicator_widget.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/widgets/user_card_widget.dart';
import 'package:ceiba_technical_test/features/app/pages/posts_list_page/widgets/posts_card_widget.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsListPage extends StatefulWidget {
  final UserEntity user;
  static const route = "/PostsListPage";
  const PostsListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends BaseBlocState<PostsListPage, PostsListBloc> {
  @override
  void onInitState() {
    bloc.add(GetPostsListEvent(widget.user.id!));
    super.onInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: l10n.postsListTitle,
      ),
      body: BlocConsumer<PostsListBloc, PostsListState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is PostsListLoadingState,
        listener: (context, state) {
          if (state is PostsListFailureState) {
            show.eitherError(state.failure);
          }
        },
        builder: (context, state) {
          if (bloc.isLoadingPage) return const CircularProgressWidget();
          return RefreshIndicatorWidget(
            onRefresh: () async => bloc.add(GetPostsListEvent(widget.user.id!)),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  UserCardWidget(
                    showButton: false,
                    user: widget.user,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(bloc.postsList.length, (i) => PostsCardWidget(item: bloc.postsList[i],))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
