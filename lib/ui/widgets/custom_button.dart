part of 'widgets.dart';

class CustomButton extends StatelessWidget {
  final Widget child;

  const CustomButton({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 24),
      height: 45,
      padding: EdgeInsets.symmetric(
        horizontal: defaultMargin,
      ),
      child: child,
    );
  }
}
