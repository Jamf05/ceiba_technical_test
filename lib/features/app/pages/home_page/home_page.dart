import 'package:ceiba_technical_test/features/app/bindings/home_binding.dart';
import 'package:ceiba_technical_test/features/app/custom/components/custom_app_bar.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/widgets/user_card_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/circular_progress_indicator_widget.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/custom_text_field.dart';
import 'package:ceiba_technical_test/features/app/pages/publications_list_page/publications_list_page.dart';
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
  void dispose() {
    HomeBinding().dispose();
    super.dispose();
  }

  List<Widget> get actions => [
        IconButton(
            onPressed: () =>
                AppTheme.selected.value = AppTheme.reverseGreenTheme,
            icon: Icon(
                isDarkTheme
                    ? Icons.wb_sunny_outlined
                    : MdiIcons.weatherNightPartlyCloudy,
                color: AppColors.whiteFirst))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleText: "Prueba de Ingreso",
          leading: const SizedBox(),
          leadingWidth: 0,
          // actions: actions,
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
            return RefreshIndicator(
              onRefresh: () async => bloc.add(const GetUserDataEvent()),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      labelText: "Buscar usuario",
                      onChanged: (String v) =>
                          bloc.query = bloc.query.copyWith(v),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ...List.generate(
                        bloc.filteredList.length,
                        (i) => UserCardWidget(
                              user: bloc.filteredList[i],
                              onPressed: () => nav.to(const PublicationsListPage()),
                            ))
                  ],
                ),
              ),
            );
          },
        ));
  }
}
