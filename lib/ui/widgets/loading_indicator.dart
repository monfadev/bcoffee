part of 'widgets.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 45,
      color: mainColor,
    );
  }
}
