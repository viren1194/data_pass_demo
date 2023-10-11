import 'package:data_pass_demo/controller/category_controller.dart';
import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:data_pass_demo/view/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorywiseProduct extends StatefulWidget {
  const CategorywiseProduct({super.key});

  @override
  State<CategorywiseProduct> createState() => _CategorywiseProductState();
}

class _CategorywiseProductState extends State<CategorywiseProduct> {
  CategoryController categoryController = Get.find();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // categoryController.getCategory();
    // categoryController.getCategoryWiseProduct(2.toString());
    categoryController.getCategory().then((_) {
      if (categoryController.categoryList.isNotEmpty) {
        // Select the first category and load its products
        currentIndex = 0;
        final selectedCategory = categoryController.categoryList[currentIndex];
        categoryController
            .getCategoryWiseProduct(selectedCategory.id.toString());
      }
    });
  }

  bool categoryProductsLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<CategoryController>(builder: (categoryController) {
        return Column(
          children: [
            SizedBox(
              height: 80,
              width: double.infinity,
              child: categoryController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryController.categoryList.length,
                      itemBuilder: (context, index) {
                        var category = categoryController.categoryList[index];

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                              categoryController.getCategoryWiseProduct(
                                  category.id.toString());
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            constraints: const BoxConstraints(minWidth: 100),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: currentIndex == index
                                    ? Colors.green
                                    : Colors.red),
                            child: Text(category.name ?? ''),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: categoryController.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: categoryController.productList.length,
                      itemBuilder: (context, index) {
                        var product = categoryController.productList[index];
                        return GestureDetector(
                          onTap: () {
                            Get.find<ProductController>()
                                .setCurrentData(productModel: product);
                            Get.to(ProductDetailPage());
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 50,
                            width: double.infinity,
                            color: Colors.yellow,
                            child: Text(product.title ?? ''),
                          ),
                        );
                      },
                    ),
            )
          ],
        );
      }),
    );
  }
}
