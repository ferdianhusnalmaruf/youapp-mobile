import 'package:youapp/core/models/base_entity.dart';

class AuthResponse extends BaseEntity {
  final String? token;

  AuthResponse({
    this.token,
    super.statusCode,
    super.message,
    super.error,
    super.data,
  });
}
