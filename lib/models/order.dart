part of 'models.dart';

class Order extends Equatable {
  final String userID;
  final String userName;
  final String userEmail;
  final String product;
  final String quantity;
  final String totalPrice;
  final String picture;
  final DateTime time;
  final String status;

  Order(
      {@required this.userID,
      @required this.userName,
      @required this.userEmail,
      @required this.product,
      @required this.quantity,
      @required this.totalPrice,
      this.picture,
      @required this.time,
      this.status = "pending"});

  @override
  List<Object> get props => [
        userID,
        userName,
        userEmail,
        product,
        quantity,
        totalPrice,
        picture,
        time,
        status
      ];
}
