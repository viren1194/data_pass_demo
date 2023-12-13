import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobleController extends GetxController {
  String feature1 = "feature1",
      feature2 = "feature2",
      feature3 = "feature3",
      feature4 = "feature4";

  // var isShow = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // isShow++;
  }

  bool isFeatureShown(String featureId) {
    SharedPreferences prefs = Get.find();
    return prefs.getBool(featureId) ?? false;
  }

  void markFeatureAsShown(String featureId) async {
    SharedPreferences prefs = Get.find();
    await prefs.setBool(featureId, true);
  }
}
