part of 'pages.dart';

class NewTastePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return StreamBuilder<QuerySnapshot>(
      stream: ProductsServices.productsCollection
          .where('optiondetail', arrayContains: 'newtaste')
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length == 0) {
            return LoadingIndicator();
          }
          return Container(
            color: Colors.white,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CoffeeDetailPage(
                                snapshot.data.docs[index])));
                    print('tap products newtaste');
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      defaultMargin,
                      0,
                      defaultMargin,
                      16,
                    ),
                    child: ProductListItem(
                      itemWidth: listItemWidth,
                      nameProduct: snapshot.data.docs[index]['name'],
                      pictureProduct:
                          snapshot.data.docs[index]['image'],
                      priceProduct:
                          // snapshot.data.docs[index].data['price'],
                          numberRupiah.format(int.parse(
                              snapshot.data.docs[index]['price'])),
                      childCustom: RatingStars(
                          rate: double.parse(snapshot
                              .data.docs[index]['rating']
                              .join(','))),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return LoadingIndicator();
        }
      },
    );
  }
}
