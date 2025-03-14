import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:ceiba_technical_test/core/failures/exception.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/blocs/posts_list_bloc/posts_list_bloc.dart';
import 'package:ceiba_technical_test/features/app/pages/posts_list_page/posts_list_page.dart';
import 'package:ceiba_technical_test/features/data/mappers/posts_mapper.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/dummy_data.dart';
import '../../../../helpers/json_reader.dart';

class MockPostsListBloc extends MockBloc<PostsListEvent, PostsListState>
    implements PostsListBloc {}

void main() {
  late UserEntity tUser;
  late List<PostEntity> tPostsModelList;
  late MockPostsListBloc mockBloc;

  const cttPostsListPageKey = Key("ctt_posts_list_page");

  setUp(() async {
    mockBloc = MockPostsListBloc();
    final Map<String, dynamic> jsonMap = json.decode(
      JsonHelpers.readJson(DummyData.userResponse),
    );
    tUser = UserMapper().fromJson(jsonMap);

    final List tPostsModelRawData = json.decode(
      JsonHelpers.readJson(DummyData.postsListResponse),
    );
    tPostsModelList = tPostsModelRawData
        .map((e) => PostMapper().fromJson(Map<String, dynamic>.from(e)))
        .toList();

    await _buildDependecies(mockBloc);
  });

  group('G01', () {
    testWidgets('should return a successful response',
        (WidgetTester tester) async {
      // arrange
      final app = _App(tUser);

      when(() => mockBloc.isLoadingPage).thenReturn(false);
      when(() => mockBloc.state).thenReturn(const PostsListInitial());
      when(() => mockBloc.postsList).thenReturn(tPostsModelList);

      // act
      await tester.pumpWidget(app);
      // assert
      expect(find.byType(PostsListPage), findsOneWidget);
      expect(find.byType(Scrollable), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('should return a failed response', (WidgetTester tester) async {
      // arrange
      final app = _App(tUser);
      final Exception exception = Exception('Error');
      final failure = ExceptionFailure.decode(exception);

      whenListen<PostsListState>(
        mockBloc,
        Stream<PostsListState>.fromIterable(
            [const PostsListInitial(), PostsListFailureState(failure)]),
      );

      when(() => mockBloc.isLoadingPage).thenReturn(false);
      when(() => mockBloc.state).thenReturn(const PostsListInitial());
      when(() => mockBloc.postsList).thenReturn(tPostsModelList);

      // act
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(PostsListPage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(failure.message!), findsOneWidget);
    });

    testWidgets('should be able to refresh the data',
        (WidgetTester tester) async {
      // arrange
      final app = _App(tUser);

      when(() => mockBloc.isLoadingPage).thenReturn(false);
      when(() => mockBloc.state).thenReturn(const PostsListInitial());
      when(() => mockBloc.postsList).thenReturn(tPostsModelList);

      // act
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();
      await tester.fling(find.byKey(cttPostsListPageKey), const Offset(0, 400), 800);
      await tester.pumpAndSettle();

      // assert
      expect(find.byType(PostsListPage), findsOneWidget);
      expect(find.byKey(cttPostsListPageKey), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}

Future<void> _buildDependecies(PostsListBloc mockBloc) async {
  final sl = GetIt.instance;
  await sl.reset();
  sl.registerFactory(() => mockBloc);
}

class _App extends StatelessWidget {
  final UserEntity user;
  const _App(this.user);

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
      home: PostsListPage(user: user),
      theme: AppTheme.selected.value,
    );
  }
}
