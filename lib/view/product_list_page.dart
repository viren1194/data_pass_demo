import 'package:data_pass_demo/controller/globle_controller.dart';
import 'package:data_pass_demo/controller/product_controller.dart';
import 'package:data_pass_demo/view/add_product.dart';
import 'package:data_pass_demo/view/custom_drawer.dart';

import 'package:data_pass_demo/view/product_details_page.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  ProductController productController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final gController = Get.put(GlobleController());

  @override
  void initState() {
    super.initState();
    productController.getProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productController.searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FeatureDiscovery.discoverFeatures(
    //     context,
    //     <String>{
    //       gController.feature1,
    //       gController.feature2,
    //       gController.feature3,
    //       gController.feature4,
    //     },
    //   );
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (gController.isFeatureShown(gController.feature1)) {
        FeatureDiscovery.discoverFeatures(
          context,
          <String>{gController.feature1},
        );
        gController.markFeatureAsShown(gController.feature1);
      }

      if (!gController.isFeatureShown(gController.feature2)) {
        FeatureDiscovery.discoverFeatures(
          context,
          <String>{gController.feature2},
        );
        gController.markFeatureAsShown(gController.feature2);
      }

      if (!gController.isFeatureShown(gController.feature3)) {
        FeatureDiscovery.discoverFeatures(
          context,
          <String>{gController.feature3},
        );
        gController.markFeatureAsShown(gController.feature3);
      }

      if (!gController.isFeatureShown(gController.feature4)) {
        FeatureDiscovery.discoverFeatures(
          context,
          <String>{gController.feature4},
        );
        gController.markFeatureAsShown(gController.feature4);
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("data"),
        leading: DescribedFeatureOverlay(
          featureId:
              gController.feature1, // Unique id that identifies this overlay.
          tapTarget: const Icon(Icons
              .add), // The widget that will be displayed as the tap target.
          title: Text('Add item'),
          description: Text('Tap the plus icon to add an item to your list.'),
          backgroundColor: Theme.of(context).primaryColor,
          targetColor: Colors.white,
          textColor: Colors.white,
          child: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.add)),
        ),
      ),
      drawer: const CustomDrawer(),
      floatingActionButton: DescribedFeatureOverlay(
        featureId:
            gController.feature2, // Unique id that identifies this overlay.
        tapTarget: const Icon(
            Icons.add), // The widget that will be displayed as the tap target.
        title: Text('Add item'),
        description: Text('Tap the plus icon to add an item to your list.'),
        backgroundColor: Theme.of(context).primaryColor,
        targetColor: Colors.white,
        textColor: Colors.white,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(AddProduct());
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (productController) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: productController.searchController,
                  onChanged: (value) async {
                    await productController.filterProductsByTitle(value);
                  },
                ),
                productController.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : productController.dataNotFound
                        ? const Center(
                            child: Text("No data found"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productController.productList.length,
                            itemBuilder: (context, index) {
                              final product =
                                  productController.productList[index];
                              return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      ProductDetailPage(),
                                      arguments: product,
                                    );
                                  },
                                  child: Card(
                                    child: ListTile(
                                        title: Text(product.title ?? ''),
                                        trailing: PopupMenuButton(
                                          onSelected: (value) {
                                            if (value == '/edit') {
                                              // productController.setCurrentData(
                                              //     productModel: product);
                                              Get.to(
                                                  AddProduct(
                                                    isedit: true,
                                                  ),
                                                  arguments: product);
                                            } else {
                                              productController.deleteProduct(
                                                  product.id ?? 0);
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
                                        )),
                                  ));
                            },
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
