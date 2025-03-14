import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/empty_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Sunt est mollit ea qui qui veniam.',
      (WidgetTester tester) async {
    // arrange
    const tMeassage = 'message';
    // act
    final app = _App(
      theme: AppTheme.selected.value,
      child: EmptyItemWidget(
        message: tMeassage,
      ),
    );
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(EmptyItemWidget), findsOneWidget);
    expect(find.text(tMeassage), findsOneWidget);
  });

  testWidgets(
      'Proident exercitation veniam consectetur esse consectetur eu et id officia adipisicing enim tempor ex.',
      (WidgetTester tester) async {
    // arrange
    const tMeassage = 'message';
    tester.binding.platformDispatcher.clearAllTestValues();
    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    // act
    final app = _App(
      theme: AppTheme.greenDark,
      child: EmptyItemWidget(
        message: tMeassage,
      ),
    );
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(EmptyItemWidget), findsOneWidget);
    expect(find.text(tMeassage), findsOneWidget);
  });
}

class _App extends StatelessWidget {
  final ThemeData theme;
  final Widget child;
  const _App({required this.child, required this.theme});

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
      theme: theme,
    );
  }
}
