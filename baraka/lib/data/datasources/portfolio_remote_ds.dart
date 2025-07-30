import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/portfolio_model.dart';

@LazySingleton()
class PortfolioRemoteDataSource {
  final Dio _dio;

  PortfolioRemoteDataSource(this._dio);

  Future<PortfolioModel> fetchPortfolio() async {
    try {
      final response =
          await _dio.get('https://dummyjson.com/c/60b7-70a6-4ee3-bae8');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['portfolio']; //  extract "portfolio"
        return PortfolioModel.fromJson(data);
      } else {
        throw Exception('Failed to fetch portfolio: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Portfolio fetch error: $e');
    }
  }
}
