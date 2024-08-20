import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageBase64Provider = StateProvider.autoDispose<String?>((ref) => null);

final imagePathProvider = StateProvider.autoDispose<String?>((ref) => null);
