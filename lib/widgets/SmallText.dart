import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;

  // Constructor
  SmallText(
    this.text, // Positional parameter
    {
    Key? key,
    this.color,
    this.size = 17,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? const Color(0xFFccc7c5),
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
      ),
    );
  }
}
