part of 'widgets.dart';

class ProductListItem extends StatelessWidget {
  final String pictureProduct;
  final String nameProduct;
  final String priceProduct;
  final double itemWidth;
  final Widget childCustom;

  const ProductListItem({
    this.childCustom,
    this.itemWidth,
    this.pictureProduct,
    this.nameProduct,
    this.priceProduct,
  });

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
              image: (pictureProduct != null && pictureProduct != "")
                  ? NetworkImage(pictureProduct)
                  : AssetImage('assets/add_pic.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: itemWidth -
              182, // 60 width Gambar + 12 margin gambar + 110 Rating Star,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nameProduct,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: blackFontStyle3.copyWith(
                  fontSize: 12,
                ),
              ),
              Text(
                priceProduct,
                style: greyFontStyle.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        childCustom,
      ],
    );
  }
}
