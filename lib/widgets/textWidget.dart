// ignore: file_names
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextWidget extends StatelessWidget {
  final String data;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  String? fontFamily;

  TextWidget(
      {super.key,
      this.fontFamily,
      required this.data,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: 5,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: fontWeight,
        fontFamily: fontFamily,

        /*  fontStyle: F */
      ),
    );
  }
}
