part of 'widgets.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String rating;
  final String image;

  ProductCard({this.name, this.rating, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(spreadRadius: 3, blurRadius: 15, color: Colors.black12),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: (image != null && image != "")
                    ? NetworkImage(image)
                    : AssetImage('assets/add_pic.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 6),
            width: 200,
            child: Text(
              name,
              style: blackFontStyle2,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: RatingStars(rate: double.parse(rating)),
          )
        ],
      ),
    );
  }
}
