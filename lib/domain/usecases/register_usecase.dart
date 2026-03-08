import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthResponse> call(String email, String username, String password) {
    return repository.register(email, username, password);
  }
}
