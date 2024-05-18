import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/base/empty_page.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/models/cart_model.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:get/get.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    //getCartHistoryList() method fetches the list of items previously added to the cart
    //it processes this list to determine the number of times each item was ordered on different dates.
    var getCartHistoryList = Get.find<cartController>().getCartHistoryList().reversed.toList();
    //Ki testa3ml reversed trodou objet donc lezem traj3ou list to access it by index (still flou search for it more )
    var listCounter =0;
    //This function is responsible for formatting and displaying the date and time of each order in a readable format.

    Widget timeWidget (int index){
       var outputDate =DateTime.now().toString();
        //fi wosthom lezem traja3 widget
          if(index<getCartHistoryList.length){
            DateTime parseDate= DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
           outputDate = outputFormat.format(inputDate);
          }

          return BigText(outputDate,fontWeight: FontWeight.bold,size: 18,);
        }

    Map<String, int> cartItemsPerOrder = Map();
  //If the order date (time) is already a key in cartItemsPerOrder, it increments the count for that date.
    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
//Converting the Map to Lists
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }
//This list is used in the UI to display how many items were ordered on each date.
    List<int> itemsPerOrder = cartItemsPerOrderToList();
    

    return Scaffold(
      body: Column(
        children: [
          // Header 
        Container(
            height: Dimensions.heigth10*10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 45), // You can reduce this padding to move the entire row up.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start, // This aligns the children to the start of the column.
                  mainAxisSize: MainAxisSize.min, // This makes the column only as tall as its children need.
                  children: [
                    BigText("Historique", fontWeight: FontWeight.bold, color: Colors.white, size: 20),
                  ],
                ),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),



          //Body 
        GetBuilder<cartController>(builder: (_cartController){
           return _cartController.getCartHistoryList().length>0?Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.heigth20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child:MediaQuery.removePadding(
                removeTop: true,
                context: context, 
              child:  ListView(
                children: [
                  for (int i = 0; i < itemsPerOrder.length; i++)
                    Container(
                      height: Dimensions.heigth30*4,
                      margin: EdgeInsets.only(bottom: Dimensions.heigth20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          timeWidget(listCounter),
                          SizedBox(height: Dimensions.heigth15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(itemsPerOrder[i], (index) {
                                  if(listCounter<getCartHistoryList.length){
                                     listCounter++;
                                  }
                                  return index<=0?Container(
                                    height: Dimensions.heigth20*4,
                                    width: Dimensions.heigth20*4,
                                    margin: EdgeInsets.only(right: Dimensions.width10/2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                      color: AppColors.mainColor,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!),
                                        )
                                    ),
                                  ):Container();
                                }),
                              ),
                              Container(
                                height: Dimensions.heigth20*4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                  SmallText("Totale" ,  size: 13 , color: AppColors.titleColor),
                                  BigText(itemsPerOrder[i].toString()+" Produits", fontWeight: FontWeight.bold , color: AppColors.titleColor, size: 18),
                              
                                     GestureDetector(
                                      onTap: (){
                                            var orderTime=cartOrderTimeToList();
                                            Map<int , Cart> moreOrder ={};
                                            for(int j=0; j<getCartHistoryList.length; j++){
                                              if(getCartHistoryList[j].time==orderTime[i]){
                                                moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                Cart.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                 );
                                              
                                              }
                                              
                                            }
                                            Get.find<cartController>().setItems = moreOrder;
                                            Get.find<cartController>().addToCartList;
                                            Get.toNamed(RouteHelper.getCartPage());
                                      },
                                       child: Container(
                                          padding:EdgeInsets.symmetric(horizontal: Dimensions.width10,
                                          vertical: Dimensions.heigth10/2,
                                          ) ,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                            border: Border.all(width: 1 , color: AppColors.mainColor),                                    
                                          ),
                                       
                                          child:SmallText("Un autre",size: 11,color: AppColors.mainColor,),
                                        ),
                                     ),

                                    
                                  ]
                                ),
                              ),
                            ],
                          ),
                         
                       
                        ],
                      ),
                    ),
                ],
              ),
              ),
            ),
          ):Container(

            height: MediaQuery.of(context).size.height/1.5,
            child:const Center(
              child: NoDataPage(
              
              text: "Vous n'avez pas commander aucun produit pour le moment!",
              imgPath:"assets/images/emptyCard.jpg" ,),
            ));
        })
        ],
      ),
    );
  }
}