part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int initialPage;

  MainPage({this.initialPage = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    selectedPage = widget.initialPage;
    pageController = PageController(
      initialPage: widget.initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            SafeArea(
              child: Container(
                color: "FAFAFC".toColor(),
              ),
            ),
            SafeArea(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                },
                children: [
                  Center(
                    child: CoffeePage(),
                  ),
                  Center(
                    child: OrderHistoryPage(),
                  ),
                  Center(
                    child: ProfilePage(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonNavBar(
                selectedIndex: selectedPage,
                onTap: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                  pageController.jumpToPage(selectedPage);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
