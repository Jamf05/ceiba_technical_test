import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get homePageTitle => 'Prueba de Ingreso';

  @override
  String get homePageSearchUser => 'Buscar usuario';

  @override
  String get homePageSeePublications => 'VER PUBLICACIONES';

  @override
  String get homePageSeeListIsEmpty => 'List is empty';

  @override
  String get postsListTitle => 'Publicaciones';
}
