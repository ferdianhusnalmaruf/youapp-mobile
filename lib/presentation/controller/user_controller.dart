import 'package:get/get.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/usecases/get_user_profile_usecase.dart';
import 'package:youapp/domain/usecases/update_user_profile_usecase.dart';

class UserController extends GetxController {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final Rx<User> user = User().obs;

  UserController(this.getUserProfileUseCase, this.updateUserProfileUseCase);

  var loading = false.obs;

  Future getUserProfile() async {
    loading.value = true;

    try {
      final response = await getUserProfileUseCase();
      user.value = response.data ?? User();
    } finally {
      loading.value = false;
    }
  }

  Future updateProfile(Map<String, dynamic> body) async {
    loading.value = true;

    try {
      final response = await updateUserProfileUseCase(body);
      user.value = response.data ?? User();
    } finally {
      loading.value = false;
    }
  }
}
