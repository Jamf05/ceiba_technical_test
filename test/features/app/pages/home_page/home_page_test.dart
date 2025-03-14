import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/home_page.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/json_reader.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  late MockHomeBloc mockBloc;
  late List<UserEntity> tUserModelList;

  setUp(() async {
    await Env.load(fileName: Assets.env.env);
    mockBloc = MockHomeBloc();
    await _buildDependecies(mockBloc);

    final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    tUserModelList =
        tUserModelRawData.map((e) => UserMapper().fromJson(e)).toList();
  });

  group('G01', () {
    testWidgets('should return a successful response',
        (WidgetTester tester) async {
      // arrange
      final app = _App();

      when(() => mockBloc.isLoadingPage).thenReturn(false);
      when(() => mockBloc.filteredList).thenReturn(tUserModelList);
      when(() => mockBloc.state).thenReturn(const HomeInitial());

      // act
      await tester.pumpWidget(app);
      await tester.pumpAndSettle(const Duration(milliseconds: 1000));

      // assert
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}

Future<void> _buildDependecies(MockHomeBloc mockBloc) async {
  final sl = GetIt.instance;
  await sl.reset();
  sl.registerFactory<HomeBloc>(() => mockBloc);
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    AppSettings();
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'US'),
        Locale("en"),
      ],
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: AppTheme.selected.value,
    );
  }
}
