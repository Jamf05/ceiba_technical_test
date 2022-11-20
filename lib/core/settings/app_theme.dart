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
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.greenFirst.withOpacity(0.05)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // enabledBorder: UnderlineInputBorder(
      //   borderSide: BorderSide(color: AppColors.greenFirst),
      // ),
      // border: UnderlineInputBorder(
      //   borderSide: BorderSide(color: AppColors.greenFirst),
      // ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.greenFirst, width: 2),
      ),
      labelStyle: AppFonts.textStyleR14.copyWith(color: AppColors.greenFirst)
    )
  );
  static final greenDark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.greenFirst,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.greenFirst,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.greenFirst.withOpacity(0.05)),
      ),
    ),
  );
}
