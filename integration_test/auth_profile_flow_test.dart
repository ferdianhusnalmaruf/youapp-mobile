import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp/domain/entities/auth_response.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/usecases/get_token_usecase.dart';
import 'package:youapp/domain/usecases/get_user_profile_usecase.dart';
import 'package:youapp/domain/usecases/login_usecase.dart';
import 'package:youapp/domain/usecases/register_usecase.dart';
import 'package:youapp/domain/usecases/update_user_profile_usecase.dart';
import 'package:youapp/presentation/controller/auth_controller.dart';
import 'package:youapp/presentation/controller/interest_controller.dart';
import 'package:youapp/presentation/controller/update_about_user_controller.dart';
import 'package:youapp/presentation/controller/user_controller.dart';
import 'package:youapp/presentation/pages/interests_page.dart';
import 'package:youapp/presentation/pages/login_page.dart';
import 'package:youapp/presentation/pages/register_page.dart';
import 'package:youapp/presentation/pages/user_page.dart';
import 'package:youapp/routes/app_routes.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockGetTokenUseCase extends Mock implements GetTokenUseCase {}

class MockGetUserProfileUseCase extends Mock implements GetUserProfileUseCase {}

class MockUpdateUserProfileUseCase extends Mock
    implements UpdateUserProfileUseCase {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockGetTokenUseCase mockGetTokenUseCase;
  late MockGetUserProfileUseCase mockGetUserProfileUseCase;
  late MockUpdateUserProfileUseCase mockUpdateUserProfileUseCase;

  late User currentUser;

  setUp(() {
    Get.testMode = true;
    Get.reset();

    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockGetTokenUseCase = MockGetTokenUseCase();
    mockGetUserProfileUseCase = MockGetUserProfileUseCase();
    mockUpdateUserProfileUseCase = MockUpdateUserProfileUseCase();

    currentUser = const User(
      username: 'tester',
      email: 'tester@mail.com',
      interests: ['reading'],
    );

    when(() => mockGetTokenUseCase.call()).thenAnswer((_) async => null);
    when(
      () => mockLoginUseCase.call(any(), any(), any()),
    ).thenAnswer((_) async => AuthResponse(token: 'token-123'));
    when(
      () => mockRegisterUseCase.call(any(), any(), any()),
    ).thenAnswer((_) async => AuthResponse(message: 'created'));
    when(
      () => mockGetUserProfileUseCase.call(),
    ).thenAnswer((_) async => UserResponse(data: currentUser));

    when(() => mockUpdateUserProfileUseCase.call(any())).thenAnswer((
      inv,
    ) async {
      final body = inv.positionalArguments[0] as Map<String, dynamic>;
      currentUser = _mergeUser(currentUser, body);
      return UserResponse(data: currentUser);
    });
  });

  tearDown(() {
    Get.reset();
  });

  Future<void> pumpTestApp(
    WidgetTester tester, {
    String initialRoute = AppRoutes.login,
  }) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: initialRoute,
        getPages: [
          GetPage(
            name: AppRoutes.login,
            page: () => LoginPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut<AuthController>(
                () => AuthController(
                  mockLoginUseCase,
                  mockRegisterUseCase,
                  mockGetTokenUseCase,
                ),
              );
            }),
          ),
          GetPage(
            name: AppRoutes.register,
            page: () => const RegisterPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut<AuthController>(
                () => AuthController(
                  mockLoginUseCase,
                  mockRegisterUseCase,
                  mockGetTokenUseCase,
                ),
              );
            }),
          ),
          GetPage(
            name: AppRoutes.profile,
            page: () => const UserPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut<UserController>(
                () => UserController(
                  mockGetUserProfileUseCase,
                  mockUpdateUserProfileUseCase,
                ),
              );

              Get.lazyPut<UpdateAboutUserController>(
                () => UpdateAboutUserController(),
              );

              Get.lazyPut<InterestController>(
                () => InterestController(
                  mockGetUserProfileUseCase,
                  mockUpdateUserProfileUseCase,
                ),
              );
            }),
          ),
          GetPage(
            name: AppRoutes.interests,
            page: () => InterestsPage(),
            binding: BindingsBuilder(() {
              Get.lazyPut<InterestController>(
                () => InterestController(
                  mockGetUserProfileUseCase,
                  mockUpdateUserProfileUseCase,
                ),
              );
            }),
          ),
        ],
      ),
    );

    await tester.pumpAndSettle();
  }

  testWidgets('Login flow navigates to profile', (tester) async {
    await pumpTestApp(tester, initialRoute: AppRoutes.login);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'tester@mail.com',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'password123',
    );
    await tester.pumpAndSettle();

    final loginButtonFinder = find.widgetWithText(ElevatedButton, 'Login');
    final loginButton = tester.widget<ElevatedButton>(loginButtonFinder);
    expect(loginButton.onPressed, isNotNull);

    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(loginButtonFinder);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.profile);
    expect(find.text('About'), findsOneWidget);
    verify(
      () => mockLoginUseCase.call('tester@mail.com', '', 'password123'),
    ).called(1);
  });

  testWidgets('Register flow returns to login page', (tester) async {
    await pumpTestApp(tester, initialRoute: AppRoutes.register);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Enter Email'),
      'new@mail.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Enter Username'),
      'newuser',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Create Password'),
      'password123',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Confirm Password'),
      'password123',
    );
    await tester.pumpAndSettle();

    // Register button is below the fold on smaller test viewports.
    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();

    final registerButtonFinder = find.byType(ElevatedButton).first;
    final registerButton = tester.widget<ElevatedButton>(registerButtonFinder);
    expect(registerButton.onPressed, isNotNull);

    await tester.ensureVisible(registerButtonFinder);
    await tester.tap(registerButtonFinder);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.login);
    expect(find.text('Login'), findsWidgets);
    verify(
      () => mockRegisterUseCase.call('new@mail.com', 'newuser', 'password123'),
    ).called(1);
  });

  testWidgets('Get profile flow renders profile data', (tester) async {
    await pumpTestApp(tester, initialRoute: AppRoutes.profile);

    expect(find.text('@tester'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    verify(() => mockGetUserProfileUseCase.call()).called(greaterThan(0));
  });

  testWidgets('Update profile flow saves and shows updated values', (
    tester,
  ) async {
    await pumpTestApp(tester, initialRoute: AppRoutes.profile);

    await tester.tap(find.byType(Image).first);
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Enter Name'),
      'Ferdian',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Add height'),
      '170',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Add weight'),
      '60',
    );

    final saveButton = find.widgetWithText(TextButton, 'Save & Update');
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('170 cm'), findsOneWidget);
    expect(find.text('60 kg'), findsOneWidget);

    final captured = verify(
      () => mockUpdateUserProfileUseCase.call(captureAny()),
    ).captured;
    expect(captured, isNotEmpty);

    final body = captured.last as Map<String, dynamic>;
    expect(body['name'], 'Ferdian');
    expect(body['height'], 170);
    expect(body['weight'], 60);
  });
}

User _mergeUser(User base, Map<String, dynamic> body) {
  final birthdayStr = body['birthday'] as String?;

  return User(
    username: base.username,
    email: base.email,
    name: body['name'] as String? ?? base.name,
    birthday: birthdayStr != null ? DateTime.parse(birthdayStr) : base.birthday,
    horoscope: base.horoscope,
    zodiac: base.zodiac,
    gender: base.gender,
    height: body['height'] as int? ?? base.height,
    weight: body['weight'] as int? ?? base.weight,
    interests: body['interests'] != null
        ? List<String>.from(body['interests'] as List)
        : base.interests,
  );
}
