
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product.dart';


class SingleProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          // product name
          Text(
            "Name: ${product.name}",
            style: const TextStyle(fontSize: 30, color: Colors.purple),
          ),

          // product price
          Text(
            "Price: ${product.price}",
            style: const TextStyle(fontSize: 20, color: Colors.red),
          ),

          // product description
          Text("Description ${product.description}"),
        ]),
      ),
    );
  }
}
