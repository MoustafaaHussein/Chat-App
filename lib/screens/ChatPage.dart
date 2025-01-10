// ignore_for_file: file_names
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/screens/models/messagesModel.dart';
import 'package:chatapp/widgets/chatBubbleWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Color kprimaryColor = const Color(0xff2B475E);

class chatPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String? submittedText;
  // reading data from database using the next line as the messages will access the collection called ' messages' or creating a new collection with new refrence
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  static String id = 'ChatPage';
  final ScrollController _controller = ScrollController();

  chatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var loginEmail = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Messagesmodel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Messagesmodel.fromjson(snapshot.data!.docs[i]));
              // for loop to store the data inside the list
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                automaticallyImplyLeading: true,
                backgroundColor: kprimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      height: 80,
                      'assets/images/scholar.png',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextWidget(
                      data: 'Chat',
                      textColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontFamily: 'Pacifico',
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == loginEmail
                            ? chatBubbleWidget(message: messagesList[index])
                            : chatBubbleSecondUser(
                                message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 210, 209, 209),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (data) {
                          addMessage(data, loginEmail);
                          controller.clear();
                          _scrollDown();
                        },
                        showCursor: true,
                        decoration: InputDecoration(
                            suffixIconColor: Colors.black,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send,
                                  )),
                            ),
                            hintText: 'Enter your Message here...',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('loading......');
          }
        });
  }

  void addMessage(String data, var loginEmail) {
    messages.add({
      'message': data,
      kCreatedAt: DateTime.now(),
      'id': loginEmail,
    });
  }

  void _scrollDown() {
    _controller.animateTo(
      0,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
