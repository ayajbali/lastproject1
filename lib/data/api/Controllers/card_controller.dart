import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/data/api/reposetory/card_repo.dart';
import 'package:lastproject/models/cart_model.dart';
import 'package:lastproject/models/products_model.dart';
import 'package:lastproject/utils/colors.dart';

class cartController extends GetxController{
  final CartRepo cartRepo;
  cartController ({required this.cartRepo});
  Map<int , Cart> _items={};

  Map<int, Cart> get items=> _items;
  List<Cart> storageItems=[];
  void addItem(Products products, int quantity){
     var totalQuantity=0;

    if(_items.containsKey(products.id!)){
       _items.update(products.id!, (value) {
        
        totalQuantity=value.quantity!+quantity;

    return Cart(
    id: value.id,
    name:value.name,
     price:value.price,
      img:value.img,
     quantity: value.quantity!+quantity,
       isExist:true,
       time:DateTime.now().toString(),
        products: products,
    );});

    if(totalQuantity<=0){
      _items.remove(products.id);
    }
        
    }else{
      if(quantity>0){
        _items.putIfAbsent(products.id!, () {
       return Cart(
    id: products.id,
    name:products.name,
     price:products.price,
      img:products.img,
     quantity: quantity,
       isExist:true,
       time:DateTime.now().toString(),
       products: products,
    );});
      }else{
         Get.snackbar(
        "Item count",
        "Vous devez ajouter au minimum un produit!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(Products product ){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }
  
  int getQuantity(Products product ){
    var quantity=0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key==product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }
  
  int get totalItems{
    var totalQuantity=0;
    _items.forEach((key, value) {
     totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<Cart> get getItems{
    return _items.entries.map((e) {
    return e.value;
    } ).toList();
  }
 
 int get totalAmount {
  double total = 0.0;
  _items.forEach((key, value) {
    total += value.quantity! * double.parse(value.price!); // Ensure the price is parsed as double
  });
  return total.toInt(); // Convert the total from double to int before returning
}


  List<Cart> getCartData(){
     setCart = cartRepo.getCartList();
      return storageItems;
  }
 // I have to accept something with set methode not like get you have to give something 
  set setCart(List<Cart> items){
    storageItems=items;
     //print("length of cart items" + storageItems.length.toString());
    for(int i=0; i<storageItems.length;i++){
      _items.putIfAbsent(storageItems[i].products!.id!, () => storageItems[i]);
    }
  }

  void addToHistory(){
    cartRepo.addToCartHistoryList(getItems);
    clear();

  }

  void clear(){
    _items={};
    update();
  }
  
  List<Cart> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
 
  set setItems(Map<int, Cart> setItems){
    _items = {};
    _items=setItems;
  }

  void addToCartList(){
    cartRepo.addToCartHistoryList(getItems);
    update();
  }
}