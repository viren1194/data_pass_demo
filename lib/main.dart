import 'package:data_pass_demo/utils/get_di.dart' as di;
import 'package:data_pass_demo/utils/routes.dart';
import 'package:data_pass_demo/view/categorywise_product.dart';
import 'package:data_pass_demo/view/first_page.dart';
import 'package:data_pass_demo/view/home_page.dart';
import 'package:data_pass_demo/view/product_list_page.dart';
import 'package:data_pass_demo/view/single_product_page.dart';
import 'package:data_pass_demo/view/third_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
      home: ThirdPage(),
      // initialRoute: Routes.homePage,
      // getPages: getPages,
    );
  }
}
