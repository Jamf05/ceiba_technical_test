export 'package:ceiba_technical_test/core/settings/app_settings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ceiba_technical_test/injection_container.dart';
import 'package:ceiba_technical_test/core/localization/app_localizations.dart';
import 'package:ceiba_technical_test/core/overlay/custom_overlays.dart';
import 'package:ceiba_technical_test/core/utils/navigation.dart';

abstract class BaseBlocState<T extends StatefulWidget,K extends Bloc> extends State<T>{
  late K bloc;
  late Size size;
  late Nav nav;
  late Show show; 
  late AppLocalizations l10n;
  late ThemeData theme;
  late bool isDarkTheme;
  
  @override
  void initState() {
    bloc = sl<K>();
    onInitState.call();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    nav = Nav.of(context);
    size = MediaQuery.of(context).size;
    l10n = AppLocalizations.of(context);
    show = Show.of(context);
    theme = Theme.of(context);
    isDarkTheme = theme.brightness == Brightness.dark;
    super.didChangeDependencies();
  }
  
  void onInitState() {}
}