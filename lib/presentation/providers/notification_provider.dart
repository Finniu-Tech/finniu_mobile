import 'package:finniu/infrastructure/datasources/notifications_datasource_imp.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationsDataSourceProvider = Provider<NotificationsDataSource>((ref) {
  final config = ref.watch(appConfigProvider);
  return NotificationsDataSource(baseUrl: config.notificationsBaseUrl);
});
