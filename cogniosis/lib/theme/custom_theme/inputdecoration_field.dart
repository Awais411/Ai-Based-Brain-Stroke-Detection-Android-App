import 'package:cogniosis/utils/basic_screen_imports.dart';

class CustomInputDecoration {
  CustomInputDecoration._();

  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFD9D9D9), // Fill color D9D9D9
    hintStyle: const TextStyle(
      color: Color(0xFF7D7474),
      fontSize: 14.0, // Hint color 7D7474
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.radiusMedium+5),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // Content padding
  );
}
