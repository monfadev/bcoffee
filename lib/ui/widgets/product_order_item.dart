part of 'widgets.dart';

class ProductOrderItem extends StatelessWidget {
  final Order orders;
  final Color color;

  const ProductOrderItem(this.orders, {this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(
            right: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8,
            ),
            image: DecorationImage(
              image: (orders.picture != null && orders.picture != "")
                  ? NetworkImage(orders.picture)
                  : AssetImage('assets/add_pic.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orders.product,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: blackFontStyle3.copyWith(
                fontSize: 12,
              ),
            ),
            Text(
              (orders.quantity == "1")
                  ? "${orders.quantity} item • ${orders.totalPrice}"
                  : "${orders.quantity} items • ${orders.totalPrice}",
              style: greyFontStyle.copyWith(
                fontSize: 13,
              ),
            ),
          ],
        ),
        Spacer(),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                orders.status == 'pending' ? 'Pay Now' : 'Paid',
                overflow: TextOverflow.ellipsis,
                style: redFontStyle.copyWith(fontSize: 12, color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
