import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final UserRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<UserResponse> call(Map<String, dynamic> body) {
    return repository.updateProfile(body);
  }
}
