import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/widgets/bigtext.dart';

void showSnackBar(String message , {bool isError=true , String title ="Error"}){
Get.snackbar(title,
 message,
 titleText: BigText(title, fontWeight: FontWeight.bold,color: Colors.white,),
 messageText: Text(message, style: const TextStyle(
  color: Colors.white,
 ),
 ),
 colorText:Colors.white,
 snackPosition: SnackPosition.TOP,
 backgroundColor: Colors.red,

);
}