part of 'widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color colorButton;
  final Color colorTitle;
  final Function onPressed;

  CustomElevatedButton({
    this.title,
    this.width,
    this.height = 45,
    this.colorButton,
    this.colorTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width == null) ? MediaQuery.of(context).size.width : width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: colorButton,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            title,
            style: whiteFontStyle.copyWith(
              fontSize: 16,
              color: colorTitle,
            ),
          ),
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          }),
    );
  }
}
