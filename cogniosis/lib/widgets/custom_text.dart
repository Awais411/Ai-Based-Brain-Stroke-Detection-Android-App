import 'package:cogniosis/utils/basic_screen_imports.dart';


class CustomText extends StatelessWidget {
  final String firstPart;
  final String secondPart;
  final TextStyle? firstPartStyle;
  final TextStyle? secondPartStyle;

  const CustomText({
    super.key,
    required this.firstPart,
    required this.secondPart,
    this.firstPartStyle,
    this.secondPartStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: firstPart,
        style: firstPartStyle ?? Theme.of(context).textTheme.headlineLarge?.copyWith(color: CustomColor.blackColor, fontSize: Dimensions.heading24),
        children: [
          TextSpan(
            text: secondPart,
            style: secondPartStyle ??
                Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.blue,
                  fontSize: Dimensions.heading24,// Default color for second part
                ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
