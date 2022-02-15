part of 'widgets.dart';

class CustomButtonNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  const CustomButtonNavBar({
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ItemButtonNavBar(
            onTap: () {
              if (onTap != null) {
                onTap(0);
              }
            },
            imageString: 'assets/ic_home' +
                ((selectedIndex == 0) ? '.png' : '_normal.png'),
          ),
          ItemButtonNavBar(
            margin: EdgeInsets.symmetric(
              horizontal: 83,
            ),
            onTap: () {
              if (onTap != null) {
                onTap(1);
              }
            },
            imageString: 'assets/ic_order' +
                ((selectedIndex == 1) ? '.png' : '_normal.png'),
          ),
          ItemButtonNavBar(
            onTap: () {
              if (onTap != null) {
                onTap(2);
              }
            },
            imageString: 'assets/ic_profile' +
                ((selectedIndex == 2) ? '.png' : '_normal.png'),
          ),
        ],
      ),
    );
  }
}

class ItemButtonNavBar extends StatelessWidget {
  final Function onTap;
  final String imageString;
  final EdgeInsetsGeometry margin;

  const ItemButtonNavBar({
    Key key,
    this.onTap,
    this.imageString,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        margin: margin,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imageString,
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
