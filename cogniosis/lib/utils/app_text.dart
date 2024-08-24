import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class Text10 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text10({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 10.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.grey_color,
      ),
    );
  }
}

class Text12 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text12({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.grey_color,
      ),
    );
  }
}

class Text14 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text14({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.grey_color,
      ),
    );
  }
}

class Text15 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text15({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 15.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.grey_color,
      ),
    );
  }
}

class Text16 extends StatelessWidget {
  String text;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  int? maxLines;
  Color? color;
  TextOverflow? overflow;
  Text16({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.green_color,
      ),
    );
  }
}

class Text17 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text17({
    super.key,
    this.fontWeight,
    this.color,
    this.maxLines,
    required this.text,
    this.overflow,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 17.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.black_color,
      ),
    );
  }
}

class Text18 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text18({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.black_color,
      ),
    );
  }
}

class Text20 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;

  TextOverflow? overflow;
  int? maxLines;
  Text20({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: color ?? AppColors.black_color,
      ),
    );
  }
}

class Text22 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text22({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 22.sp,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? AppColors.white_color,
      ),
    );
  }
}

class Text24 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  Color? color;
  int? maxLines;
  TextOverflow? overflow;
  Text24({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 24.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.black_color,
      ),
    );
  }
}

class Text26 extends StatelessWidget {
  String text;
  TextAlign? textAlign;
  FontWeight? fontWeight;
  int? maxLines;
  Color? color;
  TextOverflow? overflow;
  Text26({
    super.key,
    this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.textAlign,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontFamily: "Poppins",
        fontSize: 26.sp,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color ?? AppColors.black_color,
      ),
    );
  }
}
