# finniu

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Build the project for production :

flutter build appbundle --flavor production --target lib/main_production.dart

Build the project for staging:
flutter build appbundle --flavor staging --target lib/main_staging.dart

To test the project as a release mode

flutter run --release --flavor staging --target lib/main_staging.dart
