import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/reposetory/popular_repo.dart';
import 'package:lastproject/models/cart_model.dart';
import 'package:lastproject/models/products_model.dart';
import 'package:lastproject/utils/colors.dart';

class PopularController extends GetxController {
  final PopularRepo popularRepo;

  PopularController({required this.popularRepo});
    List<Products> _popularProductList = []; 
    List<Products> get popularProductList => _popularProductList;
    late cartController _cart; 
    List<Products> searchResults = [];
  bool isSearchMode = false;  
   List<Products> productsList = [];
     
      
    bool _isLoaded=false;
    bool get isLoaded=> _isLoaded;
    int _quantity = 0;
    int get quantity => _quantity;
    int _inCartItems=0;
    int get inCartItems=>_inCartItems+_quantity;

  @override
  void onInit() {
    getPopularProductList();
    super.onInit();
  }
  
  Future<void> getPopularProductList() async {
  Response response = await popularRepo.getPopularProductList();
  if (response.statusCode == 200) {
    List<dynamic> responseData = response.body;
    _popularProductList.clear();  // Clear existing data

    for (var productData in responseData) {
      _popularProductList.add(Products.fromJson(productData));
    }

    print("Products loaded successfully. Number of products fetched: ${_popularProductList.length}");
    update();
  } else {
    Get.snackbar(
      "Error",
      "Failed to fetch popular list: ${response.statusText}",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
    );
  }
}


  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
     _isLoaded=true;
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems+ quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You cannot decrease anymore!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = _inCartItems;
        return _quantity;

      }
      return 0;
    } else if ((_inCartItems+ quantity)> 100) {
      return 100;
    } else {
      return quantity;
    }
  }

   void initProduct(Products product , cartController cart ) {
    _quantity=0;
    _inCartItems=0;
    _cart=cart;
    var exist = false;
    exist =_cart.existInCart(product);
     //if exist 
    //get from storage 
    //print(exist.toString());
    if (exist){
      _inCartItems=_cart.getQuantity(product);
    }
  }
   
   void addItem(Products products){

      _cart.addItem(products, _quantity);
      _quantity=0;
      _inCartItems=_cart.getQuantity(products);



      _cart.items.forEach((key, value) {
       print("the id is "+value.id.toString()+"the quantity is "+value.quantity.toString()); 
      });
      update();
   }

  
  
  
  int get totalItems{
  return _cart.totalItems;
}

List<Cart> get getItems{
  return _cart.getItems;
}


 void searchProduct(String query) {
    if (query.isEmpty) {
      searchResults = productsList;
      isSearchMode = false;  // Set to false when the query is empty
    } else {
      searchResults = productsList.where((product) {
        return product.name!.toLowerCase().contains(query.toLowerCase());
      }).toList();
      isSearchMode = true;  // Set to true when actively searching
    }
    update();  // Notify listeners to rebuild the UI
  }
}



