import 'package:get/get.dart';
import 'package:youapp/presentation/bindings/auth_binding.dart';
import 'package:youapp/presentation/bindings/user_binding.dart';
import 'package:youapp/presentation/pages/interests_page.dart';
import 'package:youapp/presentation/pages/register_page.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/user_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => UserPage(),
      binding: UserBinding(),
    ),
    GetPage(
      name: AppRoutes.interests,
      page: () => InterestsPage(),
      binding: UserBinding(),
    ),
  ];
}
