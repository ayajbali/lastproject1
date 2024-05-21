import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lastproject/Pages/Account/account_page.dart';
 import 'package:lastproject/Pages/Contact/contact.dart';
import 'package:lastproject/Pages/card/cart_history.dart';
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
   int _selectedIndex=0;
   late PersistentTabController _controller ;
  List pages=[
    MainPage(),
    ContactPage(),
    CartHistory(),
    Container(child: Center(child: Text("Next Page 3"),),)

  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

@override 
 void initState(){
  super.initState();
  _controller = PersistentTabController(initialIndex:0);
 }

 List<Widget> _buildScreens() {
        return [
        MainPage(),
        ContactPage(),
        CartHistory(),
        AccountPage(),
     ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [

          PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),


            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.archivebox_fill),
                title: ("Archive"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),


            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.cart_fill),
                title: ("Cart"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),


             PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.person),
                title: ("Me"),
                activeColorPrimary: CupertinoColors.activeBlue,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            
        ];
    }

 
  

   @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 100),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }

}