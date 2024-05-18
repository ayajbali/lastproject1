import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/account_widget.dart';
import 'package:lastproject/widgets/bigtext.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText("Profile", fontWeight: FontWeight.bold, size: 24, color: Colors.white)),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.heigth20),
        child: Column(
          children: [

            //Profile icon
           AppIcon(icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.heigth45+Dimensions.heigth30,
            size: Dimensions.heigth15*10,),

           SizedBox(height: Dimensions.heigth30,),
            
           Expanded(
             child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                  children: [
                     //Name icon
                AccountWidget(
                  appIcon: AppIcon(icon: Icons.person,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize:Dimensions.heigth10*5/2 ,
                      size:Dimensions.heigth10*5 ,
                      
                      ), 
                      
                  bigText: BigText("Eya Jbeli", fontWeight: FontWeight.w500,size: 15,),
                  ),
                          
                
                          //Phone icon
                           SizedBox(height: Dimensions.heigth20,), 
                           AccountWidget(
                          appIcon: AppIcon(icon: Icons.phone,
                              backgroundColor: Colors.yellow,
                              iconColor: Colors.white,
                              iconSize:Dimensions.heigth10*5/2 ,
                              size:Dimensions.heigth10*5 ,
                              
                              ), 
                              
                          bigText: BigText("+216 55 835 212 ", fontWeight: FontWeight.w500,size: 15,),
                          ),
                                  
                        
                           //mail icon
                           SizedBox(height: Dimensions.heigth20,),
                           AccountWidget(
                  appIcon: AppIcon(icon: Icons.email,
                      backgroundColor: Colors.yellow,
                      iconColor: Colors.white,
                      iconSize:Dimensions.heigth10*5/2 ,
                      size:Dimensions.heigth10*5 ,
                      
                      ), 
                      
                  bigText: BigText("jbelieya27@gmail.com", fontWeight: FontWeight.w500,size: 15,),
                  ),
                
                
                           //Adress
                           SizedBox(height: Dimensions.heigth20,),
                AccountWidget(
                  appIcon: AppIcon(icon: Icons.location_on,
                      backgroundColor: Colors.yellow,
                      iconColor: Colors.white,
                      iconSize:Dimensions.heigth10*5/2 ,
                      size:Dimensions.heigth10*5 ,
                      
                      ), 
                      
                  bigText: BigText("Ecrivez votre adress", fontWeight: FontWeight.w500,size: 15,),
                ),               
                           //messege
                           SizedBox(height: Dimensions.heigth20,),
                           AccountWidget(
                  appIcon: AppIcon(icon: Icons.message_outlined,
                      backgroundColor: Colors.redAccent,
                      iconColor: Colors.white,
                      iconSize:Dimensions.heigth10*5/2 ,
                      size:Dimensions.heigth10*5 ,
                      
                      ),
                      bigText: BigText("Messages ", fontWeight: FontWeight.w500,size: 15,),
                      
                           ),
                           
                  ],
                )
                 
                  ],
                ),
              ),
           )
            
          ],
        ),
      ),
    );
  }
}