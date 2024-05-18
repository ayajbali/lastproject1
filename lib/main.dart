import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lastproject/Pages/Auth/SignUp.dart';
import 'package:lastproject/Pages/Auth/Sing_Up_Page.dart';
import 'package:lastproject/Pages/Auth/sign_in_page.dart';
import 'package:lastproject/Pages/Books/Books_Details.dart';
import 'package:lastproject/Pages/Books/recommanded_book_details.dart';
import 'package:lastproject/Pages/add_address_page.dart';
import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/Pages/splash/splash_page.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/data/api/Controllers/user_controller.dart';
import 'package:lastproject/routes/route_helper.dart';
import'helper/dependencies.dart' as dep;
Future <void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
  Get.put(AuthAPI());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) :super (key: key);

   @override
  Widget build(BuildContext context) {
   Get.find<cartController>().getCartData();
  return  GetBuilder<PopularController>(builder:(_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          
  debugShowCheckedModeBanner: false,
  initialRoute: RouteHelper.getSplashPage(),
  getPages: RouteHelper.routes,
);

      });
   });
  
  }
}