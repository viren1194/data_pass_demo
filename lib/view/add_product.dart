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
  late ProductModel product;
  bool isLoading = false;

  final categoryController = Get.find<CategoryController>();

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {
      product = Get.arguments;
    } else {
      product = ProductModel();
    }

    productController.initializeProductData(
        isEdit: widget.isedit == true, product: product);
    Get.find<CategoryController>().getCategory();
  }

  @override
  void dispose() {
    super.dispose();
    productController.clearTextControllers();
  }

  @override
  Widget build(BuildContext context) {
    bool areTextFieldsFilled() {
      return productController.titleController.text.isNotEmpty ||
          productController.priceController.text.isNotEmpty ||
          productController.descriptionController.text.isNotEmpty ||
          productController.categoryIdController.text.isNotEmpty ||
          productController.image1Controller.text.isNotEmpty ||
          productController.image2Controller.text.isNotEmpty;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isedit == true ? "Update" : "Add"),
        leading: IconButton(
            onPressed: () {
              print(areTextFieldsFilled());
              // if textfield are filled then click on back ,then show dialog other wise back even should call here
              if (areTextFieldsFilled()) {
                Get.defaultDialog(
                    content: Column(
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text("yes")),
                    ElevatedButton(onPressed: () {}, child: Text("no"))
                  ],
                ));
              }else{
                Get.back();
              }
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder<CategoryController>(builder: (categoryController) {
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
