import 'dart:async';
import 'package:ceiba_technical_test/core/widget/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:ceiba_technical_test/features/app/pages/home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  static const route = "/SplashPage";
  const SplashPage({super.key});
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          redirect();
          return Center(
            child: Image.asset(
              Assets.splash.splashIconPng.path,
              width: MediaQuery.sizeOf(context).width * 0.35,
              alignment: Alignment.center,
            ),
          );
        },
      ),
    );
  }

  Future<Timer> redirect() async {
    return Timer(const Duration(milliseconds: 700), () {
      Nav.of(context).offAll(const HomePage());
    });
  }
}
