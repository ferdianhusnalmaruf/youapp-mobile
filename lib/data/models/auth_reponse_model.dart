import 'package:youapp/core/models/base_response.dart';
import 'package:youapp/domain/entities/auth_response.dart';

class AuthResponseModel extends BaseResponse {
  final String? token;

  AuthResponseModel({
    super.statusCode,
    super.message,
    super.error,
    super.data,
    this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      error: json['error'],
      data: json['data'],
      token: json['access_token'],
    );
  }

  AuthResponse toEntity() {
    return AuthResponse(
      token: token,
      statusCode: statusCode,
      message: message,
      error: error,
      data: data,
    );
  }
}
