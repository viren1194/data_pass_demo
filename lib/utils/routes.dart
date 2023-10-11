import 'package:data_pass_demo/view/home_page.dart';
import 'package:data_pass_demo/view/single_product_page.dart';
import 'package:get/get.dart';

class Routes {
  static String homePage = '/homePage';
  static String singleProductPage = '/singleProductPage';
}

final getPages = [
  GetPage(
    name: Routes.homePage,
    page: () => const HomePage(),
  ),
  GetPage(
    name: Routes.singleProductPage,
    page: () =>  SingleProductScreen(),
  ),
];
