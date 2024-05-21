import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/Pages/card/cart_history.dart';
import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/Pages/splash/splash_page.dart';
import 'package:lastproject/base/empty_page.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/BigText.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:get/get.dart';


  class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.heigth20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>WelcomePage());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>CartHistory());
                  },
                  child: AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                )
              ],
            ),
          ),
          GetBuilder<cartController>(builder: (_cartController){
            return _cartController.getItems.length>0?  Positioned(
            top: Dimensions.heigth20 * 5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.heigth15),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<cartController>(
                  builder: (cartController) {
                    var _cartList = cartController.getItems;
                    return ListView.builder(
                      itemCount: _cartList.length,
                      itemBuilder: (_, index) {
                        return Container(
                          height: 100,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var popularIndex = Get.find<PopularController>().popularProductList.indexOf(_cartList[index].products!);
                                   if(popularIndex>=0){
                                    Get.toNamed(RouteHelper.getPopularBooks(popularIndex, "cartpage"));

                                   }else{
                                    var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].products!);
                                    if(recommendedIndex<0){
                                      Get.snackbar("Historique des produits", "Produit n'existe pas dans le historique!",
                                      backgroundColor:AppColors.mainColor , colorText: Colors.white);
                                    }
                                   }
                                },
                                child: Container(
                                  width: Dimensions.heigth20 * 5,
                                  height: Dimensions.heigth20 * 5,
                                  margin: EdgeInsets.only(bottom: Dimensions.heigth10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              Expanded(
                                child: Container(
                                  height: Dimensions.heigth20 * 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        cartController.getItems[index].name!,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      SmallText("Adult"),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            cartController.getItems[index].price.toString(),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: Dimensions.heigth10 / 2,
                                              bottom: Dimensions.heigth10 / 3,
                                              left: Dimensions.width10,
                                              right: Dimensions.width10,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(_cartList[index].products!, -1);
                                                   },
                                                  child: Icon(Icons.remove, color: AppColors.signColor),
                                                ),
                                                SizedBox(width: Dimensions.width10 / 2),
                                                BigText(_cartList[index].quantity.toString(), fontWeight: FontWeight.bold,), // Set the actual count from cartController
                                                SizedBox(width: Dimensions.width10 / 2),
                                                GestureDetector(
                                                  onTap: () {
                                                    cartController.addItem(_cartList[index].products!, 1);
                                                  },
                                                  child: Icon(Icons.add, color: AppColors.signColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ):NoDataPage(text: "Votre Carte est vide!",imgPath: "assets/images/emptyCard.jpg",);
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<cartController>(builder: (cartController) {
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
          child: cartController.getItems.length>0?Row(
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
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(cartController.totalAmount.toString(), fontWeight: FontWeight.w600),
                    SizedBox(width: Dimensions.width10 / 2),
                    
                  ],
                ),
              ),
        GestureDetector(
           onTap: (){
            _showConfirmationDialog(context, cartController);
          },
          child: Container(
            padding: EdgeInsets.only(
              top: Dimensions.heigth20,
              bottom: Dimensions.heigth20,
              left: Dimensions.width20,
              right: Dimensions.width20
            ),
            child: BigText("Commander", fontWeight: FontWeight.w700, color: Colors.white ,size: 13,),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: AppColors.mainColor,
            ),
          ),
        ),

            ],
          ):Container(),
        );
      }
      
    )
    );
  }

  void _showConfirmationDialog(BuildContext context, cartController cartController) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous passer cette commande?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();  // This closes the dialog
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              // Here, you could also handle the confirmation logic, e.g., finalizing the order
              
              Get.toNamed(RouteHelper.getAddressPage());
               // Close the dialog after handling the action
            },
            child: const Text('Confirmer'),
          ),
        ],
      );
    },
  );
}


}
