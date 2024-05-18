import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lastproject/Pages/Auth/sign_in_page.dart';
import 'package:lastproject/base/show_message.dart';
import 'package:lastproject/data/api/Controllers/user_controller.dart';
import 'package:lastproject/data/api/Controllers/auth_api.dart';
import 'package:lastproject/models/sign_up_model.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/app_textfield.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var usernameController = TextEditingController();
    var confirmPasswordController = TextEditingController();
   
  showAlert({required String title, required String text}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
  
    
    createAccount() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  CircularProgressIndicator(),
                ]),
          );
        });
    try {
      final AuthAPI appwrite = context.read<AuthAPI>();
      await appwrite.createUser(
        username:usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text
      );
      Navigator.pop(context);
      const snackbar = SnackBar(content: Text('Account created!'));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on AppwriteException catch (e) {
      Navigator.pop(context);
      showAlert(title: 'Account creation failed', text: e.message.toString());
    }
  }



    void _registration(){

      var authController =Get.find<AuthController>();
       String username= usernameController.text.trim();
       String phone = phoneController.text.trim();
       String email = emailController.text.trim();
       String password = passwordController.text.trim();
       String confirmpassword = confirmPasswordController.text.trim();
     

     if(username.isEmpty){
       showSnackBar("Taper votre nom",title: "Name");
     }else if(phone.isEmpty){
       showSnackBar("Taper votre numero de telephone",title: "phone");
     }else if(email.isEmpty){
      showSnackBar("Taper votre adress email",title: "Email adress");

     }else if(!GetUtils.isEmail(email)){
      showSnackBar("Taper une adress email valide",title: "Valid email adress");

     }else if(password.isEmpty){
      showSnackBar("Taper votre mot de passe  ",title: "password");

     }else if(password.length<6){
      showSnackBar("Longeur de mot de passe ne doit pas etre moin de 6 charactere ",title: "Password");

     }else{
      showSnackBar("Parfait!",title: "Perfect");
      SignUpBody signUpBody= SignUpBody(usernamename: username, email: email, password: password, phone: phone);
      
      authController.registration(signUpBody).then((status){
         if(status.isSuccess){
          print("Success registration");
         }else{
          showSnackBar(status.message);
         }
      });
     }
}
     

     
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),
            Center(
              child: Container(
                height: Dimensions.screenHeight*0.25, // Adjust the height as needed
                width: 150, // Adjust the width as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Adjust the border radius for desired roundness
                  child: Image.asset("assets/images/AppLogo.png", fit: BoxFit.cover),
                ),
              ),
               
           
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
            AppTextField(textController: confirmPasswordController,
             hintText: "confirmpassword",
             icon: Icons.password_sharp),
            SizedBox(height: Dimensions.heigth20,),
              AppTextField(textController: usernameController,
             hintText: "Name",
             icon: Icons.person),
            SizedBox(height: Dimensions.heigth20,),
              AppTextField(textController: phoneController,
             hintText: "Phone",
             icon: Icons.phone),
            SizedBox(height: Dimensions.heigth30,),
        
            GestureDetector(
              onTap:(){
                 debugPrint("Username: ${usernameController.text}");
                  debugPrint("Email : ${emailController.text}");
                  debugPrint("Password : ${passwordController.text}");
                  debugPrint("Confirm Password : ${confirmPasswordController.text}");
                  debugPrint("Phone: ${phoneController.text}");

          if (usernameController.text.isEmpty ||
              emailController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty || 
              phoneController.text.isEmpty
              ) {
           showSnackBar("Il faut remplir les champs vides ",title: "Champs vide");
            return; // Exit the function if any field is empty
          } else if (passwordController.text != confirmPasswordController.text) {
            print("Confirmez votre mot de passe ");
            return; // Exit the function if passwords do not match
          } else {
            createAccount();
     
          }
              },
              child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenWidth/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: BigText(
                    "SignUp",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font20+Dimensions.font20/2,
                    color: Colors.white,
                    ),
                ),
                
              ),
            ),
            SizedBox(height: Dimensions.heigth10,),
        
            RichText(text: TextSpan(
              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignInPage()),
              
              text: "Vous avez deja un compte?",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: Dimensions.font20,
        
              ) ,
            ))
          ],
        ),
      ),
    );

    

     
  }
}
