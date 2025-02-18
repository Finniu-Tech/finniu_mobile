import 'package:dio/dio.dart';
import 'package:finniu/domain/entities/rates_entity.dart';
import 'package:finniu/infrastructure/datasources/rates_datasource.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider((ref) => Dio());

final ratesDataSourceProvider = Provider<RatesDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return RatesDataSourceImpl(dio: dio);
});

final ratesProvider = FutureProvider.autoDispose<RatesResponseEntity>((ref) async {
  final dataSource = ref.watch(ratesDataSourceProvider);
  return dataSource.getRates();
});
