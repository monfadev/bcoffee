part of 'pages.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(children: [
        //> HEADER
        Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          color: Colors.white,
          height: 100,
          width: double.infinity,

          //Kita akan menampilkan Fotouser, namauser, saldouser => ambil dari BlocUser
          child: BlocBuilder<UserBloc, UserState>(
            builder: (_, userState) {
              //Jika datauser nya sudah ke load, maka akan menampilkan
              if (userState is UserLoaded) {
                //Saat account_confirmation_page.dart hanya menitipkan imageFileToUpload saja
                //Maka, jika tidak null
                if (imageFileToUpload != null) {
                  //uploadImage dengan file imageFileToUpload.
                  //then ini fungsinya kalau sudah selesai
                  //dan akan mengembalikan uploadImage dengan kembalian string
                  uploadImage(imageFileToUpload).then((downloadURL) {
                    //Jadi kalau sudah selesai, imagefiletouploadnya dibuat null lagi.
                    imageFileToUpload = null;
                    //update data user
                    context
                        .read<UserBloc>()
                        .add(UpdateData(profileImage: downloadURL));
                  });
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bibir Kopi", style: blackFontStyle1),
                        Text("Build relations from lips to lips",
                            style: greyFontStyle.copyWith(
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      padding: EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          LoadingIndicator(),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                image: (userState.user.profilePicture != null &&
                                        userState.user.profilePicture != "")
                                    ? NetworkImage(
                                        userState.user.profilePicture)
                                    : AssetImage("assets/add_pic.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ),

        //> LIST OF PRODUCTS
        StreamBuilder<QuerySnapshot>(
          stream: ProductsServices.productsCollection
              .orderBy('rating', descending: true)
              .limit(3)
              .snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return LoadingIndicator();
              }
              return Container(
                height: 258,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CoffeeDetailPage(
                                  snapshot.data.docs[index])));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: (index == 0) ? defaultMargin : 0,
                          right: defaultMargin,
                          top: defaultMargin,
                          bottom: defaultMargin),
                      child: ProductCard(
                          name: snapshot.data.docs[index]['name'],
                          rating: snapshot.data.docs[index]['rating']
                              .join(','),
                          image: snapshot.data.docs[index]['image']),
                    ),
                  ),
                ),
              );
            } else {
              return LoadingIndicator();
            }
          },
        ),

        //> LIST OF TABS
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              CustomTabBar(
                title: ['New Taste', 'Popular', 'Recommended'],
                selectedIndex: selectedIndex,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    print(index);
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
          child: Container(
            color: Colors.white,
          ),
        ),
        if (selectedIndex == 0)
          NewTastePage()
        else if (selectedIndex == 1)
          PopularPage()
        else
          RecommendedPage(),
      ]),
      SizedBox(height: 80),
    ]);
  }
}
// leading:
//     Text(snapshot.data.documents[index].data['name']),
// title: Text(
//     snapshot.data.documents[index].data['price']),
// subtitle: Text(
//     'description : ${snapshot.data.documents[index].data['description']}'),
// Text(productsList[index].name),
// Text(productsList[index].price),
// Text('description : ${productsList[index].description}'),
// Text(productsList[index].option.join(',')),
// Text(productsList[index].rating.join(',')),

//> LIST OF TAB
// StreamBuilder<QuerySnapshot>(
//     stream: ProductsServices.productsCollection
//         .orderBy('optiondetail')
//         .snapshots(),
//     builder: (_, snapshot) {
//       if (snapshot.hasData) {
//         if (snapshot.data.documents.length == 0) {
//           return LoadingIndicator();
//         }
//         return Builder(builder: (_) {
//           snapshot.data.documents
//               .where((element) => element.data['optiondetail']
//                   .contains((selectedIndex == 0)
//                       ? 'newtaste'
//                       : (selectedIndex == 1)
//                           ? 'popular'
//                           : 'recommended'))
//               .toList();
//           return Column(
//               children: snapshot.data.documents
//                   .map(
//                     (e) => Padding(
//                       padding: EdgeInsets.fromLTRB(
//                         defaultMargin,
//                         0,
//                         defaultMargin,
//                         16,
//                       ),
//                       child: ProductListItem(
//                         itemWidth: listItemWidth,
//                         pictureNameProduct: e.data['name'],
//                         pictureProduct: e.data['image'],
//                         priceProduct: e.data['price'],
//                         childCustom: RatingStars(
//                             rate: double.parse(
//                                 e.data['rating'].join(','))),
//                       ),
//                     ),
//                   )
//                   .toList());
//         });
//       } else {
//         return LoadingIndicator();
//       }
//     }),

//     return Container(
//       color: Colors.white,
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: snapshot.data.documents.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.fromLTRB(
//               defaultMargin,
//               0,
//               defaultMargin,
//               16,
//             ),
//             child: ProductListItem(
//               itemWidth: listItemWidth,
//               pictureNameProduct:
//                   snapshot.data.documents[index].data['name'],
//               pictureProduct:
//                   snapshot.data.documents[index].data['image'],
//               priceProduct:
//                   snapshot.data.documents[index].data['price'],
//               childCustom: RatingStars(
//                   rate: double.parse(snapshot
//                       .data.documents[index].data['rating']
//                       .join(','))),
//             ),
//           );
//         },
//       ),
//     );
//   });
// } else {
//   return LoadingIndicator();
// }
