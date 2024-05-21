import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastproject/Pages/Auth/SignIn.dart';
 import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/data/api/Controllers/auth_api.dart';

class SignUpPageFirst extends StatefulWidget {
  const SignUpPageFirst({Key? key}) : super(key: key);

  @override
  State<SignUpPageFirst> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPageFirst> {
  late Color myColor;
  late Size mediaSize;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool rememberUser = false;

 
void createAccount() async {
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
          ]
        ),
      );
    }
  );

  try {
    final AuthAPI appwrite = context.read<AuthAPI>();
    await appwrite.createUser(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    Navigator.pop(context); // Dismiss the loading dialog

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));

  } on AppwriteException catch (e) {
    Navigator.pop(context); // Dismiss the loading dialog
    showAlert(title: 'Account creation failed', text: e.message.toString());
  }
}
   
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

 
  @override
  void initState() {
    super.initState();
    // Initialize mediaSize in initState
    mediaSize = Size.zero;
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size; // Now it's safe to use mediaSize
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            child: _buildTop(),
          ),
          Positioned(
            bottom: 0,
            child: _buildBottom(),
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40), // Add more space
          Image.asset(
            'assets/images/AppLogo.png',
            height: 200,
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 11),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "Hey Again!",
              style: TextStyle(
                color: Colors.black26,
                fontSize: 36, // Increase font size
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildGreyText("Username"),
          _buildInputField(usernameController),
          const SizedBox(height: 16),
          _buildGreyText("Email address"),
          _buildInputField(emailController),
          const SizedBox(height: 16),
          _buildGreyText("Password"),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 16),
          _buildGreyText("Confirm Password"),
          _buildInputField(confirmPasswordController, isPassword: true),
          const SizedBox(height: 16),
          Center(child: _buildSignUpButton()),
          const SizedBox(height: 16), // Add more space
          _buildOtherLogin(),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text, {double fontSize = 12}) {
    return Text(
      text,
      style: TextStyle(color: Colors.grey, fontSize: fontSize),
    );
  }

  Widget _buildInputField(TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          debugPrint("Username: ${usernameController.text}");
          debugPrint("Email : ${emailController.text}");
          debugPrint("Password : ${passwordController.text}");
          debugPrint("Confirm Password : ${confirmPasswordController.text}");

          if (usernameController.text.isEmpty ||
              emailController.text.isEmpty ||
              passwordController.text.isEmpty ||
              confirmPasswordController.text.isEmpty) {
            print("Please fill in all required fields");
            return; // Exit the function if any field is empty
          } else if (passwordController.text != confirmPasswordController.text) {
            print("Passwords do not match");
            return; // Exit the function if passwords do not match
          } else {
            createAccount();
     
          }
        },
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          elevation: 20,
          shadowColor: Colors.black,
          backgroundColor: Colors.blue,
        ),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "SIGN UP",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtherLogin() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Center(
            child: Text(
              "Already have an account? Login",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton(String text) {
    return Expanded(
      child: TextButton(
        onPressed: () {
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}