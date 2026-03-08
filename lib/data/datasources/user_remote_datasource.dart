import 'package:dio/dio.dart';
import 'package:youapp/core/constants/api_constants.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/utils/logger.dart';
import 'package:youapp/data/models/user_response_model.dart';

abstract class UserRemoteDataSource {
  Future<UserResponseModel> getUserProfile();
  Future<UserResponseModel> updateUserProfile(Map<String, dynamic> body);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient api;

  UserRemoteDataSourceImpl(this.api);

  @override
  Future<UserResponseModel> getUserProfile() async {
    try {
      logger.i('Fetching user profile');

      final response = await api.dio.get(ApiConstants.getProfile);

      logger.i('Response data: ${response.data}');

      return UserResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e('Failed to fetch user profile: ${e.message}');
      logger.e('Response data: ${e.response?.data}');
      logger.e('Status code: ${e.response?.statusCode}');
      return UserResponseModel.fromJson(e.response?.data);
    }
  }

  @override
  Future<UserResponseModel> updateUserProfile(Map<String, dynamic> body) async {
    try {
      logger.d('Updating user profile with body: $body');

      final response = await api.dio.put(
        ApiConstants.updateProfile,
        data: body,
      );

      logger.i('Response data: ${response.data}');

      return UserResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      logger.e('Failed to update user profile: ${e.message}');
      logger.e('Response data: ${e.response?.data}');
      logger.e('Status code: ${e.response?.statusCode}');
      return UserResponseModel.fromJson(e.response?.data);
    }
  }
}
