import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BaseWidget test', (WidgetTester tester) async {
    // arrange
    final app = _App();
    // act
    await tester.pumpWidget(app);
    // assert
    expect(find.byType(Placeholder), findsOneWidget);
  });
}

class _MyWidget extends StatelessWidget with BaseWidget {
  @override
  Widget build(BuildContext context) {
    BaseWidget.init(context);
    return Placeholder(
      fallbackHeight: size.height,
      fallbackWidth: size.width,
    );
  }
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
      home: _MyWidget(),
      theme: AppTheme.selected.value,
    );
  }
}
