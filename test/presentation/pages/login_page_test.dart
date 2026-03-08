import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/usecases/get_token_usecase.dart';
import 'package:youapp/domain/usecases/login_usecase.dart';
import 'package:youapp/domain/usecases/register_usecase.dart';
import 'package:youapp/presentation/controller/auth_controller.dart';
import 'package:youapp/presentation/pages/login_page.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockGetTokenUseCase extends Mock implements GetTokenUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGetTokenUseCase mockGetTokenUseCase;
  late AuthController authController;

  setUp(() {
    Get.testMode = true;
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockGetTokenUseCase = MockGetTokenUseCase();

    when(() => mockGetTokenUseCase.call()).thenAnswer((_) async => null);
    when(
      () => mockLoginUseCase.call(any(), any(), any()),
    ).thenAnswer((_) async => AuthResponse());

    authController = AuthController(
      mockLoginUseCase,
      mockRegisterUseCase,
      mockGetTokenUseCase,
    );

    Get.put<AuthController>(authController);
  });

  tearDown(() {
    Get.reset();
  });

  Widget buildLoginPage() {
    return GetMaterialApp(home: LoginPage());
  }

  testWidgets('Login button disabled on empty input', (tester) async {
    await tester.pumpWidget(buildLoginPage());
    await tester.pump();

    final buttonFinder = find.widgetWithText(ElevatedButton, 'Login');
    final button = tester.widget<ElevatedButton>(buttonFinder);

    expect(button.onPressed, isNull);
  });

  testWidgets('Calls login with email when input contains @', (tester) async {
    await tester.pumpWidget(buildLoginPage());
    await tester.pump();

    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextField, 'Password');

    await tester.enterText(emailField, 'user@mail.com');
    await tester.enterText(passwordField, 'secret123');
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    verify(
      () => mockLoginUseCase.call('user@mail.com', '', 'secret123'),
    ).called(1);
  });

  testWidgets('Calls login with username when input has no @', (tester) async {
    await tester.pumpWidget(buildLoginPage());
    await tester.pump();

    final emailField = find.widgetWithText(TextFormField, 'Email');
    final passwordField = find.widgetWithText(TextField, 'Password');

    await tester.enterText(emailField, 'myusername');
    await tester.enterText(passwordField, 'secret123');
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    verify(
      () => mockLoginUseCase.call('', 'myusername', 'secret123'),
    ).called(1);
  });
}
