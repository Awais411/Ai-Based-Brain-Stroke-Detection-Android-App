import 'package:cogniosis/utils/basic_screen_imports.dart';

class CogniosisTextTheme {
  CogniosisTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    ///h1
    headlineLarge: GoogleFonts.poppins(
      fontSize: Dimensions.headingTextSize1,
      fontWeight: FontWeight.w800,
      color: CustomColor.whiteColor,
    ),

    ///h2
    displayMedium: GoogleFonts.karla(
      fontSize: Dimensions.headingTextSize2,
      fontWeight: FontWeight.bold,
      color: CustomColor.blackColor,
    ),

    ///h3
    displaySmall: GoogleFonts.reemKufiFun(
      fontSize: Dimensions.heading24,
      fontWeight: FontWeight.bold,
      color: CustomColor.whiteColor,
    ),

    ///h4
    headlineMedium: GoogleFonts.karla(
      fontSize: Dimensions.headingTextSize4,
      fontWeight: FontWeight.bold,
      color: CustomColor.blackColor,
    ),
    ///h5 detect brain stroke!!!
    headlineSmall: GoogleFonts.leagueSpartan(
      fontSize: Dimensions.hTextSize3,
      fontWeight: FontWeight.w300,
      color: CustomColor.whiteColor,
    ) ,
    ///appbar
    titleMedium: GoogleFonts.poppins(
      fontSize: Dimensions.heading24,
      fontWeight: FontWeight.w900,
      color: Colors.black,
    ),
    ///p2
    bodyMedium: GoogleFonts.poppins(
      fontSize: Dimensions.headingTextSize3,
      color: Colors.white, // Other text color is white
    ),
    ///p3
    bodySmall: GoogleFonts.reemKufiFun(
      fontSize: Dimensions.headingTextSize3,
      color: Colors.white,
    ),
    ///button text
    labelLarge: GoogleFonts.poppins(
      fontSize: Dimensions.headingTextSize3,
      fontWeight: FontWeight.w400,
      color: CustomColor.whiteColor,
    ),
  );
}
