import 'package:youapp/data/datasources/user_remote_datasource.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<UserResponse> getProfile() async {
    final response = await dataSource.getUserProfile();

    return response.toEntity();
  }

  @override
  Future<UserResponse> updateProfile(Map<String, dynamic> body) async {
    final response = await dataSource.updateUserProfile(body);

    return response.toEntity();
  }
}
