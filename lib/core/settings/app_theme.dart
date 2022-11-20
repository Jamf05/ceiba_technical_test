part of 'app_settings.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._internal();
  AppTheme._internal();
  factory AppTheme._() => _instance;
  factory AppTheme._fromJson(Map<String, dynamic> json) => AppTheme._();

  static ValueNotifier<ThemeData> selected = ValueNotifier(greenLight);
  static get _isDark => selected.value.brightness == Brightness.dark;

  static ThemeData get reverseGreenTheme =>
      _isDark ? AppTheme.greenLight : AppTheme.greenDark;

  static final greenLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.greenFirst,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenFirst,
    ),
    scaffoldBackgroundColor: AppColors.greenSecond,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.greenFirst
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.greenFirst.withOpacity(0.05)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.greenFirst, width: 2),
      ),
      labelStyle: AppFonts.textStyleR14.copyWith(color: AppColors.greenFirst)
    ),
  );
  static final greenDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.greenAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenFirst,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.greenAccent
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => Colors.greenAccent.withOpacity(0.05)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent, width: 2),
      ),
      labelStyle: AppFonts.textStyleR14.copyWith(color: Colors.greenAccent)
    )
  );
}
