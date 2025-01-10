// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/helper/snackBar.dart';
import 'package:chatapp/screens/ChatPage.dart';
import 'package:chatapp/screens/RegisterationPage.dart';
import 'package:chatapp/widgets/CustomButtomWidget.dart';
import 'package:chatapp/widgets/TextFieldWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class LoginView extends StatefulWidget {
  static String id = 'LoginPage';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? loginEmail;

  String? loginPassowrd;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey();
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          body: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff2B475E),
              Color.fromARGB(255, 4, 35, 59),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset('assets/images/scholar.png', height: 100),
              Center(
                child: TextWidget(
                  data: 'Scholar chat',
                  textColor: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: TextWidget(
                    data: 'Sign in',
                    textColor: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.normal),
              ),
              TextFieldWidget(
                onChanged: (data) {
                  loginEmail = data;
                },
                obsecureText: false,
                labelText: 'Email or Username',
                hintText: 'Email',
                color: Colors.white,
                iconColor: Colors.white,
                suffixIcon: Icons.email,
              ),
              TextFieldWidget(
                onChanged: (data) {
                  loginPassowrd = data;
                },
                obsecureText: true,
                labelText: ' Password',
                hintText: ' Password',
                color: Colors.white,
                iconColor: Colors.white,
                suffixIcon: Icons.lock,
              ),
              CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await userLogin();
                        Navigator.popAndPushNamed(context, chatPage.id,
                            arguments: loginEmail);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          showStatusMessage(context,
                              'Wrong Password Please try using Correct Passowrd ');
                        } else if (e.code == 'user-not-found') {
                          showStatusMessage(context, 'Plase check your email ');
                        } else {
                          showStatusMessage(context, 'Login successfully');
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  displayText: 'Login',
                  textColor: const Color.fromARGB(255, 2, 50, 88),
                  fontSize: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                      data: 'Don\'t have an account ?',
                      textColor: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterView.id);
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white,
                        decorationThickness: 1.5,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<void> userLogin() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential userData = await auth.signInWithEmailAndPassword(
        email: loginEmail!, password: loginPassowrd!);
  }
}
