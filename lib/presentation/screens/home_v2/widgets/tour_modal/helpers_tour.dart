import 'package:finniu/infrastructure/datasources/complete_last_tour_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:finniu/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void seeAnotherTime(
  BuildContext context,
  WidgetRef ref, {
  idFinal = false,
}) async {
  if (idFinal) {
    print("es el ulitmo");
    ref.read(seeLaterProvider.notifier).state = false;
    final GraphQLClient client = ref.read(gqlClientProvider).value!;
    await CompleteLastTourImp(client).completeLastTour();
    ref.read(userProfileNotifierProvider.notifier).updateFields(
          hasCompletedTour: true,
        );
  } else {
    print("no es el ulitmo");
    ref.read(seeLaterProvider.notifier).state = true;
  }
  Navigator.pop(context);
}
