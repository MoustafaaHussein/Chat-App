import 'package:chatapp/helper/snackBar.dart';
import 'package:chatapp/widgets/CustomButtomWidget.dart';
import 'package:chatapp/widgets/TextFieldWidget.dart';
import 'package:chatapp/widgets/textWidget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

FirebaseAuth auth = FirebaseAuth.instance;
bool isLoading = false;

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  RegisterView({super.key});
  static String id = 'RegisterationPage';

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 1, 53, 77),
                      Color.fromARGB(255, 0, 4, 40),
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/scholar.png', height: 100),
                      TextWidget(
                        data: 'Scholar chat',
                        textColor: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pacifico',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextWidget(
                          data: 'Sign Up',
                          textColor: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 30),
                      TextFieldWidget(
                        obsecureText: false,
                        onChanged: (data) {
                          email = data;
                        },
                        labelText: 'Email',
                        hintText: 'Email',
                        color: Colors.white,
                        iconColor: Colors.white,
                        suffixIcon: Icons.email,
                      ),
                      TextFieldWidget(
                        obsecureText: false,
                        labelText: 'Confirm Email',
                        hintText: 'Confirm Email',
                        color: Colors.white,
                        iconColor: Colors.white,
                        suffixIcon: Icons.email,
                      ),
                      TextFieldWidget(
                        onChanged: (data) {
                          password = data;
                        },
                        obsecureText: true,
                        labelText: 'Password',
                        hintText: 'Password',
                        color: Colors.white,
                        iconColor: Colors.white,
                        suffixIcon: Icons.lock,
                      ),
                      TextFieldWidget(
                        obsecureText: true,
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
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
                                await registerUser();
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'email-already-in-use') {
                                  // ignore: use_build_context_synchronously
                                  showStatusMessage(context,
                                      'The email address is already in use by another account.');
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showStatusMessage(
                                      context, 'Account created sucessfully');
                                }
                              } catch (e) {
                                showStatusMessage(
                                    context, 'there was an error');
                              }
                              isLoading = false;
                              setState(() {});
                            } else {}
                          },
                          displayText: 'Register',
                          textColor: const Color.fromARGB(255, 2, 50, 88),
                          fontSize: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              data: 'Already Have an Account ?',
                              textColor: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Login',
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential userData = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
