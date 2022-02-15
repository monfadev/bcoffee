part of 'pages.dart';

class CoffeeDetailPage extends StatefulWidget {
  final DocumentSnapshot products;

  CoffeeDetailPage(this.products);

  @override
  _CoffeeDetailPageState createState() => _CoffeeDetailPageState();
}

class _CoffeeDetailPageState extends State<CoffeeDetailPage> {
  int quantity = 1;

  void openWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print('Using Whatsapp App For Next Payment');
  }

  void showCustomSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 20, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: Text('Using Whatsapp App For Next Payment', style: whiteFontStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: 0.5)),
            ),
          ],
        ),
      ),
      backgroundColor: mainColor,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: mainColor,
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
            ),
          ),
          SafeArea(
            child: Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: (widget.products['image'] != null && widget.products['image'] != "" ? NetworkImage(widget.products['image']) : AssetImage("assets/add_pic.png")))),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    //> BACK BUTTON
                    Container(
                      height: 100,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            print('back');
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black12,
                            ),
                            child: Image.asset('assets/back_arrow_white.png'),
                          ),
                        ),
                      ),
                    ),
                    //> BODY
                    Container(
                      margin: EdgeInsets.only(top: 300),
                      padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 134, //32 + 102,
                                    child: Text(widget.products['name'], style: blackFontStyle2),
                                  ),
                                  SizedBox(height: 6),
                                  RatingStars(rate: double.parse(widget.products['rating'].join(','))),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity = max(1, quantity - 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(image: AssetImage('assets/btn_min.png')),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: 50,
                                      child: Text(
                                        quantity.toString(),
                                        textAlign: TextAlign.center,
                                        style: blackFontStyle2,
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        quantity = min(100, quantity + 1);
                                      });
                                    },
                                    child: Container(
                                      width: 26,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(image: AssetImage('assets/btn_add.png')),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 14, 0, 16),
                              child: Text(widget.products['description'], style: greyFontStyle),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Total Price', style: greyFontStyle.copyWith(fontSize: 13)),
                                    Text(numberRupiah.format(quantity * int.parse(widget.products['price'])), style: blackFontStyle2.copyWith(fontSize: 18)),
                                  ],
                                ),
                                SizedBox(
                                    width: 163,
                                    height: 45,
                                    child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
                                      UserModel user = (userState as UserLoaded).user;
                                      if (userState is UserLoaded) {
                                        return CustomElevatedButton(
                                          title: 'Order Now',
                                          colorButton: mainColor,
                                          onPressed: () async {
                                            //>ALERT DIALOG
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    backgroundColor: Colors.white,
                                                    child: Container(
                                                      padding: EdgeInsets.all(20.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Container(padding: EdgeInsets.all(10.0), child: Text('Check Your History Order', style: blackFontStyle2)),
                                                          SizedBox(height: 26),
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                CustomElevatedButton(
                                                                  title: 'Yes',
                                                                  colorButton: mainColor,
                                                                  width: 100,
                                                                  onPressed: () async {
                                                                    Order order = Order(
                                                                      userID: user.id,
                                                                      userName: user.name,
                                                                      userEmail: user.email,
                                                                      product: widget.products['name'],
                                                                      quantity: quantity.toString(),
                                                                      totalPrice: numberRupiah.format(quantity * int.parse(widget.products['price'])),
                                                                      picture: widget.products['image'],
                                                                      time: DateTime.now(),
                                                                      status: "pending",
                                                                    );

                                                                    await OrderServices.saveOrder(order);

                                                                    print('tap order now - Yes');

                                                                    await canLaunch(
                                                                            "whatsapp://send?phone=+6282110992625&text=Email : ${userState.user.email} \n\n I want buy ${widget.products['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products['price']))}")
                                                                        ? launch(
                                                                            "whatsapp://send?phone=+6282110992625&text=Email : ${userState.user.email} \n\n I want buy ${widget.products['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products['price']))}")
                                                                        : showCustomSnackBar(context);

                                                                    openWhatsapp(
                                                                        number: "+6282110992625",
                                                                        message:
                                                                            "Email : ${userState.user.email} \n\n I want buy ${widget.products['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products['price']))}");

                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                                CustomElevatedButton(
                                                                  title: 'No',
                                                                  colorButton: mainColor,
                                                                  width: 100,
                                                                  onPressed: () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });

                                            // Order order = Order(
                                            //   userID: user.id,
                                            //   userName: user.name,
                                            //   userEmail: user.email,
                                            //   product:
                                            //       widget.products.data['name'],
                                            //   quantity: quantity.toString(),
                                            //   totalPrice: numberRupiah.format(
                                            //       quantity *
                                            //           int.parse(widget.products
                                            //               .data['price'])),
                                            //   picture:
                                            //       widget.products.data['image'],
                                            //   time: DateTime.now(),
                                            //   status: "pending",
                                            // );

                                            // await OrderServices.saveOrder(
                                            //     order);

                                            print('tap order now');

                                            // await canLaunch(
                                            //         "whatsapp://send?phone=+6282110992625&text=Email : ${userState.user.email} \n\n I want buy ${widget.products.data['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products.data['price']))}")
                                            //     ? launch(
                                            //         "whatsapp://send?phone=+6282110992625&text=Email : ${userState.user.email} \n\n I want buy ${widget.products.data['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products.data['price']))}")
                                            //     : showCustomSnackBar(context);

                                            // openWhatsapp(
                                            //     number: "+6282110992625",
                                            //     message:
                                            //         "Email : ${userState.user.email} \n\n I want buy ${widget.products.data['name']} \n\n Quantity : ${quantity.toString()} \n\n Total Price : ${numberRupiah.format(quantity * int.parse(widget.products.data['price']))}");
                                          },
                                        );
                                      } else {
                                        return LoadingIndicator();
                                      }
                                    })),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ListView(
          //   children: [
          //     Text(
          //       products.data['name'],
          //       style: TextStyle(
          //         fontSize: 40,
          //       ),
          //     ),
          //     Text(
          //       'Decsription: ${products.data['description']}',
          //       style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          //     ),
          //     SizedBox(height: 20),
          //     Text(
          //       "Price: ${products.data['price']}",
          //       style: TextStyle(
          //           fontSize: 18, decoration: TextDecoration.underline),
          //     ),
          //     Text(
          //       "Options: ${products.data['option'].join(',')}",
          //       style: TextStyle(
          //           fontSize: 18, decoration: TextDecoration.underline),
          //     ),
          //     Text(
          //       "Ratings: ${products.data['rating'].join(',')}",
          //       style: TextStyle(
          //           fontSize: 18, decoration: TextDecoration.underline),
          //     ),
          //     Column(
          //       children: [
          //         Container(
          //           height: 100,
          //           width: 100,
          //           child: BlocBuilder<UserBloc, UserState>(
          //               builder: (_, userState) {
          //             if (userState is UserLoaded) {
          //               return RaisedButton(
          //                   onPressed: () {
          //                     openWhatsapp(
          //                         number: "+6282110992625",
          //                         message:
          //                             "I want buy this ${products.data['name']} \n email : ${userState.user.email}");
          //                   },
          //                   child: Text("Order Now"));
          //             } else {
          //               return LoadingIndicator();
          //             }
          //           }),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
