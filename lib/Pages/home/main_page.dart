import 'package:flutter/material.dart';
import 'package:lastproject/Pages/home/Home_body.dart';
import 'package:lastproject/utils/colors.dart';  
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/bigtext.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.heigth45, bottom: Dimensions.heigth15),
            padding: EdgeInsets.only(left: Dimensions.width20, right:Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText("Tunisie", color: AppColors.mainColor, fontWeight: FontWeight.bold),

                    Row(
                      children: [
                      SmallText("city", color:Colors.black54),
                      Icon(Icons.arrow_drop_down_rounded),

                    ],)
                  ],
                ),
                Container(
                  width: Dimensions.heigth45,
                  height: Dimensions.heigth45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    color: AppColors.mainColor,
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
            child: HomeBody(),  
            )
            )
         
        ],
      ),
    );
  }
}
