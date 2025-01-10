import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';

void showStatusMessage(BuildContext context, String statusMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Center(
        child: TextWidget(
          data: statusMessage,
          textColor: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}
