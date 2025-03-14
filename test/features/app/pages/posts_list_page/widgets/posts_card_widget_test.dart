import 'dart:convert';

import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/pages/posts_list_page/widgets/posts_card_widget.dart';
import 'package:ceiba_technical_test/features/data/mappers/posts_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/posts_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../helpers/dummy_data.dart';
import '../../../../../helpers/json_reader.dart';

void main() {
  testWidgets('Should return a ErrorInNetworkImageWidget',
      (WidgetTester tester) async {
    // arrange
    final Map<String, dynamic> jsonMap = json.decode(
      JsonHelpers.readJson(DummyData.postResponse),
    );
    final item = PostMapper().fromJson(jsonMap);

    // act
    final app = _App(item);
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(PostsCardWidget), findsOneWidget);
  });
}

class _App extends StatelessWidget {
  final PostEntity item;
  const _App(this.item);

  @override
  Widget build(BuildContext context) {
    AppSettings();
    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!),
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
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PostsCardWidget(
              item: item,
            ),
          ],
        ),
      ),
      theme: AppTheme.selected.value,
    );
  }
}
