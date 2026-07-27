import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/network/api_constants.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @lazySingleton
  Dio dio(SharedPreferences sharedPreferences) {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: Implement token retrieval
          final token =
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjEyZGYwOTc2ZTlmYzNhMmFlNGFlYSIsImlhdCI6MTc4NTAwMDUxNCwiZXhwIjoxNzg3NTkyNTE0fQ.1RRum7jBNfCyufz1hVY4G_QH3VSeizr8xWUtdZXposk";
          // final token = sharedPreferences.getString('token');

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
  }
}
