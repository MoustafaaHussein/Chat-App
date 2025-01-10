import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String displayText;
  final Color textColor;
  final double fontSize;
  VoidCallback? onTap;
  CustomButton(
      {super.key,
      this.onTap,
      required this.displayText,
      required this.textColor,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          width: double.infinity,
          child: Center(
            child: TextWidget(
                data: displayText,
                textColor: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
