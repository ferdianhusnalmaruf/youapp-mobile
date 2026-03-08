import 'package:dio/dio.dart';
import 'package:youapp/core/utils/logger.dart';
import '../storage/token_storage.dart';

class DioInterceptor extends Interceptor {
  final TokenStorage storage;

  DioInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storage.getToken()?.trim();
    logger.d('Adding token to request: ${options.path}');
    logger.d(
      'Token value: ${token != null && token.isNotEmpty ? token : "No token found"}',
    );

    if (token != null && token.isNotEmpty) {
      options.headers["x-access-token"] = token;
    } else {
      logger.w('No token found in storage for ${options.path}');
    }

    return handler.next(options);
  }
}
