import 'package:flutter/material.dart';
import 'customText.dart';
class CustomButton extends StatelessWidget {
  final double padding;
  final String text;
  final double buttonHeight;
  final double textSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Color borderColor;
  final Color buttonColor;
  final double borderWidth;
  final VoidCallback onPress;
  final double buttonWidht;

  const CustomButton(
      {Key? key,
      required this.padding,
      required this.text,
      required this.buttonHeight,
      required this.textSize,
      required this.fontWeight,
      required this.textColor,
      required this.borderColor,
      required this.buttonColor,
      required this.borderWidth,
      required this.onPress, required this.buttonWidht})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: InkWell(
        onTap: () => onPress(),
        child: Container(
          height: buttonHeight,
          width: buttonWidht,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Center(
              child: CustomText(
                  text: text,
                  textSize: textSize,
                  fontWeight: fontWeight,
                  textColor: textColor)),
        ),
      ),
    );
  }
}
