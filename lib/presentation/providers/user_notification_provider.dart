//create a riverpod future provider to consume an graphql api

import 'package:finniu/domain/entities/user_notification_entity.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finniu/graphql/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final userNotificationProvider = FutureProvider.autoDispose<List<UserNotificationEntity>>((ref) async {
  final client = await ref.watch(gqlClientProvider.future);
  final QueryResult result = await client.query(
    QueryOptions(document: gql(QueryRepository.getUserNotification), fetchPolicy: FetchPolicy.noCache),
  );
  if (result.hasException) {
    throw result.exception!;
  }
  final data = result.data?['userNotificationQueries']['userNotificationsSlider'];
  if (data == null || data.isEmpty) {
    return [];
  }

  return List<UserNotificationEntity>.from(
    data.map((json) => UserNotificationEntity.fromJson(json)),
  );
});
