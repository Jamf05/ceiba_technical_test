# CEIBA Technical Test App

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jorgemogotocoro/) [![Twitter](https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white)](https://twitter.com/MogotocoroJorge) [![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jorgemogotocoro05@outlook.es)

A simple Flutter application.

<!-- To download this app, click here to see the codemagic builds. You can choose to install the apk or the ipa(ios). -->

> Please star ⭐ the repo if you like what you see 😉.

## 📝 Requirements

- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
- A little knowledge of Dart and Flutter

## Project Structure

This project follows the guidelines of clean architecture.

![CleanArchitecture](screenshots/CleanArchitecture.webp)

## 💡 Features

- [x] Internationalization. Support for English and Spanish languages.
- [x] Persist data with SQLite.
- [x] Error Handling.
- [x] Custom dependency injection.
- [x] Custom local notifications.
- [x] Custom navigation transition.

## 🔌 Packages

| Name                                                          | Usage                                               |
| ------------------------------------------------------------- | --------------------------------------------------- |
| [**Get It**](https://pub.dev/packages/get_it)                 | Service Locator                                     |
| [**BLoC**](https://pub.dev/packages/bloc)                     | State Management                                    |
| [**SQLite**](https://pub.dev/packages/sqflite)                | SQL database to store address list                  |
| [**Dartz**](https://pub.dev/packages/dartz)                   | Functional Error Handling                           |

## 🚀 Getting Started

```bash
    flutter gen-l10n
    flutter packages pub run build_runner build --delete-conflicting-outputs
    flutter run
````

## 👨‍💻 Author(s)

[**Jorge A. Mogotocoro F.**](https://www.linkedin.com/in/jorgemogotocoro/)
