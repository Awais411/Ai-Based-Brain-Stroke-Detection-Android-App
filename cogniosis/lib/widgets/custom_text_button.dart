import 'package:flutter/material.dart';
import '../utils/custom_color.dart'; // Adjust the import according to your project structure

class CustomTextButton extends StatelessWidget {
  final String firstPart;
  final String secondPart;
  final TextStyle? firstPartStyle;
  final TextStyle? secondPartStyle;
  final VoidCallback onPressed;

  const CustomTextButton({
    super.key,
    required this.firstPart,
    required this.secondPart,
    required this.onPressed,
    this.firstPartStyle,
    this.secondPartStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text.rich(
        TextSpan(
          text: firstPart,
          style: firstPartStyle ?? Theme.of(context).textTheme.bodySmall,
          children: [
            TextSpan(
              text: secondPart,
              style: secondPartStyle ??
                  Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CustomColor.blackColor,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
