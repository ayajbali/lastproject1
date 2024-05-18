import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lastproject/Pages/Auth/Sing_Up_Page.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/app_textfield.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:get/get.dart';
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

 @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),
            Center(
              child: Container(
                height: Dimensions.screenHeight*0.25,  
                width: 150,  
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),  
                  child: Image.asset("assets/images/AppLogo.png", fit: BoxFit.cover),
                ),
              ),
       
            ),
            SizedBox(height: Dimensions.heigth20,),
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bienvenue!",
                  style: TextStyle(
                    fontSize: Dimensions.font20*3+Dimensions.font20/2,
                    fontWeight: FontWeight.bold,
                  ),),

                  Text("Entrez a votre compte!",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),),


                ],)
              ),
            
            SizedBox(height: Dimensions.heigth30,),
            AppTextField(textController: emailController,
             hintText: "Email",
             icon: Icons.email),
            SizedBox(height: Dimensions.heigth20,),
            
              AppTextField(textController: passwordController,
             hintText: "Password",
             icon: Icons.password_sharp),
           
            SizedBox(height: Dimensions.heigth20,),        
            Row(
              children: [
                Expanded(child: Container()),
                RichText(text: TextSpan(      
              text: "Entrez a votre compte!",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: Dimensions.font20,
        
              ) ,
            )),
            SizedBox(width: Dimensions.width20,)
            ],
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
           Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenWidth/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor,
              ),
              child: Center(
                child: BigText(
                  "SignIn",
                  fontWeight: FontWeight.bold,
                  size: Dimensions.font20+Dimensions.font20/2,
                  color: Colors.white,
                  ),
              ),
              
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),

           RichText(text: TextSpan(
              
              text: "Vous n\'avez pas un compte?",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: Dimensions.font20,
        
              ) ,
              children: [
                TextSpan( 
                  recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),             
                text: " Creer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                  fontSize: Dimensions.font20,
          
                ),) ,
              ]
            ))
          ],
        ),
      ),
    );
  }
}
