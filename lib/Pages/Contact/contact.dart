import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lastproject/models/companylocation.dart';
import 'package:lastproject/utils/colors.dart';
import 'package:lastproject/widgets/bigtext.dart';

class ContactPage extends StatelessWidget {
  final List<CompanyLocation> locations = [
    CompanyLocation(city: "Algiers", address: "123 Freedom St, Algiers", phoneNumber: "+213 21 123456"),
    CompanyLocation(city: "Oran", address: "45 Revolution Ave, Oran", phoneNumber: "+213 41 654321"),
    CompanyLocation(city: "Constantine", address: "78 Unity Blvd, Constantine", phoneNumber: "+213 31 987654"),
  ];

  ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DAAR EL MAAREF Locations',
          style: TextStyle(color: Colors.white), // White text color
        ),
        centerTitle: true, // Center the title text
        backgroundColor: AppColors.mainColor, // Custom background color from your utility class
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (index == 0)
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Center(
                    child: BigText(  'Decouvrez nos addresses!',fontWeight: FontWeight.bold,size: 18,),
                  ),
                ),
              Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(locations[index].city),
                  subtitle: Text("${locations[index].address}\n${locations[index].phoneNumber}"),
                  leading: Icon(Icons.location_city),
                  isThreeLine: true,
                  onTap: () {},
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}