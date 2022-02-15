part of 'pages.dart';

class PaidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => FutureBuilder(
          future: OrderServices.getOrderPaid((userState as UserLoaded).user.id),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return generateTransactionList(snapshot.data);
            } else {
              return LoadingIndicator();
            }
          }),
    );
  }

  Column generateTransactionList(List<Order> order) {
    order.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));

    return Column(
      children: order
          .map((order) => Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    defaultMargin,
                    0,
                    defaultMargin,
                    16,
                  ),
                  child: ProductOrderItem(order, color: mainColor),
                ),
              ))
          .toList(),
    );
  }
}
