import 'package:flutter/material.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
 
class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key , required this.text}) : super (key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/5.63;
  

  @override
  void initState(){
    super.initState();
      if(widget.text.length> textHeight){
         firstHalf = widget.text.substring(0 , textHeight.toInt());
         secondHalf= widget.text.substring(textHeight.toInt()+1 , widget.text.length);
      }else{
        firstHalf = widget.text;
        secondHalf="";
      }
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(firstHalf): Column(
         children: [
          SmallText(height:1.5,hiddenText?(firstHalf+"..."):(firstHalf+secondHalf)),
          InkWell(
            onTap: (){
              setState((){
                hiddenText = !hiddenText;
              }
              );

            },
            child: Row(
              children: [
                SmallText("Voir Plus.." ,  color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,),

              ],
            ),
          )

         ],
      ) ,
    );
  }
}