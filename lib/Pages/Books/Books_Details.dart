import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/Pages/card/card_page.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';  
import 'package:lastproject/models/products_model.dart';  
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/BigText.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/app_column.dart';
import 'package:lastproject/widgets/expandable_Text.dart';
import 'package:lastproject/widgets/icon_text.dart';

class Books_Details extends StatelessWidget {
  final int pageId;
  final String page;
  const Books_Details({super.key, required this.pageId , required this.page});

  @override
  Widget build(BuildContext context) {
     var product= Get.find<PopularController> ().popularProductList[pageId];
     Get.find<PopularController>().initProduct(product,Get.find<cartController>());
     late cartController _cart;
     
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //backgroun image 
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularBookImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.img ?? "assets/images/default.jpg"),
                )
              ),
            ),
          ),
         
         //icon Widgets 
          Positioned(
            top: Dimensions.heigth45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if(page == "cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getinitial());
                    }
                  },
                  child: AppIcon(icon: Icons.arrow_back_ios),
                ),
                 
                 GetBuilder<PopularController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if (controller.totalItems>=0)
                       Get.to(() => CartPage());
                    },
                    
                    
                    child: Stack(
                      children:[
                      AppIcon(icon: Icons.shopping_bag_outlined),
                    
                      controller.totalItems>=1?
                       Positioned(
                        right: 0,
                        top: 0,
                       
                           child: AppIcon(icon: Icons.circle, 
                           size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,),
                        
                       ):
                      
                        Container(),
                    
                      controller.totalItems>=1?
                       Positioned(
                        right: 6,
                        top: 0,
                         child:BigText(Get.find<PopularController>().totalItems.toString(), fontWeight: FontWeight.normal , size:12 ,color:Colors.white) ,
                       ):
                      
                        Container()
                      ]
                    ),
                  );
                 })

              ],
            ),
            
          ),
          

          //introduction
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularBookImgSize,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.heigth20,
                right: Dimensions.width20,
                top: Dimensions.heigth20
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20)
                ),
                color: Colors.white,
              ),
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.name!,),
          
                  SizedBox(height: Dimensions.heigth20),
                  BigText("Introduction", fontWeight: FontWeight.w500),
                  SizedBox(height: Dimensions.heigth10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(text: product.description ?? "No description available."),
                    ),
                  ),
                ],
              ),
                

               )
            ),
        
       ], 
      ),
        
      
      bottomNavigationBar: GetBuilder<PopularController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomheightBar,
          padding: EdgeInsets.only(
            top: Dimensions.heigth30,
            bottom: Dimensions.heigth30,
            left: Dimensions.width20,
            right: Dimensions.width20
          ),
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.heigth20,
                  bottom: Dimensions.heigth20,
                  left: Dimensions.width20,
                  right: Dimensions.width20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor),
                    ),
                    SizedBox(width: Dimensions.width10 / 2),

                    BigText(popularProduct.inCartItems.toString(), fontWeight: FontWeight.w500),
                    SizedBox(width: Dimensions.width10 / 2),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                    popularProduct.addItem(product);
                  },
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.heigth20,
                    bottom: Dimensions.heigth20,
                    left: Dimensions.width20,
                    right: Dimensions.width20
                  ),
                      
                    
                    child: BigText("${product.price!} / Add to cart", fontWeight: FontWeight.w500, color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
        );
      }
      ),
    );
  }
}
