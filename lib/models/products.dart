part of 'models.dart';

class Products extends Equatable {
  String id;
  String name;
  String price;
  String description;
  String image;
  List option = [];
  List rating = [];

  Products(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.image,
      this.option,
      this.rating});

  Products.fromMap(Map<String, dynamic> json) {
    id = json['id'] == null ? "" : json['id'];
    name = json['name'] == null ? "" : json['name'];
    price = json['price'] == null ? "" : json['price'];
    description = json['description'] == null ? "" : json['description'];
    image = json['image'] == null ? "" : json['image'];
    option = json['option'] == null ? "" : json['option'];
    rating = json['rating'] == null ? "" : json['rating'];
  }

  @override
  List<Object> get props =>
      [id, name, price, description, image, option, rating];
}
