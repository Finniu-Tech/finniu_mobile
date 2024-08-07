import 'package:hooks_riverpod/hooks_riverpod.dart';

final documentFrontProvider = StateProvider.autoDispose<String?>((ref) => null);
final documentBackProvider = StateProvider.autoDispose<String?>((ref) => null);
final imagePathFrontProvider =
    StateProvider.autoDispose<String?>((ref) => null);
final imagePathBackProvider = StateProvider.autoDispose<String?>((ref) => null);
