import 'package:get_storage/get_storage.dart';

class TokenStorage {
  final box = GetStorage();

  Future<void> saveToken(String token) async {
    await box.write("token", token);
  }

  String? getToken() {
    return box.read("token");
  }

  Future<void> clear() async {
    await box.remove("token");
  }
}
