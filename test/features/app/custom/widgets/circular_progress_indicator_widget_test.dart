import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/circular_progress_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Nostrud qui labore non nostrud sit dolor quis deserunt ipsum et exercitation sint eu.',
      (WidgetTester tester) async {
    // arrange
    // act
    final app = _App(
      child: CircularProgressWidget(),
    );
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(CircularProgressWidget), findsOneWidget);
  });

  testWidgets(
      'Consectetur voluptate voluptate sit ut veniam sunt elit occaecat excepteur.',
      (WidgetTester tester) async {
    // arrange
    const tText = 'text';
    // act
    final app = _App(
      child: CircularProgressWidget(
        center: false,
      ),
    );
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(CircularProgressWidget), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(tText), findsNothing);
  });
}

class _App extends StatelessWidget {
  final Widget child;
  const _App({required this.child});

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
          children: [child],
        ),
      ),
      theme: AppTheme.selected.value,
    );
  }
}
