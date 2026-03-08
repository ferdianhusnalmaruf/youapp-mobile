import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../storage/token_storage.dart';
import 'dio_interceptor.dart';

class ApiClient {
  late Dio dio;

  ApiClient(TokenStorage tokenStorage) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(DioInterceptor(tokenStorage));
  }
}
