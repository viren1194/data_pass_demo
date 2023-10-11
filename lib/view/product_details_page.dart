import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product_model.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    final ProductModel? products = productController.currentProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text(products?.title ?? ''),
        actions: [
          IconButton(
              onPressed: () {
                productController.deleteProduct(products?.id ?? 0);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: products == null
          ? const Center(child: Text("Data not fount"))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(products?.id.toString() ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Image.network(
                  products?.images?.first.toString() ?? '',
                  height: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(products?.description ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Text(products?.price.toString() ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Text(
                    "category name == ${products?.category?.name.toString() ?? ''}"),
              ],
            ),
    );
  }
}
