

class Products {
  int? id;
  String? name;
  String? description;
  String? price;
  String? stars;
  String? img;
  String? location;
  String? createAt;
  String? updateAt;
  String? typeId;
    late  List<Products> _products ;
   List<Products> get products=> _products;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stars,
    this.img,
    this.location, // corrected from localisation
    this.createAt,
    this.updateAt,
    this.typeId, // corrected from typeID
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = id = int.tryParse(json['id'].toString());
    name = json["name"];
    description = json["description"];
    price = json["price"];
    stars = json["stars"]; // corrected from img
    img = json["img"];
    location = json["location"]; // corrected from localisation
    createAt = json["createAt"]; // corrected from create_at
    updateAt = json["updateAt"]; // corrected from update_at
    typeId = json["type_id"]; // corrected from typeID
   

  }

  Map<String, dynamic> toJson(){
    return{
     "id":this.id,
    "name":this.name,
    "description":this.description,
    "price":this.price,
     "stars":this.stars,
    "img":this.img,
    "location":this.location,
     "createAt" : this.createAt,
    "updateAt" : this. updateAt, 
    "typeId" :this.typeId,
    
    };
  }
}
