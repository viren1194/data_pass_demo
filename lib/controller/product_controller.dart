import 'dart:convert';

import 'package:data_pass_demo/model/body/product_body.dart';
import 'package:data_pass_demo/utils/api_client.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductController extends GetxController implements GetxService {
  ApiClient apiClient;
  ProductController({required this.apiClient});

  List<ProductModel> productList = <ProductModel>[];
  ProductModel? currentProduct;
  bool isLoading = false;
  bool dataNotFound = false;

  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryIdController = TextEditingController();
  TextEditingController image1Controller = TextEditingController();
  TextEditingController image2Controller = TextEditingController();
  List<String> images = [];

  Future<void> getProduct() async {
    isLoading = true;
    Response response =
        await apiClient.getData('https://api.escuelajs.co/api/v1/products');

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
      }

      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  void setCurrentData({required ProductModel productModel}) {
    currentProduct = productModel;
  }

  Future<void> filterProductsByTitle(String title) async {
    dataNotFound = false;
    isLoading = true;
    // update();

    // Construct the URL with the title query parameter
    String apiUrl = 'https://api.escuelajs.co/api/v1/products?title=$title';

    // Make the API request without query parameters
    Response response = await apiClient.getData(apiUrl);

    if (response.statusCode == 200) {
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        productList.clear(); // Clear the existing list before adding new items
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        update();
      } else {
        dataNotFound = true;
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
  }

  Future<void> addProduct({required ProductBody productBody}) async {
    Map<String, dynamic> body = jsonDecode(
      jsonEncode(
        productBody.toJson(),
      ),
    );

    Response response = await apiClient
        .postData('https://api.escuelajs.co/api/v1/products/', body: body);

    if (response.statusCode == 201) {
      print("data added");
    } else {
      print("not added");
    }
    update();
  }

  Future<void> deleteProduct(int id) async {
    Response response = await apiClient
        .deleteData('https://api.escuelajs.co/api/v1/products/$id');

    if (response.statusCode == 200) {
      productList.removeWhere((element) => element.id == id);

      print("deleted");
      update();
    } else {
      print("not delete");
      update();
    }
    update();
  }

  Future<void> updateProduct(
      {required String id, required ProductBody productBody}) async {
    Map<String, dynamic> body = productBody.toJson();

    Response response = await apiClient.putData(
        'https://api.escuelajs.co/api/v1/products/$id', body);

    if (response.statusCode == 200) {
      print("Data updated successfully.");
    } else {
      print("Failed to update data.");
    }
    update();
  }

  void initializeProductData(
      {required bool isEdit, required ProductModel product}) {
    if (isEdit) {
      titleController.text = product.title ?? '';
      priceController.text = product.price?.toString() ?? '';
      descriptionController.text = product.description ?? '';
      categoryIdController.text = product.category?.id?.toString() ?? '';
      image1Controller.text = product.images?[0] ?? '';
      image2Controller.text = product.images?[1] ?? '';
    }
  }

  void addOrUpdateProduct({required bool isEdit, ProductModel? product}) {
    ProductBody productBody = ProductBody(
      title: titleController.text,
      price: int.tryParse(priceController.text),
      description: descriptionController.text,
      categoryId: int.tryParse(categoryIdController.text),
      images: [image1Controller.text, image2Controller.text],
    );

    if (isEdit) {
      updateProduct(
        id: product?.id.toString() ?? '',
        productBody: productBody,
      );

      print('isEdit == id == ${product?.id.toString()}');
    } else {
      addProduct(productBody: productBody);

      print('isEdit = false');
    }
  }

  void clearTextControllers() {
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    categoryIdController.clear();
    image1Controller.clear();
    image2Controller.clear();
  }
}
