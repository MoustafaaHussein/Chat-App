import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/screens/LoginPage.dart';
import 'package:chatapp/screens/RegisterationPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/ChatPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => RegisterView(),
        chatPage.id: (context) => chatPage(),
      },
      initialRoute: LoginView.id,
    );
  }
}
