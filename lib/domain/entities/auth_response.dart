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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthResponse &&
        other.token == token &&
        other.statusCode == statusCode &&
        other.message == message &&
        other.error == error &&
        other.data == data;
  }
}
