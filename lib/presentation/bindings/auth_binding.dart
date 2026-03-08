import 'package:get/get.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/storage/token_storage.dart';
import 'package:youapp/data/datasources/auth_local_datasource.dart';
import 'package:youapp/data/datasources/auth_remote_datasource.dart';
import 'package:youapp/data/repositories/auth_repository_impl.dart';
import 'package:youapp/domain/repositories/auth_repository.dart';
import 'package:youapp/domain/usecases/get_token_usecase.dart';
import 'package:youapp/domain/usecases/login_usecase.dart';
import 'package:youapp/domain/usecases/register_usecase.dart';
import 'package:youapp/presentation/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    /// DataSource
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find<ApiClient>()),
    );
    Get.lazyPut<AuthLocalDatasource>(
      () => AuthLocalDatasourceImpl(Get.find<TokenStorage>()),
    );

    /// Repository
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        Get.find<AuthRemoteDataSource>(),
        Get.find<AuthLocalDatasource>(),
      ),
    );

    /// Usecase
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<RegisterUseCase>(
      () => RegisterUseCase(Get.find<AuthRepository>()),
    );
    Get.lazyPut<GetTokenUseCase>(
      () => GetTokenUseCase(Get.find<AuthRepository>()),
    );

    /// Controller
    Get.lazyPut<AuthController>(
      () => AuthController(
        Get.find<LoginUseCase>(),
        Get.find<RegisterUseCase>(),
        Get.find<GetTokenUseCase>(),
      ),
    );
  }
}
