import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/Account/account_page.dart';
import 'package:lastproject/Pages/card/cart_history.dart';
import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/app_textfield.dart';
import 'package:lastproject/widgets/bigtext.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
        title: Center(child: BigText("Confirmer vos donnees", fontWeight: FontWeight.bold, size: 24, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5 , right: 5 , top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 2, color: Theme.of(context).primaryColor,
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.heigth20),
              child: SizedBox(height: 50, child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.heigth10),
                      margin: EdgeInsets.only(right: Dimensions.width10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200]!,
                            spreadRadius: 1,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: Icon(
                        index == 0 ? Icons.home_filled : Icons.contact_page,
                        color: index == 0 ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: Dimensions.heigth20),
            BigText("Votre Adresse mail", fontWeight: FontWeight.bold, size: 17, color: Colors.grey[500]),
            Padding( padding: EdgeInsets.only(left: Dimensions.width20)),
            AppTextField(textController: emailController, hintText: "Votre adresse mail", icon: Icons.mail),
            BigText("Votre Nom", fontWeight: FontWeight.bold, size: 17, color: Colors.grey[500]),
            Padding( padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.heigth30)),
            AppTextField(textController: emailController, hintText: "Votre Nom", icon: Icons.person),
            BigText("Votre Numéro de téléphone", fontWeight: FontWeight.bold, size: 17, color: Colors.grey[500]),
            Padding( padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.heigth20)),
            AppTextField(textController: emailController, hintText: "Votre téléphone", icon: Icons.phone),
            SizedBox(height: Dimensions.heigth45),


          ],
        ),
      ),

         bottomNavigationBar: GetBuilder<cartController>(builder: (cartController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
              ),
              SizedBox(height: Dimensions.heigth20),
              Container(
                height: Dimensions.bottomheightBar,
                padding: EdgeInsets.all(Dimensions.width20),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // This will place space between the two buttons
  children: [
    GestureDetector(
      onTap: () {
        cartController.addToHistory();
        Get.to(() => WelcomePage());
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.width20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: AppColors.mainColor,
        ),
        child: BigText("Confirmer",
          fontWeight: FontWeight.w700, color: Colors.white, size: 17),
      ),
    ),
    GestureDetector(
  onTap: () {
    Get.to(() => AccountPage(showFloatingActionButton: true));
  },
  child: Container(
    padding: EdgeInsets.all(Dimensions.width20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(Dimensions.radius20),
      color: AppColors.mainColor,
    ),
    child: BigText("Editer mes coordonnées",
      fontWeight: FontWeight.w700, color: Colors.white, size: 17),
  ),
),

  ],
),

              ),
            ],
          );
        },),
    );
  }
}