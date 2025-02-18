// lib/infrastructure/datasources/rates_datasource.dart
import 'package:dio/dio.dart';
import 'package:finniu/domain/entities/rates_entity.dart';
import 'package:finniu/main.dart';

abstract class RatesDataSource {
  Future<RatesResponseEntity> getRates();
}

class RatesDataSourceImpl implements RatesDataSource {
  final Dio dio;

  RatesDataSourceImpl({required this.dio});

  @override
  Future<RatesResponseEntity> getRates() async {
    late String url;
    try {
      if (appConfig.environment == "production") {
        url = 'https://cu93pctxhd.execute-api.us-east-1.amazonaws.com/rates';
      } else {
        url = 'https://nsipetgisa.execute-api.us-east-2.amazonaws.com/rates';
      }

      final response = await dio.get(url);

      final ratesResponse = RatesResponseModel.fromJson(response.data);
      return ratesResponse.toEntity();
    } catch (e) {
      throw Exception('Error getting rates: $e');
    }
  }
}
