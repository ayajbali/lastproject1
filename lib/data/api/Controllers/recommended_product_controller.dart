import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/data/api/reposetory/recommended_product_repo.dart';
import 'package:lastproject/models/products_model.dart';
import 'package:lastproject/utils/colors.dart';

class RecommendedProductController extends GetxController {
  final RecommandedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

    List<Products> _recommendedProductList = []; 
    List<Products> get recommendedProductList => _recommendedProductList;

 bool _isLoaded=false;
 bool get isLoaded=> _isLoaded;
   



  @override
  void onInit() {
    getRecommendedProductList();
    super.onInit();
  }
  
  Future<void> getRecommendedProductList() async {
  Response response = await recommendedProductRepo.getRecommandedProductList();
  if (response.statusCode == 200) {
    List<dynamic> responseData = response.body;
    _recommendedProductList.clear();  
    for (var productData in responseData) {
      _recommendedProductList.add(Products.fromJson(productData));
    } 
    print("recommended Products loaded successfully. Number of products fetched: ${_recommendedProductList.length}");
     _isLoaded=true;
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
}