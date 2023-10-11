import 'package:data_pass_demo/view/categorywise_product.dart';
import 'package:data_pass_demo/view/product_list_page.dart';
import 'package:data_pass_demo/view/single_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../utils/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Get.to(const ProductListPage());
            },
            child: const Text("Get all product list"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(const CategorywiseProduct());
            },
            child: const Text("Get categorywise product list"),
          ),
        ],
      ),
      //  ListView.builder(
      //   itemCount: dummyProducts.length,
      //   itemBuilder: (context, index) {
      //     final product = Product.fromJson(dummyProducts[index]);
      //     final productName = product.name;
      //     return Card(
      //       child: ListTile(
      //         onTap: () {
      //           Get.to(SingleProductScreen(), arguments: product);
      //         },
      //         title: Text(productName ?? ''),
      //       ),
      //     );
      //   },
      // )
    );
  }
}
