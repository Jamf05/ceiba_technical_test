import 'dart:convert';

import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/widgets/user_card_widget.dart';
import 'package:ceiba_technical_test/features/data/mappers/user_mapper.dart';
import 'package:ceiba_technical_test/features/domain/entities/user_entity.dart';
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
    final user = UserMapper().fromJson(jsonMap);

    // act
    final app = _App(user);
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(UserCardWidget), findsOneWidget);
  });
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
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserCardWidget(
              user: user,
            ),
          ],
        ),
      ),
      theme: AppTheme.selected.value,
    );
  }
}
