import 'package:flutter/material.dart';

import '../utils/custom_color.dart';
import 'custom_theme/elevated_button_theme.dart';
import 'custom_theme/inputdecoration_field.dart';
import 'custom_theme/text_theme.dart';
class Congniosis{
  Congniosis._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: CustomColor.blueColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CogniosisTextTheme.lightTextTheme,
    elevatedButtonTheme: CogniosisEBT.lightElevatedButtonTheme,
    inputDecorationTheme: CustomInputDecoration.inputDecorationTheme,
    //bottomSheetTheme: BottomSheetTheme.BottomSheetLightTheme,
  );

}