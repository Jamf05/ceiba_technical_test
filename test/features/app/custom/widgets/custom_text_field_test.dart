import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/settings/app_settings.dart';
import 'package:ceiba_technical_test/features/app/custom/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Sunt est mollit ea qui qui veniam.',
      (WidgetTester tester) async {
    // arrange
    // act
    final app = _App(
      child: CustomTextField(
        onChanged: (String _) {},
      ),
    );
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(CustomTextField), findsOneWidget);
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
