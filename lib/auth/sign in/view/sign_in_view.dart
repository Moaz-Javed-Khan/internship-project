import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:internship_project/auth/auth.dart';
import 'package:internship_project/auth/sign%20up/view/sign_up_view.dart';
import 'package:internship_project/homepage.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
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
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Enter Name correctly";
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
                controller: userPasswordController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Enter Name correctly";
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

                  try {
                    final User? firebaseUser =
                        (await FirebaseAuth.instance.signInWithEmailAndPassword(
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
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
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
    );
  }
}
