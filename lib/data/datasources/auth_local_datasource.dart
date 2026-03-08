import 'package:youapp/core/storage/token_storage.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final TokenStorage tokenStorage;

  AuthLocalDatasourceImpl(this.tokenStorage);

  @override
  Future<void> saveToken(String token) async {
    await tokenStorage.saveToken(token);
  }

  @override
  Future<String?> getToken() async {
    return tokenStorage.getToken();
  }
}
