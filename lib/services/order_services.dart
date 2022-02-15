part of 'services.dart';

class OrderServices {
  static CollectionReference orderCollection = FirebaseFirestore.instance.collection('order');

  static Future<void> saveOrder(Order order) async {
    await orderCollection.doc().set({
      'userID': order.userID,
      'userName': order.userName,
      'userEmail': order.userEmail,
      'product': order.product,
      'quantity': order.quantity,
      'totalPrice': order.totalPrice,
      'picture': order.picture,
      'time': order.time.millisecondsSinceEpoch,
      'status': order.status,
    });
  }

  static Future<List<Order>> getOrderPaid(String userID) async {
    QuerySnapshot snapshot = await orderCollection.where('status', isEqualTo: 'paid').get();

    var documents = snapshot.docs.where((document) => document['userID'] == userID);

    return documents
        .map((e) => Order(
            userID: e['userID'],
            userName: e['userName'],
            userEmail: e['userEmail'],
            product: e['product'],
            quantity: e['quantity'],
            totalPrice: e['totalPrice'],
            picture: e['picture'],
            status: e['status'],
            time: DateTime.fromMillisecondsSinceEpoch(
              e['time'],
            )))
        .toList();
  }

  static Future<List<Order>> getOrderPending(String userID) async {
    QuerySnapshot snapshot = await orderCollection.where('status', isEqualTo: 'pending').get();

    var documents = snapshot.docs.where((document) => document['userID'] == userID);

    return documents
        .map((e) => Order(
              userID: e['userID'],
              userName: e['userName'],
              userEmail: e['userEmail'],
              product: e['product'],
              quantity: e['quantity'],
              totalPrice: e['totalPrice'],
              picture: e['picture'],
              status: e['status'],
              time: DateTime.fromMillisecondsSinceEpoch(
                e['time'],
              ),
            ))
        .toList();
  }
}
