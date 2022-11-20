import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/features/app/custom/components/custom_app_bar.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/empty_item_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/refresh_indicator_widget.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/widgets/user_card_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/circular_progress_indicator_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/custom_text_field.dart';
import 'package:ceiba_technical_test/features/app/pages/posts_list_page/posts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:ceiba_technical_test/injection_container.dart';
import 'package:ceiba_technical_test/core/page/base_bloc_state.dart';
import 'package:ceiba_technical_test/features/app/blocs/global/global_session_bloc/global_session_bloc.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePage extends StatefulWidget {
  static const route = "/HomePage";
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseBlocState<HomePage, HomeBloc> {
  final gBloc = sl<GlobalSessionBloc>();
  @override
  void onInitState() {
    bloc.add(const GetUserDataEvent());
    super.onInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleText: l10n.homePageTitle,
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        floatingActionButton: Visibility(
          visible: Env.environment == "DEV",
          child: FloatingActionButton(
            child: const Icon(Icons.cleaning_services_outlined),
            onPressed: () {
              DatabaseHelper.deleteDatabase();
              DatabaseHelper.init();
            },
          ),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: bloc,
          buildWhen: (previous, current) => current is HomeLoadingState,
          listener: (context, state) {
            if (state is HomeFailureState) {
              show.eitherError(state.failure);
            }
          },
          builder: (context, state) {
            if (bloc.isLoadingPage) return const CircularProgressWidget();
            return RefreshIndicatorWidget(
              onRefresh: () async => bloc.add(const GetUserDataEvent()),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: l10n.homePageSearchUser,
                      onChanged: (String v) =>
                          bloc.query = bloc.query.copyWith(v),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    if (bloc.filteredList.isNotEmpty)
                      ...List.generate(
                          bloc.filteredList.length,
                          (i) => UserCardWidget(
                                user: bloc.filteredList[i],
                                onPressed: () {
                                  nav.to(PostsListPage(
                                    user: bloc.filteredList[i],
                                  ));
                                },
                              ))
                    else
                      EmptyItemWidget(
                        icon: MdiIcons.formatListBulletedSquare,
                        message: l10n.homePageSeeListIsEmpty
                      )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
