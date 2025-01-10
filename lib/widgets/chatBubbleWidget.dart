// ignore_for_file: file_names

import 'package:chatapp/screens/ChatPage.dart';
import 'package:chatapp/screens/models/messagesModel.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';

class chatBubbleWidget extends StatelessWidget {
  final Messagesmodel message;

  const chatBubbleWidget({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: kprimaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
              data: message.message,
              textColor: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

class chatBubbleSecondUser extends StatelessWidget {
  final Messagesmodel message;

  const chatBubbleSecondUser({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        // alignment: Alignment.centerRight,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextWidget(
              data: message.message,
              textColor: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
