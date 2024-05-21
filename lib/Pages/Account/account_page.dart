import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/Auth/LoginPage.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/account_widget.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool _isEditMode = false;

  final TextEditingController _nameController = TextEditingController(text: "Eya Jbeli");
  final TextEditingController _phoneController = TextEditingController(text: "+216 55 835 212");
  final TextEditingController _emailController = TextEditingController(text: "jbelieya@gmail.com");
  final TextEditingController _addressController = TextEditingController(text: "Rue de lenvironnement");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: IconButton(
          icon: Icon(_isEditMode ? Icons.close : Icons.edit, color: Colors.white),
          onPressed: () {
            if (_isEditMode) {
              _saveChanges();
            }
            setState(() {
              _isEditMode = !_isEditMode;
            });
          },
          tooltip: _isEditMode ? 'Close' : 'Edit Profile',
        ),
        title: Center(
          child: BigText("Profile", fontWeight: FontWeight.bold, size: 24, color: Colors.white)
        ),
        actions: <Widget>[
          if (!_isEditMode)
          IconButton(
          icon: Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            // Clear shared preferences or any other persistent storage
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();

            // Optionally, handle backend logout logic here
            // Example: await myAuthService.logout();

            // Navigate to the login screen (assuming you use named routes)
           Get.to(()=>LoginPage());

       },
          tooltip: 'Logout',
        ),

        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!_isEditMode)
              _buildStaticProfile()
            else
              _buildEditableProfile(),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticProfile() {
    return Column(
      children: [
        SizedBox(height: Dimensions.heigth30),
        AppIcon(
          icon: Icons.person,
          backgroundColor: AppColors.mainColor,
          iconColor: Colors.white,
          iconSize: Dimensions.heigth45 + Dimensions.heigth30,
          size: Dimensions.heigth15 * 10,
        ),
        SizedBox(height: Dimensions.heigth30),
        AccountWidget(
          appIcon: AppIcon(
            icon: Icons.person,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.heigth10 * 5 / 2,
            size: Dimensions.heigth10 * 5,
          ),
          bigText: BigText(_nameController.text, fontWeight: FontWeight.w500, size: 15),
        ),
        SizedBox(height: Dimensions.heigth20),
        AccountWidget(
          appIcon: AppIcon(
            icon: Icons.phone,
            backgroundColor: Colors.yellow,
            iconColor: Colors.white,
            iconSize: Dimensions.heigth10 * 5 / 2,
            size: Dimensions.heigth10 * 5,
          ),
          bigText: BigText(_phoneController.text, fontWeight: FontWeight.w500, size: 15),
        ),
        SizedBox(height: Dimensions.heigth20),
        AccountWidget(
          appIcon: AppIcon(
            icon: Icons.email,
            backgroundColor: AppColors.mainColor,
            iconColor: Colors.white,
            iconSize: Dimensions.heigth10 * 5 / 2,
            size: Dimensions.heigth10 * 5,
          ),
          bigText: BigText(_emailController.text, fontWeight: FontWeight.w500, size: 15),
        ),
        SizedBox(height: Dimensions.heigth20),
        AccountWidget(
          appIcon: AppIcon(
            icon: Icons.location_on,
            backgroundColor: Colors.yellow,
            iconColor: Colors.white,
            iconSize: Dimensions.heigth10 * 5 / 2,
            size: Dimensions.heigth10 * 5,
          ),
          bigText: BigText(_addressController.text, fontWeight: FontWeight.w500, size: 15),
        ),
        SizedBox(height: Dimensions.heigth20),
      ],
    );
  }
Widget _buildEditableProfile() {
  return Center(
    child: Padding(  // Add padding around the entire column
      padding: EdgeInsets.all(20),  // Adjust the value to suit your layout needs
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(
          icon: Icons.person,
          backgroundColor: AppColors.mainColor,
          iconColor: Colors.white,
          iconSize: Dimensions.heigth45 + Dimensions.heigth30,
          size: Dimensions.heigth15 * 10,
        ),
          SizedBox(height: 20),  
          _editableField("Name", _nameController, Icons.person, Colors.white, AppColors.mainColor),
          SizedBox(height: 20),  
          _editableField("Phone", _phoneController, Icons.phone, Colors.white, Colors.yellow),
          SizedBox(height: 20),
          _editableField("Email", _emailController, Icons.email, Colors.white, AppColors.mainColor),
          SizedBox(height: 20),
          _editableField("Address", _addressController, Icons.location_on, Colors.white, Colors.yellow),
          SizedBox(height: 40),  
          ElevatedButton(
            onPressed: () {
              _saveChanges(); 
              setState(() {
                _isEditMode = false;  
              });
            },
            child: Text('Save Changes', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,  
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),  
              textStyle: TextStyle(fontSize: 16),  
            ),
          ),
        ],
      ),
    ),
  );
}



Widget _editableField(String label, TextEditingController controller, IconData iconData, Color iconColor, Color backgroundColor) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,  
      padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.width10, bottom: Dimensions.width10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
      child: Row(
        children: [
          AppIcon(
            icon: iconData,
            iconColor: iconColor,
            backgroundColor: backgroundColor,
            iconSize: Dimensions.heigth10 * 5 / 2,
            size: Dimensions.heigth10 * 5,
          ),
          SizedBox(width: Dimensions.width20),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  void _saveChanges() {
    // Implement your logic to save changes here, possibly syncing to a backend or local storage
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}