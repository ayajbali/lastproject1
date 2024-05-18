import 'dart:convert';

import 'package:lastproject/models/cart_model.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart=[];
  List<String> cartHistory=[]; 


  void addToCartList(List<Cart> cartList){
    //sharedPreferences.remove(AppConstants.CART_LIST);
    //sharedPreferences.remove(AppConstants.CART_History_LIST);

     var time = DateTime.now().toString();
    cart=[];
    /*convert objects to string */ 
    cartList.forEach((element) {

      element.time=time;

      return  cart.add(jsonEncode(element));
       });

    sharedPreferences.setStringList(AppConstants.CART_LIST,cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  
  }

  List<Cart> getCartList() {
    
  List<String> carts = [];
  if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
    carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
  }
  List<Cart> cartList = carts.map((string) => Cart.fromJson(jsonDecode(string))).toList();
  return cartList;
}
  

  List<Cart> getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_History_LIST)){
       cartHistory=[];
       cartHistory = sharedPreferences.getStringList(AppConstants.CART_History_LIST)!;
    }
     List<Cart> cartListHistory=[];

     cartHistory.forEach((element) =>cartListHistory.add(Cart.fromJson(jsonDecode(element))));
    return cartListHistory;
  }


   void addToCartHistoryList(List<Cart> getItems){
    // te5ou les info ml global cart 
    if(sharedPreferences.containsKey(AppConstants.CART_History_LIST)){
      cartHistory=sharedPreferences.getStringList(AppConstants.CART_History_LIST)!;
    }
    for(int i=0 ; i<cart.length ; i++){
      print ("history list" + cart[i]);
       cartHistory.add(cart[i]);
  
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_History_LIST, cartHistory);

    print("the length is "+getCartHistoryList().length.toString());

    for(int j=0; j<getCartHistoryList().length ; j++){
      print("the time for the order is "+getCartHistoryList()[j].time.toString());
    }
    
    print("The lenght of history is "+ getCartHistoryList().length.toString());
   }

   void removeCart(){
      cart=[];
      sharedPreferences.remove(AppConstants.CART_LIST);
   }
}