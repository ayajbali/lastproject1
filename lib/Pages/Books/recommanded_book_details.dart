import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/Books/app_icon.dart';
import 'package:lastproject/Pages/card/card_page.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/card_controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/models/products_model.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/app_column.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:lastproject/widgets/expandable_Text.dart';
import 'package:lastproject/widgets/icon_text.dart';


class RecommandedDetails extends StatelessWidget {
    final int pageId;

  const RecommandedDetails({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
     Get.find<PopularController>().initProduct(product,Get.find<cartController>());
      late cartController _cart;
   
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getinitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                //AppIcon(icon: Icons.add_shopping_cart_outlined),
                  GetBuilder<PopularController>(builder: (controller){
                  return GestureDetector(
                      onTap: (){
                      if (controller.totalItems>=1)
                       Get.to(() => CartPage());
                    },
                    child: Stack(
                      children:[
                      AppIcon(icon: Icons.shopping_bag_outlined),
                    
                      Get.find<PopularController>().totalItems>=1?
                       Positioned(
                        right: 0,
                        top: 0,
                        
                           child: AppIcon(icon: Icons.circle, 
                           size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor,),
                         
                       ):
                      
                        Container(),
                        AppIcon(icon: Icons.shopping_bag_outlined),
                    
                      Get.find<PopularController>().totalItems>=1?
                       Positioned(
                        right: 0,
                        top: 0,
                         child:BigText(Get.find<PopularController>().totalItems.toString(), fontWeight: FontWeight.normal , size:12 ,color:Colors.white) ,
                       ):
                      
                        Container()
                      ]
                    ),
                  );
                 })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                ),
                child: Center(
                  child: BigText(
                    "Title Placeholder",
                    fontWeight: FontWeight.bold,
                    size: Dimensions.font26,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.mainColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/Cover1.jpg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child: ExpandableText(
                    text: "je me presente je me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presenteje me presente ",
                  ),
                ),
                 SizedBox(height: Dimensions.heigth20,),
                /*Container(
                    height: Dimensions.pageView, 
                 child: PageView.builder(
                  //controller: pageController,
                  itemCount: 5,
                  itemBuilder: (context, position) {
                    return _buildPageItem(position );
              },
            ),
                )*/

              ],
            ),
          ),
        ],
      ),



     bottomNavigationBar: GetBuilder<PopularController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: (){
                          controller.setQuantity(false);
                        },
                      child: AppIcon(
                        icon: Icons.remove,
                        iconSize: Dimensions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                    BigText("120 X ${controller.inCartItems}",
                        fontWeight: FontWeight.bold, size: Dimensions.font26),
                    GestureDetector(
                        onTap: (){
                          controller.setQuantity(true);
                        },
                      child: AppIcon(
                        icon: Icons.add,
                        iconSize: Dimensions.iconSize24,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.addItem(product as Products);
                      },
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText("120/ Add to cart",
                            fontWeight: FontWeight.w700, color: Colors.white),
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

/*Widget _buildPageItem(int index,) {
    double _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;

  Matrix4 matrix = Matrix4.identity();
  if (index == _currentPageValue.floor()) {
    var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
    var currTrans = height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == _currentPageValue.floor() + 1) {
    var currScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
    var currTrans = height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else if (index == _currentPageValue.floor() - 1) {
    var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
    var currTrans = height * (1 - currScale) / 2;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, currTrans, 0);
  } else {
    var currScale = 0.8;
    matrix = Matrix4.diagonal3Values(1, currScale, 1)
      ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 1);
  }

  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularBooks(index, "Home"));
          },
          child: Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven ? Color.fromARGB(255, 96, 221, 255) : Color.fromARGB(255, 52, 143, 218),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(product.img),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.heigth30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                )
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(top: Dimensions.heigth10, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(product.name, size: 20, fontWeight: FontWeight.bold),
                  SizedBox(height: Dimensions.heigth10),
                  Row(
                    children: [
                      Wrap(
                        children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15)),
                      ),
                      SizedBox(width: 10),
                      SmallText(product.price),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: Dimensions.heigth10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(
                        icon: Icons.person,
                        text: '55',
                        iconColor: AppColors.iconColor1,
                      ),
                      SizedBox(width: 40),
                      IconText(
                        icon: FontAwesomeIcons.coins,
                        text: product.price,
                        iconColor: AppColors.mainColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
*/
