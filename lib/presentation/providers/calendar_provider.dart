import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedCalendarDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
