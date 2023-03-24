import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:internship_project/auth/auth.dart';
import 'package:internship_project/auth/sign%20up/view/sign_up_view.dart';
import 'package:internship_project/homepage.dart';

class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObscure = true;

  emptyTextFieldSnackbar() {
    final snackBar = SnackBar(
      content: const Text('Fill Text Field Please!'),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.orange,
      ),
      body: Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: userEmailController,
                  validator: (value) {
                    if (value == null) return "Enter Email";
                    if (value.isEmpty ||
                        !RegExp(
                          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                        ).hasMatch(value)) {
                      return "Enter Email correctly";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade100,
                    labelText: 'Email',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  obscureText: isObscure,
                  controller: userPasswordController,
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                        ).hasMatch(value)) {
                      return "Enter Password correctly";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: isObscure
                          ? const Icon(
                              Icons.visibility,
                            )
                          : const Icon(
                              Icons.visibility_off,
                            ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.orange.shade100,
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    var loginEmail = userEmailController.text.trim();
                    var loginPassword = userPasswordController.text.trim();

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing')),
                      );
                      try {
                        final User? firebaseUser = (await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                          email: loginEmail,
                          password: loginPassword,
                        ))
                            .user;
                        if (firebaseUser != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } else {
                          print('Retry');
                        }
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }
                    }

                    // if (loginEmail == "" || loginPassword == '') {
                    //   return emptyTextFieldSnackbar();
                    // } else {
                    //   try {
                    //     final User? firebaseUser = (await FirebaseAuth.instance
                    //             .signInWithEmailAndPassword(
                    //       email: loginEmail,
                    //       password: loginPassword,
                    //     ))
                    //         .user;
                    //     if (firebaseUser != null) {
                    //       // ignore: use_build_context_synchronously
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const HomePage(),
                    //         ),
                    //       );
                    //     } else {
                    //       print('Retry');
                    //     }
                    //   } on FirebaseAuthException catch (e) {
                    //     print("Error $e");
                    //   }
                    // }
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Login"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpView(),
                      ),
                    );
                  },
                  child: const Text("Don't Have an account"),
                ),
                SignInButton(
                  Buttons.GoogleDark,
                  text: "Sign up with Google",
                  onPressed: () => AuthService().signInWithGoogle(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
