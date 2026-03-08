import 'package:youapp/domain/entities/user_response.dart';

abstract class UserRepository {
  Future<UserResponse> getProfile();
  Future<UserResponse> updateProfile(Map<String, dynamic> body);
}
