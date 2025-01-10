import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Color color;
  final IconData suffixIcon;
  final Color iconColor;
  final bool obsecureText;
  Function(String)? onChanged;
  TextFieldWidget(
      {super.key,
      this.onChanged,
      required this.obsecureText,
      required this.labelText,
      required this.hintText,
      required this.color,
      required this.iconColor,
      required this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'Empty field';
          }
        },
        obscureText: obsecureText,
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(color: color),
          suffixIcon: Icon(
            suffixIcon,
            size: 20,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
