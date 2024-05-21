import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:lastproject/Pages/Auth/SignIn.dart';
import 'package:lastproject/Pages/Auth/SignUpPage.dart';
import 'package:lastproject/Pages/Books/Books_Details.dart';
import 'package:lastproject/Pages/Books/recommanded_book_details.dart';
import 'package:lastproject/Pages/Contact/contact.dart';
import 'package:lastproject/Pages/add_address_page.dart';
import 'package:lastproject/Pages/card/card_page.dart';
import 'package:lastproject/Pages/card/cart_history.dart';
import 'package:lastproject/Pages/home/Welcome_Page.dart';
import 'package:lastproject/Pages/home/main_page.dart';
import 'package:lastproject/Pages/splash/splash_page.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularBooks = "/popular_books";
  static const String recomendedBooks = "/recomended_books";
  static const String cartPage = "/cart_page";
  static const String cartHistoryPage = "/cart_history_page";
  static const String splashPage = "/splash_page";
  static const String SignIn="/sign-in";
  static const String SignUp="/sign-up";
  static const String contactPage ="/contact_page";

  static const String addAddress = "/add_Address";

  static String getrecomendedBooks(int pageId) =>'$recomendedBooks?pageId=$pageId';
  static String getPopularBooks(int pageId, String page) => '$popularBooks?pageId=$pageId&page=$page';
  static String getinitial() => '$initial';
  static String getCartPage()=>'$cartPage';
  static String getCartHistoryPage()=>'$cartHistoryPage';
  static String getSplashPage()=>'$splashPage';
  static String getAddressPage()=>'$addAddress';
  static String getSignInPage()=>'$SignIn';
  static String getSignUpPage()=>'$SignUp';
  static String getcontactPage()=>'$contactPage';
  


  static List<GetPage> routes = [
    GetPage(name: initial, page: () => WelcomePage()),
    
    GetPage(
      name: popularBooks, // Use the constant
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters["page"];
        return Books_Details(pageId: int.parse(pageId??'default_id'), page:page!); // Handle null safely
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: recomendedBooks, // Use the constant
      page: () {
        var pageId = Get.parameters['pageId'];
        return RecommandedDetails(pageId: int.parse(pageId ?? 'default_id')); // Handle null safely
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: cartPage,
      page: ()=> CartPage(),
      transition: Transition.fadeIn,
      ),
     
     GetPage(
      name: cartHistoryPage,
      page: ()=> CartHistory(),
      transition: Transition.fadeIn,
      ),

      
      GetPage(
      name: splashPage,
      page: ()=> SplashPage(),
      transition: Transition.fadeIn,
      ),
      

      GetPage(
      name: SignIn,
      page: ()=>LoginPage (),
      transition: Transition.fadeIn,
      ),

      GetPage(
      name: SignUp,
      page: ()=>SignUpPageFirst(),
      transition: Transition.fadeIn,
      ),




      GetPage(
      name: addAddress,
      page: (){
        return AddAddressPage();
        
      } ,
      transition: Transition.fadeIn,
      ),

      GetPage(
      name: contactPage,
      page: (){
        return ContactPage();
        
      } ,
      transition: Transition.fadeIn,
      ),


  ];


}
