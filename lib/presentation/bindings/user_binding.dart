import 'package:get/get.dart';
import 'package:youapp/data/datasources/user_remote_datasource.dart';
import 'package:youapp/data/repositories/user_repository_impl.dart';
import 'package:youapp/domain/repositories/user_repository.dart';
import 'package:youapp/domain/usecases/get_user_profile_usecase.dart';
import 'package:youapp/domain/usecases/update_user_profile_usecase.dart';
import 'package:youapp/presentation/controller/interest_controller.dart';
import 'package:youapp/presentation/controller/update_about_user_controller.dart';
import 'package:youapp/presentation/controller/user_controller.dart';
import 'package:youapp/core/network/api_client.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    /// DataSource
    Get.lazyPut<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(Get.find<ApiClient>()),
    );

    /// Repository
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(Get.find<UserRemoteDataSource>()),
    );

    /// Usecase
    Get.lazyPut<GetUserProfileUseCase>(
      () => GetUserProfileUseCase(Get.find<UserRepository>()),
    );
    Get.lazyPut<UpdateUserProfileUseCase>(
      () => UpdateUserProfileUseCase(Get.find<UserRepository>()),
    );

    /// Controller
    Get.lazyPut<UserController>(
      () => UserController(
        Get.find<GetUserProfileUseCase>(),
        Get.find<UpdateUserProfileUseCase>(),
      ),
    );
    Get.lazyPut<InterestController>(
      () => InterestController(
        Get.find<GetUserProfileUseCase>(),
        Get.find<UpdateUserProfileUseCase>(),
      ),
    );
    Get.lazyPut<UpdateAboutUserController>(() => UpdateAboutUserController());
  }
}
