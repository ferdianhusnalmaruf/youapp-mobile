import 'package:get/get.dart';
import 'package:youapp/core/network/api_client.dart';
import 'package:youapp/core/storage/token_storage.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TokenStorage(), permanent: true);
    Get.put(ApiClient(Get.find<TokenStorage>()), permanent: true);
  }
}
