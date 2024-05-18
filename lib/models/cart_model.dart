
import 'package:lastproject/models/products_model.dart';

class Cart {
  int? id;
  String? name;
  String? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
    /*late  List<Cart> _cart;
   List<Cart> get products=> _cart;*/
   Products? products;

  Cart({
    this.id,
    this.name,
    this.price,
    this.img,
     this.quantity,
      this.time,
       this.isExist,
       this.products,
  });

  Cart.fromJson(Map<String, dynamic> json) {
    id = id = int.tryParse(json['id'].toString());
    name = json["name"];
    price = json["price"];
    img = json["img"];
    quantity = json["quantity"];
    time = json["time"];
    isExist = json["isExist"]; 
    products = Products.fromJson(json['products']);
  }

  Map<String , dynamic> toJson(){
   return {
     "id":this.id,
    "name":this.name,
    "price":this.price,
    "img":this.img,
    "quantity":this.quantity,
    "isExist":this.isExist,
    "time":this.time,
    "products":this.products!.toJson()
   };
  }
}
