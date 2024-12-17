// datasources/news_datasource.dart
import 'package:finniu/graphql/queries.dart';
import 'package:finniu/infrastructure/datasources/base_datasource.dart';
import 'package:finniu/infrastructure/models/news_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NewsDataSource extends GraphQLBaseDataSource {
  NewsDataSource(super.client);

  Future<List<NewsModel>> getNews() async {
    final response = await client.query(
      QueryOptions(
        document: gql(QueryRepository.getNews),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    if (response.hasException) {
      throw response.exception!;
    }

    final List<dynamic> data = response.data!['allNews'] ?? [];

    if (data.isEmpty) {
      return <NewsModel>[];
    }

    return data.map((item) => NewsModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}
