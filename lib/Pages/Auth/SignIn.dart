import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastproject/data/api/Controllers/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
  late Color myColor;
  late Size mediaSize;
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;

 signIn() async {
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
      await appwrite.createEmailSession(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on AppwriteException catch (e) {
      Navigator.pop(context);
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  

  }

  signInWithProvider(String provider) {
    try {
      context.read<AuthAPI>().signInWithProvider(provider: provider);
    } on AppwriteException catch (e) {
      showAlert(title: 'Login failed', text: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
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
          const SizedBox(height: 0), // Reduce space
          Image.asset(
            'images/logo.png',
            height: 150, // Adjusted logo height
            width: 150,  // Adjusted logo width
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
          child: _buildForm(),
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
                fontSize: 36,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 25), 
          _buildGreyText("Email address"),
          _buildInputField(emailController),
          const SizedBox(height: 16),
          _buildGreyText("Password"),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 10),
          _buildRememberForgot(),
          const SizedBox(height: 10),
          Center(child: _buildLoginButton(context)),
          const SizedBox(height: 10), // Add more space
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
        suffixIcon:
        isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                value: loading,
                onChanged: (value) {
                  setState(() {
                    loading = value!;
                  });
                },
              ),
              _buildGreyText(
                "Remember me",
                fontSize: 11,
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: _buildGreyText(
            "I forgot my password",
            fontSize: 11,
          ),
        ),
      ],
    );
  }


  Widget _buildLoginButton( BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        onPressed: () {
          debugPrint("Email : ${emailController.text}");
          debugPrint("Password : ${passwordController.text}");
          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
            print("Please fill in all required fields");
            return; // Exit the function if any field is empty
          } else 
          {
            signIn();                         
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
            "LOGIN",
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
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPageFirst()),
          );
        },
        child: Center(
          child: Text(
            "Don't have an account? Create one",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

}


