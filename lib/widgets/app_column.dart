import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/bigtext.dart';
import 'package:lastproject/widgets/icon_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key , required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BigText("La premiere Categorie", size: Dimensions.font26, fontWeight: FontWeight.w500),
         
        SmallText("Decouvrez maintenant "),
        Row(
          children: [
            Wrap(
              children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15)),
            ),
            SizedBox(width: 10),
            SmallText("4.5"),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 5/2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(
              icon: Icons.person,
              text: 'Enfants',
              iconColor: AppColors.iconColor1,
            ),
            IconText(
              icon: FontAwesomeIcons.coins,
              text: '2.3DT',
              iconColor: AppColors.mainColor,
            ),
          ],
        ),
      ],
    );
  }
}
