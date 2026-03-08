import 'package:youapp/core/models/base_entity.dart';

class UserResponse implements BaseEntity<User> {
  @override
  final int? statusCode;

  @override
  final String? message;

  @override
  final String? error;

  @override
  final User? data;

  UserResponse({this.statusCode, this.message, this.error, this.data});
}

class User {
  final String? username;
  final String? email;
  final String? name;
  final DateTime? birthday;
  final String? horoscope;
  final String? zodiac;
  final String? gender;
  final int? height;
  final int? weight;
  final List<String> interests;

  const User({
    this.username,
    this.email,
    this.name,
    this.birthday,
    this.horoscope,
    this.gender,
    this.zodiac,
    this.height,
    this.weight,
    this.interests = const [],
  });

  bool get hasValues {
    return username != null ||
        email != null ||
        name != null ||
        birthday != null ||
        horoscope != null ||
        zodiac != null ||
        gender != null ||
        height != null ||
        weight != null;
  }

  int get age {
    if (birthday == null) return 0;

    final today = DateTime.now();
    int age = today.year - birthday!.year;

    if (today.month < birthday!.month ||
        (today.month == birthday!.month && today.day < birthday!.day)) {
      age--;
    }

    return age;
  }
}
