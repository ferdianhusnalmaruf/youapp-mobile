import 'package:dio/dio.dart';
import 'package:youapp/core/constants/api_constants.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/utils/logger.dart';
import 'package:youapp/data/models/auth_reponse_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(
    String email,
    String username,
    String password,
  );
  Future<AuthResponseModel> register(
    String email,
    String username,
    String password,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<AuthResponseModel> login(
    String email,
    String username,
    String password,
  ) async {
    try {
      logger.i('Login request - Email: $email');
      logger.d(
        'Request payload: {email: $email, password: ***, username: $username}',
      );

      final response = await api.dio.post(
        ApiConstants.login,
        data: {'email': email, 'password': password, 'username': username},
      );

      logger.i('Response data: ${response.data}');

      logger.i('Login successful');

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e('Login failed: ${e.message}');
      logger.e('Response data: ${e.response?.data}');
      logger.e('Status code: ${e.response?.statusCode}');
      return AuthResponseModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<AuthResponseModel> register(
    String email,
    String username,
    String password,
  ) async {
    try {
      logger.i('Register request - Email: $email');
      logger.d(
        'Request payload: {email: $email, password: ***, username: $username}',
      );

      final response = await api.dio.post(
        ApiConstants.register,
        data: {'email': email, 'password': password, 'username': username},
      );

      logger.i('Response data: ${response.data}');

      logger.i('Registration successful');

      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e('Registration failed: ${e.message}');
      logger.e('Response data: ${e.response?.data}');
      logger.e('Status code: ${e.response?.statusCode}');
      return AuthResponseModel.fromJson(e.response?.data);
    }
  }
}
