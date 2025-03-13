# Makefile for Flutter project

coverage:
	fvm flutter test --coverage
	lcov --ignore-errors unused --remove coverage/lcov.info 'lib/core/gen/*' 'lib/core/localization/*' 'lib/core/settings*' -o coverage/lcov.info
	genhtml coverage/lcov.info -o coverage/html
.PHONY: coverage

build_runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs
.PHONY: build_runner

pub_get:
	fvm flutter clean && fvm flutter pub get
.PHONY: pub_get

rm_pub_get:
	rm -rf pubspec.lock && fvm flutter clean && fvm flutter pub upgrade && fvm flutter pub get
.PHONY: rm_pub_get