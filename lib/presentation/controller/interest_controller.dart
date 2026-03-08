import 'package:get/get.dart';
import 'package:youapp/domain/entities/user_response.dart';
import 'package:youapp/domain/usecases/get_user_profile_usecase.dart';
import 'package:youapp/domain/usecases/update_user_profile_usecase.dart';

class InterestController extends GetxController {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  InterestController(this.getUserProfileUseCase, this.updateUserProfileUseCase);

  final Rx<User> user = User().obs;

  var loading = false.obs;

  /// interests state
  final RxList<String> interests = <String>[].obs;

  Future getUserProfile() async {
    loading.value = true;

    try {
      final response = await getUserProfileUseCase();
      user.value = response.data ?? User();

      /// sync interests
      interests.assignAll(user.value.interests);
    } finally {
      loading.value = false;
    }
  }

  void addInterest(String value) {
    if (value.trim().isEmpty) return;

    if (!interests.contains(value.trim())) {
      interests.add(value.trim());
    }
  }

  void removeInterest(String tag) {
    interests.remove(tag);
  }

  Future submitInterests() async {
    loading.value = true;

    try {
      final body = {"interests": interests};

      final response = await updateUserProfileUseCase(body);

      user.value = response.data ?? User();

      Get.snackbar(
        "Success",
        "Interests updated",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loading.value = false;
    }
  }
}
