import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/auth_api.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/data/api/reposetory/card_repo.dart';
import 'package:lastproject/data/api/reposetory/recommended_product_repo.dart';
import 'package:lastproject/data/api/api_client.dart';
import 'package:lastproject/data/api/reposetory/popular_repo.dart';
import 'package:lastproject/data/api/reposetory/recommended_product_repo.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init()async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client 
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //repo
  Get.lazyPut(() => PopularRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommandedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));


  //controllers
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => PopularController(popularRepo: Get.find()));
  Get.lazyPut(() => cartController(cartRepo: Get.find()));


}