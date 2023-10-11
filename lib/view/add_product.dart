import 'package:data_pass_demo/controller/category_controller.dart';
import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:data_pass_demo/model/body/product_body.dart';
import 'package:data_pass_demo/model/product_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProduct extends StatefulWidget {
  bool? isedit;

  AddProduct({super.key, this.isedit});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductController productController = Get.find();
  late ProductModel? product;
  bool isLoading = false;
  // List<String> country = ['usa', 'india', 'uk'];
  // String selectedCountry = 'usa';
  // late String selectedCategoryId;
  String categoryName = '';
  final categoryController = Get.find<CategoryController>();
  @override
  void initState() {
    product = productController.currentProduct;
    // selectedCategoryId = categoryController.categoryList.length.toString();
//  selectId = categoryController.categoryList.first.id?.toInt() ?? 4;
    super.initState();
    if (product != null) {
      productController.initializeProductData(
          isEdit: widget.isedit == true, product: product!);
    }
    Get.find<CategoryController>().getCategory();
  }

  @override
  void dispose() {
    super.dispose();
    productController.clearTextControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isedit == true ? "Update" : "Add"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<CategoryController>(builder: (categoryController) {
          // int index = categoryController.categoryList.indexWhere((element) => element.id == id);
          categoryName = categoryController.categoryList.first.name ?? '';
          print('categoryName ==>$categoryName');
          return ListView(
            children: [
              TextField(
                controller: productController.titleController,
                decoration: InputDecoration(
                  hintText: "Enter title",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.priceController,
                decoration: InputDecoration(
                  hintText: "Enter price",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.descriptionController,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                items: Get.find<CategoryController>().categoryList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value.name.toString(),
                    child: Text(value.name.toString()),
                  );
                }).toList(),
                value: categoryName,
                onChanged: (String? value) {
                  setState(() {
                    categoryName = value ?? '';
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              // DropdownButton<String>(
              //   items: Get.find<CategoryController>().categoryList.map((value) {
              //     return DropdownMenuItem<String>(
              //       value: value.id
              //           .toString(), // Use a unique identifier, such as the category id, as a string
              //       child: Text(value.id.toString()), // Display the category name
              //     );
              //   }).toList(),
              //   value:
              //       selectedCountry, // Make sure 'selectedCountry' matches one of the 'DropdownMenuItem' values
              //   onChanged: (String? value) {
              //     setState(() {
              //       selectedCountry =
              //           value ?? 'select category'; // Handle null value
              //     });
              //   },
              // ),
              // DropdownButton<String>(
              //   items: country.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   value: selectedCountry,
              //   onChanged: (String? newValue) {
              //     setState(() {
              //       selectedCountry = newValue!;
              //     });
              //   },
              // ),
              TextField(
                readOnly: widget.isedit == true ? true : false,
                controller: productController.categoryIdController,
                decoration: InputDecoration(
                  hintText: "Enter category Id",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.image1Controller,
                decoration: InputDecoration(
                  hintText: "Enter image 1 ",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: productController.image2Controller,
                decoration: InputDecoration(
                  hintText: "Enter image 2",
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  productController.addOrUpdateProduct(
                      isEdit: widget.isedit == true ? true : false,
                      product: product);
                },
                child: Text(widget.isedit == true ? "Update" : "Add"),
              )
            ],
          );
        }),
      ),
    );
  }
}
