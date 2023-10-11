import 'package:data_pass_demo/model/product_model.dart';
import 'package:data_pass_demo/utils/api_client.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';

class CategoryController extends GetxController implements GetxService {
  ApiClient apiClient;
  CategoryController({required this.apiClient});
  List<CategorytModel> categoryList = <CategorytModel>[];
  List<ProductModel> productList = <ProductModel>[];
  bool isLoading = false;

  // Create a map to store loaded products for each category
  Map<String, List<ProductModel>> categoryProductMap = {};

  Future<void> getCategory() async {
    isLoading = true;
    Response response =
        await apiClient.getData('https://api.escuelajs.co/api/v1/categories');
    categoryList = [];
    if (response.statusCode == 200) {
      (response.body as List).forEach((element) {
        CategorytModel categorytModel = CategorytModel.fromJson(element);
        categoryList.add(categorytModel);
      });
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  // Future<void> getCategoryWiseProduct(String id) async {
  //   isLoading = true;
  //   Response response = await apiClient
  //       .getData('https://api.escuelajs.co/api/v1/categories/${id}/products');
  //   productList = [];
  //   if (response.statusCode == 200) {
  //     (response.body as List).forEach((element) {
  //       ProductModel productModel = ProductModel.fromJson(element);
  //       productList.add(productModel);
  //     });
  //     isLoading = false;
  //     update();
  //   } else {
  //     isLoading = false;
  //     update();
  //   }
  // }

   Future<void> getCategoryWiseProduct(String id) async {
    isLoading = true;
    
    // Check if products for the category have already been loaded
    if (categoryProductMap.containsKey(id)) {
      productList = categoryProductMap[id]!;
      isLoading = false;
      update();
    } else {
      Response response = await apiClient
          .getData('https://api.escuelajs.co/api/v1/categories/$id/products');
      productList = [];
      if (response.statusCode == 200) {
        (response.body as List).forEach((element) {
          ProductModel productModel = ProductModel.fromJson(element);
          productList.add(productModel);
        });
        // Store the loaded products in the map
        categoryProductMap[id] = productList;
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    }
  }
}
