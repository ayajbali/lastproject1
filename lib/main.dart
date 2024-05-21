import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lastproject/Pages/Auth/SignUpPage.dart';
 import 'package:lastproject/Pages/Books/Books_Details.dart';
import 'package:lastproject/Pages/Books/recommanded_book_details.dart';
 import 'package:lastproject/Pages/add_address_page.dart';
import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/Pages/splash/splash_page.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/auth_api.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/data/api/reposetory/card_repo.dart';
 import 'package:lastproject/routes/route_helper.dart';
import 'package:provider/provider.dart';
import'helper/dependencies.dart' as dep;


/*void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthAPI(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to authentication status changes
    final authStatus = context.watch<AuthAPI>().status;
    print('Authentication Status Changed to: $authStatus');

     return GetMaterialApp(
      title: 'Appwrite Auth Demo',
      debugShowCheckedModeBanner: false,
      home: authStatus == AuthStatus.authenticated ? WelcomePage() : SignUpPageFirst(),
       initialRoute: authStatus == AuthStatus.authenticated ? '/welcome' : '/signup',
       
    );
  }
}*/


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

/*void main() {
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
      create: ((context) => AuthAPI()), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<AuthAPI>().status;
    print('TOP CHANGE Value changed to: $value!');

    return MaterialApp(
        title: 'Appwrite Auth Demo',
        debugShowCheckedModeBanner: false,
        home: SignUpPageFirst(),
    );
  }
}*/