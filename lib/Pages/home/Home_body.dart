import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lastproject/Pages/Books/Books_Details.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/data/api/Controllers/recommended_product_controller.dart';
import 'package:lastproject/models/products_model.dart';
import 'package:lastproject/routes/route_helper.dart';
import 'package:lastproject/utils/app_constans.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/BigText.dart';
import 'package:lastproject/widgets/app_column.dart';
import 'package:lastproject/widgets/icon_text.dart';
import 'package:get/get.dart';

class HomeBody extends StatefulWidget {
 
 
  
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimensions.pageViewContainer;
  
 
  @override
void initState() {
    super.initState();
    pageController.addListener(() {
        setState(() {
            _currentPageValue = pageController.page ?? 0.0;  // Ensure there's a fallback value
        });
    });
    Get.find<PopularController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList(); // Add this line
}


  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     var product = Get.find<RecommendedProductController>();
    return Column(
      children: [
        GetBuilder<PopularController>(
          builder: (controller){
          return  controller.popularProductList.isNotEmpty ? Container(
          height: Dimensions.pageView, 
            child: GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.popularBooks);
              },
              child: PageView.builder(
                controller: pageController,
                  itemCount: controller.popularProductList.length,
                  itemBuilder: (context, position) {
                  return _buildPageItem(position, controller.popularProductList[position]);
                },
              ),
            ),
          
        ): CircularProgressIndicator();
        }),
        GetBuilder<PopularController>(builder: (popularProducts){
          return DotsIndicator(
          dotsCount: 5,
          position: _currentPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        );
        //popular text
        SizedBox(height: Dimensions.heigth30,);

        }),
        
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText("Tout  ", size: Dimensions.font20, fontWeight: FontWeight.w500),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(".", color: Colors.black26, size: 11, fontWeight: FontWeight.w500),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText("Arab", color: Colors.black26, size: 15,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText("Francais", color: Colors.black26, size: 15,),
              ),
            ],
          ),
        ),
        //recommended 
        //List of categories
      GetBuilder<RecommendedProductController>(builder: (recommendedController) {
    return recommendedController.isLoaded ? ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: recommendedController.recommendedProductList.length,
        itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                    Get.toNamed(RouteHelper.getrecomendedBooks(index));
                },
                child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.heigth10),
                    child: Row(
                        children: [
                            // Image section
                            Container(
                                height: Dimensions.listViewImgSize,
                                width: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recommendedController.recommendedProductList[index].img!
                                        ),
                                    ),
                                ),
                            ),
                            // Text section
                            Expanded(
                                child: Container(
                                    height: Dimensions.listViewTextConSize,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.radius20),
                                            bottomRight: Radius.circular(Dimensions.radius20),
                                        ),
                                        color: Colors.white,
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                        child: AppColumn(text: recommendedController.recommendedProductList[index].name ?? "No name available"),
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            );
        }
    ) : CircularProgressIndicator();
    colors:AppColors.mainColor;



}),

 GetBuilder<PopularController>(
          builder: (controller) {
            List<Products> displayList = controller.isSearchMode ? controller.searchResults : controller.productsList;

            return displayList.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                Products product = displayList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getrecomendedBooks(index)); // Make sure to use the correct routing
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.heigth10),
                    child: Row(
                      children: [
                        // Image section
                        Container(
                          height: Dimensions.listViewImgSize,
                          width: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            /*image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img),
                            ),*/
                          ),
                        ),
                        // Text section
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextConSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                              child: AppColumn(text: product.name ?? "No name available"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ) : Center(child: Text("No products found"));
          },
        ),

        

      ],
    );
  }

  Widget _buildPageItem(int index, dynamic product) {
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
}
