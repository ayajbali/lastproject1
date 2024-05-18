import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/widgets/bigtext.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(child: BigText("Nos Adresses", fontWeight: FontWeight.bold, size: 24, color: Colors.white)),
      ),
    );
  }
}