import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:get/get.dart';

import '../controller/category_controller.dart';
import 'api_client.dart';

Future<void> init() async {
  final ApiClient apiClient = ApiClient();
  Get.lazyPut(() => apiClient);

  // Get.lazyPut(() => ApiClient());

  Get.lazyPut(() => ProductController(apiClient: Get.find()));
  Get.lazyPut(() => CategoryController(apiClient: Get.find()));
}
