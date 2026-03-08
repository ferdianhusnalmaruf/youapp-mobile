import 'package:get/get.dart';
import 'package:youapp/domain/usecases/get_token_usecase.dart';
import 'package:youapp/domain/usecases/login_usecase.dart';
import 'package:youapp/domain/usecases/register_usecase.dart';
import 'package:youapp/routes/app_routes.dart';

class AuthController extends GetxController {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GetTokenUseCase getTokenUseCase;

  AuthController(this.loginUseCase, this.registerUseCase, this.getTokenUseCase);

  var loading = false.obs;

  Future login(String email, String username, String password) async {
    loading.value = true;

    try {
      final result = await loginUseCase(email, username, password);

      if (result.token != null) {
        Get.offNamed(AppRoutes.profile);
      } else {
        final error = result.error;
        final message = result.message;

        if (message is List) {
          Get.snackbar(
            (error ?? 'Login Failed'),
            message.join(", "),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.onError,
          );
        } else if (message is String) {
          Get.snackbar(
            (error ?? 'Login Failed'),
            message,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.onError,
          );
        }
      }
    } finally {
      loading.value = false;
    }
  }

  Future register(String email, String username, String password) async {
    loading.value = true;

    try {
      final result = await registerUseCase(email, username, password);
      final message = result.message;

      if (message.toString().contains('created')) {
        Get.offNamed(AppRoutes.login);
        Get.snackbar(
          'Success',
          message,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Get.theme.colorScheme.onError,
        );
      } else {
        final error = result.error;

        if (message is List) {
          Get.snackbar(
            (error ?? 'Register Failed'),
            message.join(", "),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.onError,
          );
        } else if (message is String) {
          Get.snackbar(
            (error ?? 'Register Failed'),
            message,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Get.theme.colorScheme.onError,
          );
        }
      }
    } finally {
      loading.value = false;
    }
  }

  Future<String?> getToken() async {
    final result = await getTokenUseCase();
    return result;
  }
}
