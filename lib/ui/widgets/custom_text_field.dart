part of 'widgets.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextStyle hintStyle;
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget suffixIcon;
  final int maxLines;
  final String Function(String) validator;
  final double marginTop;
  final Color color;

  CustomTextField({
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.maxLines,
    this.validator,
    this.marginTop,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsets.fromLTRB(defaultMargin, marginTop, defaultMargin, 6),
          child: Text(
            labelText,
            style: blackFontStyle2,
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            keyboardType: keyboardType,
            style: blackFontStyle1.copyWith(fontSize: 15),
            maxLines: (maxLines != null) ? maxLines : 1,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: hintStyle,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
