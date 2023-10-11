
class Product {
  int? id;
  String? name;
  int? price;
  String? description;

  Product({this.id, this.name, this.price, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
  }
}
