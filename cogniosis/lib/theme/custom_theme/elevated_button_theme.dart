

import '../../utils/basic_screen_imports.dart';

class CogniosisEBT{
  CogniosisEBT._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      padding: EdgeInsets.all(Dimensions.paddingSize),
      foregroundColor: CustomColor.whiteColor,
      backgroundColor: CustomColor.lightBlue,
      disabledBackgroundColor: CustomColor.greyColor,
      textStyle: GoogleFonts.reemKufiFun(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge+7))),
    ),
  );
}