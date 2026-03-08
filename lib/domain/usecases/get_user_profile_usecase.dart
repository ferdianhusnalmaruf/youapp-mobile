import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserResponse> call() {
    return repository.getProfile();
  }
}
