import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ValidatorFunction = String? Function(String? value);
typedef OnChangeFunction = String? Function(String? value);

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.hintText, this.disabled,  this.validator, this.onChange, this.controller, this.inputType, this.obsecureText, this.letterSpacing, this.horizPadding, this.fontSize, this.txtColor});
  String hintText;
  TextEditingController? controller;
  TextInputType? inputType;
  bool? obsecureText;
  double? letterSpacing;
  double? fontSize;
  Color? txtColor;
  double? horizPadding;
  final ValidatorFunction? validator;
  final OnChangeFunction? onChange;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizPadding ?? 10, vertical: 10),
      child: TextFormField(
        enabled: disabled == true ? false : true,
        onChanged: onChange,
        validator: validator,
        cursorColor: txtColor ?? const Color(0xff232323),
        keyboardType: inputType ?? TextInputType.text,
        controller: controller,
        obscureText: obsecureText ?? false,
        //style: TextStyle(fontSize: fontSize ?? 12, color: txtColor ?? const Color(0xff232323), letterSpacing: letterSpacing ?? 0),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: fontSize ?? 12, color: txtColor ?? const Color(0xff232323), letterSpacing: letterSpacing ?? 0),
            errorStyle: const TextStyle(fontSize: 12, color: Color(0xffff2400), fontWeight: FontWeight.w300),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(40)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black45,
                  width: 1
                ),
                borderRadius: BorderRadius.circular(40)
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black45,
                    width: 1
                ),
                borderRadius: BorderRadius.circular(40)
            ),
        ),
      ),
    );
  }
}
