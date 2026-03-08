import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/get_user_profile_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository repo;
  late GetUserProfileUseCase usecase;

  setUp(() {
    repo = MockUserRepository();
    usecase = GetUserProfileUseCase(repo);
  });
  test('user repository ...', () async {
    when(
      () => repo.getProfile(),
    ).thenAnswer((_) async => UserResponse(data: User(name: 'John Doe')));

    final result = await usecase();

    expect(result, UserResponse(data: User(name: 'John Doe')));
    verify(() => repo.getProfile()).called(1);
  });
}
