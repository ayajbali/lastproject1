import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
 import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/bigtext.dart';
 import 'package:lastproject/widgets/icon_text.dart';

class SmallPageItemBuilder extends StatelessWidget {
  final int index;
  final double currentPageValue;
  final double scaleFactor;
  final double height;

  const SmallPageItemBuilder({
    Key? key,
    required this.index,
    required this.currentPageValue,
    this.scaleFactor = 0.75, // Smaller scale factor for a more distinguished effect
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currScale = scaleFactor + (currentPageValue - index + 1) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currScale = 1 - (currentPageValue - index) * (1 - scaleFactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      matrix = Matrix4.diagonal3Values(1, scaleFactor, 1)..setTranslationRaw(0, height * (1 - scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: height * 0.6, // Smaller height
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15), // Smaller radius for smaller card
              color: index.isEven ? Colors.lightGreen[300] : Colors.lightBlue[300], // Different colors for variety
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/Cover2.jpg"), // Different image for a fresh look
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer * 0.6, // Smaller text container
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.heigth15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Color(0xFFe8e8e8), blurRadius: 5.0, offset: Offset(0, 3)),
                  BoxShadow(color: Colors.white, offset: Offset(-3, 0))
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText( "Mini Tale", size: 16, fontWeight: FontWeight.bold),
                    SizedBox(height: Dimensions.heigth15),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 12)),
                        ),
                        SizedBox(width: 5),
                        SmallText( "4.9"),
                        SizedBox(width: 5),
                      ],
                    ),
                    SizedBox(height: Dimensions.heigth15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconText(icon: Icons.child_care, text: 'Kids', iconColor: AppColors.iconColor1),
                        IconText(icon: FontAwesomeIcons.dollarSign, text: '15.99', iconColor: AppColors.mainColor),
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
