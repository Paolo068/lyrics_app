import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final FontStyle? fontStyle;
  final Color textColor;
  const CustomText({super.key,  required this.text, required this.textSize, required this.fontWeight, required this.textColor, this.fontStyle});

  @override
  Widget build(BuildContext context) {
    return Text(text , style: TextStyle(
        fontSize: textSize,
        fontWeight: fontWeight,
        color: textColor,
        fontStyle: fontStyle,
    ),);
  }
}