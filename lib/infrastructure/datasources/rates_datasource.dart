import 'package:dio/dio.dart';
import 'package:finniu/infrastructure/models/money_rate_model.dart';

class MoneyRatesDataSource {
  static const String sunatRateApi = "https://api.apis.net.pe/v2/sunat/tipo-cambio";
  static const String rextieAuthApi = "https://api.rextie.com/api/v1/auth/token";
  static const String rextieRateApi = "https://api.rextie.com/api/ext/v1/services/quotes";

  final Dio _dio;
  String? _rextieToken;

  MoneyRatesDataSource() : _dio = Dio();

  Future<SunatRateResponse> getSunatRate(String date) async {
    try {
      final response = await _dio.get(
        '$sunatRateApi?date=$date',
        options: Options(
          headers: {
            'Authorization': 'apis-token-12152.tA7uF92fnrOKC4GEs7Q2KxAqjw7hVHB1',
          },
        ),
      );
      return SunatRateResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch SUNAT rate: $e');
    }
  }

  Future<void> authenticateRextie(String username, String password) async {
    try {
      final response = await _dio.post(
        rextieAuthApi,
        data: {
          'username': username,
          'password': password,
        },
      );
      _rextieToken = RextieAuthResponse.fromJson(response.data).accessToken;
    } catch (e) {
      throw Exception('Failed to authenticate with Rextie: $e');
    }
  }

  Future<RextieRateResponse> getRextieRate(int profileId) async {
    if (_rextieToken == null) {
      throw Exception('Must authenticate with Rextie first');
    }

    try {
      final response = await _dio.post(
        '$rextieRateApi?profile_id=$profileId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_rextieToken',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'profile_id': profileId,
          'source_currency': 'USD',
          'source_amount': '1000.00',
          'target_currency': 'PEN',
        },
      );
      return RextieRateResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch Rextie rate: $e');
    }
  }
}
