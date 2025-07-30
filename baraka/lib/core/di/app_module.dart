import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio => Dio(
        BaseOptions(
          baseUrl:
              'https://dummyjson.com/c/60b7-70a6-4ee3-bae8', // Replace with your base URL
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Accept': 'application/json',
            // Add auth token if needed
            // 'Authorization': 'Bearer your-token',
          },
        ),
      );
}
