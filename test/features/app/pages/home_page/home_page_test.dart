import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/database/database_helper.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/core/validators/text_input.dart';
import 'package:ceiba_technical_test/features/app/blocs/home_bloc/home_bloc.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/home_page.dart';
import 'package:ceiba_technical_test/features/app/pages/posts_list_page/posts_list_page.dart';
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

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late MockHomeBloc mockBloc;
  late MockDatabaseHelper mockDatabaseHelper;
  late List<UserEntity> tUserModelList;

  const cleaningServicesOutlinedKey = Key("ctt_cleaning_services_outlined");
  const homePageSingleChildScrollViewKey = Key("ctt_home_page_single_child_scroll_view");
  const userCardWidgetKeyZero = Key("ctt_user_card_widget_0");

  setUp(() async {
    await Env.load(fileName: Assets.env.envDevelopment);
    mockBloc = MockHomeBloc();
    mockDatabaseHelper = MockDatabaseHelper();
    await _buildDependecies(mockBloc, mockDatabaseHelper);

    final List tUserModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.usersListResponse),
    );
    tUserModelList =
        tUserModelRawData.map((e) => UserMapper().fromJson(e)).toList();
  });

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

  testWidgets(
      'In culpa excepteur mollit ullamco quis anim magna anim officia labore commodo anim esse.',
      (WidgetTester tester) async {
    // arrange
    final app = _App();

    when(() => mockBloc.isLoadingPage).thenReturn(false);
    when(() => mockBloc.filteredList).thenReturn(tUserModelList);
    when(() => mockBloc.state).thenReturn(const HomeInitial());

    when(() => mockDatabaseHelper.deleteDatabase()).thenAnswer((_) async {});
    when(() => mockDatabaseHelper.init())
        .thenAnswer((_) async => mockDatabaseHelper);

    // act
    await tester.pumpWidget(app);
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));

    await tester.tap(find.byKey(cleaningServicesOutlinedKey));
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));

    // assert
    expect(find.byType(HomePage), findsOneWidget);
    verify(() => mockDatabaseHelper.deleteDatabase()).called(1);
    verify(() => mockDatabaseHelper.init()).called(1);
  });

  testWidgets('Consectetur sint occaecat dolore dolore commodo.',
      (WidgetTester tester) async {
    // arrange
    final app = _App();

    final Exception exception = Exception('Error');
    final failure = ExceptionFailure.decode(exception);

    whenListen<HomeState>(
      mockBloc,
      Stream<HomeState>.fromIterable(
          [const HomeInitial(), HomeFailureState(failure)]),
    );

    when(() => mockBloc.isLoadingPage).thenReturn(false);
    when(() => mockBloc.filteredList).thenReturn(tUserModelList);
    when(() => mockBloc.state).thenReturn(const HomeInitial());

    // act
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text(failure.message!), findsOneWidget);
  });

  testWidgets('Sint qui minim laboris minim cupidatat ex.',
      (WidgetTester tester) async {
    // arrange
    final app = _App();

    when(() => mockBloc.isLoadingPage).thenReturn(false);
    when(() => mockBloc.filteredList).thenReturn(tUserModelList);
    when(() => mockBloc.state).thenReturn(const HomeInitial());

    // act
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    await tester.fling(find.byKey(homePageSingleChildScrollViewKey),
        const Offset(0, 400), 800);
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byKey(homePageSingleChildScrollViewKey), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Fugiat id adipisicing in qui.', (WidgetTester tester) async {
    // arrange
    final app = _App();
    const tText = 'Cillum ullamco';
    final tQuery = TextFormInput.dirty(tText, start: 0, end: 15);

    when(() => mockBloc.isLoadingPage).thenReturn(false);
    when(() => mockBloc.filteredList).thenReturn(tUserModelList);
    when(() => mockBloc.state).thenReturn(const HomeInitial());
    when(() => mockBloc.query).thenReturn(tQuery);

    // act
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), tText);
    await tester.pumpAndSettle();

    // assert
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text(tText), findsOneWidget);
  });

  testWidgets('Adipisicing irure occaecat sit culpa.',
      (WidgetTester tester) async {
    // arrange
    final app = _App();

    when(() => mockBloc.isLoadingPage).thenReturn(false);
    when(() => mockBloc.filteredList).thenReturn(tUserModelList);
    when(() => mockBloc.state).thenReturn(const HomeInitial());

    // act
    await tester.pumpWidget(app);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(userCardWidgetKeyZero));
    await tester.pumpAndSettle();

    // assert
    // expect(find.byType(PostsListPage), findsOneWidget);
    // expect(find.byKey(userCardWidgetKeyZero), findsOneWidget);
  });
}

Future<void> _buildDependecies(
    HomeBloc mockBloc, DatabaseHelper mockDatabaseHelper) async {
  final sl = GetIt.instance;
  await sl.reset();
  sl.registerFactory<HomeBloc>(() => mockBloc);
  sl.registerFactory<DatabaseHelper>(() => mockDatabaseHelper);
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
