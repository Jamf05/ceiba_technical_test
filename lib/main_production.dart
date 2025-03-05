import 'package:ceiba_technical_test/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ceiba_technical_test/core/env.dart';
import 'package:ceiba_technical_test/features/app/app.dart';
import 'package:ceiba_technical_test/core/bloc/bloc_observer.dart';

import 'package:ceiba_technical_test/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load(fileName: Assets.env.envProduction);
  await di.init();
  Bloc.observer = CustomBlocObserver();
  runApp(const App());
}
