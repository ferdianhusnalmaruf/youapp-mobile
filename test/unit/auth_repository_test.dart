import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';
import 'package:youapp/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repo;
  late LoginUseCase usecase;

  setUp(() {
    repo = MockAuthRepository();
    usecase = LoginUseCase(repo);
  });

  test('login returns token', () async {
    const email = 'a@mail.com';
    const username = 'a';
    const password = '123';

    when(
      () => repo.login(email, username, password),
    ).thenAnswer((_) async => AuthResponse(token: 'token123'));

    final result = await usecase(email, username, password);

    expect(result, AuthResponse(token: 'token123'));
  });

  test('login calls repository once with correct params', () async {
    const email = 'user@mail.com';
    const username = 'user1';
    const password = 'secret';

    when(
      () => repo.login(email, username, password),
    ).thenAnswer((_) async => AuthResponse(token: 'token123'));

    await usecase(email, username, password);

    verify(() => repo.login(email, username, password)).called(1);
    verifyNoMoreInteractions(repo);
  });

  test('login propagates repository exception', () async {
    const email = 'x@mail.com';
    const username = 'x';
    const password = 'wrong';

    when(
      () => repo.login(email, username, password),
    ).thenThrow(Exception('login failed'));

    expect(() => usecase(email, username, password), throwsA(isA<Exception>()));
  });
}
