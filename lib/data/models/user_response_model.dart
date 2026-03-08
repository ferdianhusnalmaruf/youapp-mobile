import 'package:youapp/core/models/base_response.dart';
import 'package:youapp/domain/entities/user_response.dart';

class UserResponseModel extends BaseResponse<UserModel> {
  UserResponseModel({super.statusCode, super.message, super.error, super.data});

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      error: json['error'],
      data: json['data'] != null ? UserModel.fromJson(json['data']) : null,
    );
  }

  UserResponse toEntity() {
    return UserResponse(
      statusCode: statusCode,
      message: message,
      error: error,
      data: data?.toEntity(),
    );
  }
}

class UserModel {
  final String? username;
  final String? email;
  final String? name;
  final DateTime? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String> interests;

  UserModel({
    this.username,
    this.email,
    this.name,
    this.horoscope,
    this.zodiac,
    this.birthday,
    this.height,
    this.weight,
    this.interests = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      name: json['name'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      height: json['height'],
      weight: json['weight'],
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  User toEntity() {
    return User(
      username: username ?? '',
      email: email ?? '',
      name: name ?? '',
      birthday: birthday,
      horoscope: horoscope,
      zodiac: zodiac,
      height: height,
      weight: weight,
      interests: interests,
    );
  }
}
