import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lastproject/Pages/home/Home_body.dart';
import 'package:lastproject/data/api/Controllers/Popular_Controller.dart';
import 'package:lastproject/utils/colors.dart';  
import 'package:lastproject/utils/demesion.dart';
import 'package:lastproject/widgets/SmallText.dart';
import 'package:lastproject/widgets/bigtext.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimensions.heigth45, bottom: Dimensions.heigth15),
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isSearching ? Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cherchez ici...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        borderSide: BorderSide.none,  // Changed to BorderSide.none for better effect
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(Dimensions.heigth10),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {  // This should be outside of decoration
                      Get.find<PopularController>().searchProduct(value);
                    },
                    onSubmitted: (value) {
                      setState(() {
                        isSearching = false;
                      });
                    },
                  ),
                ) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText("Tunisie", color: AppColors.mainColor, fontWeight: FontWeight.bold),
                    Row(
                      children: [
                        SmallText("city", color: Colors.black54),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSearching = !isSearching;
                      if (!isSearching) {
                        _searchController.clear();
                      }
                    });
                  },
                  child: Container(
                    width: Dimensions.heigth45,
                    height: Dimensions.heigth45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(isSearching ? Icons.close : Icons.search, color: Colors.white, size: Dimensions.iconSize24),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: HomeBody(),  
            )
          ),
        ],
      ),
    );
  }
}