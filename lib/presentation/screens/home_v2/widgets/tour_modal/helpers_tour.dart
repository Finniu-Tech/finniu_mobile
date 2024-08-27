import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void seeAnotherTime(BuildContext context, WidgetRef ref) {
  final userProfile = ref.read(userProfileNotifierProvider);
  userProfile.hasCompletedTour = true;
  Navigator.pop(context);
}
