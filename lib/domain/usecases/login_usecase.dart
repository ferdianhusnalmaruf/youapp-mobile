import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResponse> call(String email, String username, String password) {
    return repository.login(email, username, password);
  }
}
