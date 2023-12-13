import 'package:data_pass_demo/utils/get_di.dart' as di;
import 'package:data_pass_demo/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:data_pass_demo/view/product_list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: FeatureDiscovery.withProvider(
          persistenceProvider: NoPersistenceProvider(),
          child: ProductListPage()),
      // initialRoute: Routes.homePage,
      // getPages: getPages,
    );
  }
}
