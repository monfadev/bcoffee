part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            //> HEADER
            Container(
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Your Orders', style: blackFontStyle1),
                  Text('Wait for the best order',
                      style:
                          greyFontStyle.copyWith(fontWeight: FontWeight.w300)),
                ],
              ),
            ),
            //> BODY
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    title: ['Pending', 'Paid'],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                        print(selectedIndex);
                      });
                    },
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            if (selectedIndex == 0) InProgressPage() else PaidPage(),
                SizedBox(height: 50),
          ],
        ),
      ],
    );
  }
}
