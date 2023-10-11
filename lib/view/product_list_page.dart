import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:data_pass_demo/view/add_product.dart';

import 'package:data_pass_demo/view/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductController productController = Get.find();
  @override
  void initState() {
    super.initState();
    productController.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      body: GetBuilder<ProductController>(
        builder: (productController) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: productController.searchController,
                    decoration: InputDecoration(
                      hintText: "search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      // Call the new filterProductsByTitle function with the query
                      productController.filterProductsByTitle(value);
                    },
                  ),
                ),
                productController.dataNotFound
                    ? const Center(
                        child: Text("No data found"),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: productController.productList.length,
                        itemBuilder: (context, index) {
                          final product = productController.productList[index];
                          return GestureDetector(
                              onTap: () {
                                Get.to(ProductDetailPage());
                                productController.setCurrentData(
                                    productModel: product);
                              },
                              child: Card(
                                child: ListTile(
                                    title: Text(product.title ?? ''),
                                    trailing: PopupMenuButton(
                                      onSelected: (value) {
                                        if (value == '/edit') {
                                          productController.setCurrentData(
                                              productModel: product);
                                          Get.to(AddProduct(
                                            isedit: true,
                                          ));
                                        } else {
                                          productController
                                              .deleteProduct(product.id ?? 0);
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                            value: '/edit',
                                            child: Text("Edit"),
                                          ),
                                          const PopupMenuItem(
                                            value: '/delete',
                                            child: Text("Delete"),
                                          ),
                                        ];
                                      },
                                    )
                                    // IconButton(
                                    //   onPressed: () async {
                                    //     productController.setCurrentData(
                                    //         productModel: product);
                                    //     Get.to(AddProduct(
                                    //       isedit: true,
                                    //     ));
                                    //   },
                                    //   icon: const Icon(Icons.edit),
                                    // ),
                                    ),
                              ));
                        },
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
