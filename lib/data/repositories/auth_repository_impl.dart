import 'package:youapp/data/datasources/auth_local_datasource.dart';
import 'package:youapp/data/datasources/auth_remote_datasource.dart';
import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  final AuthLocalDatasource localDataSource;

  AuthRepositoryImpl(this.dataSource, this.localDataSource);

  @override
  Future<AuthResponse> login(
    String email,
    String username,
    String password,
  ) async {
    final response = await dataSource.login(email, username, password);

    final token = response.token;
    if (token != null) {
      await localDataSource.saveToken(token);
    }
    return response.toEntity();
  }

  @override
  Future<AuthResponse> register(
    String email,
    String username,
    String password,
  ) async {
    final response = await dataSource.register(email, username, password);

    final token = response.token;
    if (token != null) {
      await localDataSource.saveToken(token);
    }

    return response.toEntity();
  }

  @override
  Future<String?> getToken() {
    return localDataSource.getToken();
  }
}
