import 'package:youapp/domain/entities/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String email, String username, String password);
  Future<AuthResponse> register(String email, String username, String password);
  Future<String?> getToken();
}
