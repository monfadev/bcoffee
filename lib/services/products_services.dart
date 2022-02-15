part of 'services.dart';

class ProductsServices {
  static CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  static Future<List<Products>> getProducts() async {
    QuerySnapshot snapshot = await productsCollection.get();

    List<Products> productsList = [];

    for (var document in snapshot.docs) {
      productsList.add(
        Products(
          id: document['id'],
          name: document['name'],
          price: document['price'],
          description: document['description'],
          image: document['image'],
          option: document['option'],
          rating: document['rating'],
          // stock: document['stock'],
          // ratings: document['ratings']
        ),
      );
    }

    return productsList;
  }
}
