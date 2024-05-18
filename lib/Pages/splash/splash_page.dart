import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/demesion.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller ; 
  Future <void> _loadResource() async{
    await  Get. find<PopularController>().getPopularProductList();
    await  Get. find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState(){
    super.initState();
    _loadResource();
    controller =  AnimationController(
      vsync: this ,
       duration: const Duration(seconds: 2)
       )..forward();
       
    animation =  CurvedAnimation(parent: controller,
     curve: Curves.linear);
     Timer(
      const Duration (seconds:3 ),
      ()=> Get.offNamed(RouteHelper.getinitial()),

      );
    }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Column(
              children: [
                Image.asset("images/AppLogo.png", 
                width: Dimensions.splashImg),
      
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}