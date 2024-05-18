import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/widgets/BigText.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/icon_text.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart'; // Ensure this import is correct
import 'package:lastproject/routes/route_helper.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
            _currentPageValue = pageController.page ?? 0.0;  // Ensure there's a fallback value
      });
    });
    Get.find<PopularController>().getPopularList(); // Make sure to fetch data on init
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularController>(
          builder: (controller) {
            return controller.popularList.isNotEmpty ? Container(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: controller.popularList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position, controller.popularList[position]);
                },
              ),
            ) : CircularProgressIndicator();
          }
        ),
        GetBuilder<PopularController>(
  builder: (controller) {
    return DotsIndicator(
      dotsCount: controller.popularList.length, // Provide dotsCount parameter
      position: pageController.hasClients ? pageController.page! : 0,
      decorator: DotsDecorator(
        // Provide DotsDecorator for customization
        activeColor: AppColors.mainColor,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  },
)

        // The rest of your UI components go here
      ],
    );
  }

  Widget _buildPageItem(int index, dynamic product) {

    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getpopularBooks(product.id));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          image: DecorationImage(
            image:NetworkImage(product.img),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(Dimensions.width20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius20),
            ),
            child: Text(product.name),
          ),
        ),
      ),
    );
  }
}
