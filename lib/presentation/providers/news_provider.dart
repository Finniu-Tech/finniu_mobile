import 'package:finniu/infrastructure/datasources/news_datasource_imp.dart';
import 'package:finniu/infrastructure/models/news_model.dart';
import 'package:finniu/presentation/providers/graphql_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final newsProvider = FutureProvider.autoDispose<List<NewsModel>>((ref) async {
  final client = ref.watch(gqlClientProvider);
  final dataSource = NewsDataSource(client.value!);
  return await dataSource.getNews();
});
