import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:internship_project/auth/auth.dart';
import 'package:internship_project/auth/sign%20in/view/sign_in_view.dart';
import 'package:internship_project/auth/sign%20up/view/signup.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  TextEditingController userNameController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();

  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                "assets/logo.png",
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: userNameController,
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
                  labelText: 'Full name',
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
              TextFormField(
                controller: userEmailController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
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
              const SizedBox(height: 30),
              TextFormField(
                controller: userPhoneController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Enter Phone Number correctly";
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
                  labelText: 'Phone Number',
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
              TextFormField(
                controller: userPasswordController,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    return "Enter Password correctly";
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
                onPressed: () {
                  var userName = userNameController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userPassword = userPasswordController.text.trim();

                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                        email: userEmail,
                        password: userPassword,
                      )
                      .then((value) => {
                            log("user created"),
                            signUpUser(
                              userName,
                              userEmail,
                              userPhone,
                              userPassword,
                            ),
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInView(),
                              ),
                            ),
                          });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text("Sign up"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInView(),
                    ),
                  );
                },
                child: const Text("Already Have an account"),
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
