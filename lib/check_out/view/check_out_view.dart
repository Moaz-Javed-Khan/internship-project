import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/check_out/view/thank_you_view.dart';
import 'package:place_picker/place_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckOutView extends StatefulWidget {
  CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  TextEditingController userPhoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const apiKey = "AIzaSyB2QZnGBiObzvbnJHLs9vsxbLE_QNFeP_0";

  User? currentUser = FirebaseAuth.instance.currentUser;

  bool isLoading = true;

  // final userData = FirebaseFirestore.instance.collection("users").snapshots();

  // final name = snapshots.

// Future getDocs() async {
//   var docId = snapshot.data!.docs[index].id;
//   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").doc(docId);
//   for (int i = 0; i < querySnapshot.documents.length; i++) {
//     var a = querySnapshot.documents[i];
//     print(a.documentID);
//   }
// }

  // ignore: prefer_typing_uninitialized_variables
  // late final nameField;
  // ignore: prefer_typing_uninitialized_variables
  // late final phoneField;

  void getDataFromFirestore() async {
    setState(() {
      isLoading = false;
    });
    // Access a Firestore collection named 'myCollection'
    final myCollectionRef = FirebaseFirestore.instance.collection('users');

    // Retrieve all documents in the 'myCollection' collection
    final documents = await myCollectionRef
        .where('userId', isEqualTo: currentUser?.uid)
        .get();

    // Check if there is only one document returned
    if (documents.size == 1) {
      final userData = documents.docs[0].data();

      userNameController.text = userData['userName'];
      userPhoneController.text = userData['userPhone'];

      // nameField = userData['userName'];
      // phoneField = userData['userPhone'];

      // Do something with the specific field data
      // print('User ${currentUser?.uid}\'s specific field data is: $nameField');
      // print('User ${currentUser?.uid}\'s specific field data is: $phoneField');

      // userNameController.text = nameField;
      // userPhoneController.text = phoneField;
      userEmailController.text = currentUser?.email ?? '';
    } else {
      // Handle error case where either no documents or multiple documents are returned
      print(
          'Error: Found ${documents.size} documents for user ${currentUser?.uid}.');
    }
    setState(() {
      isLoading = true;
    });
  }

  void showPlacePicker() async {
    LocationResult? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(apiKey),
      ),
    );
    Text("Selected Location: $result");
    print(result);
  }

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

  // void getDataFromFirestore() async {
  //   final myCollectionRef = FirebaseFirestore.instance.collection('users');

  //   final documents = await myCollectionRef
  //       .where('userId', isEqualTo: currentUser?.uid)
  //       .get();

  //   if (documents.size == 1) {
  //     final userData = documents.docs[0].data();
  //     nameField = userData['userName'];
  //     phoneField = userData['userPhone'];

  //     print('User ${currentUser?.uid}\'s data is: $nameField');
  //     print('User ${currentUser?.uid}\'s data is: $phoneField');
  //   } else {
  //     print(
  //         'Error: Found ${documents.size} documents for user ${currentUser?.uid}.');
  //   }
  // }

  @override
  void initState() {
    getDataFromFirestore();

    // userNameController.text = nameField;
    // userPhoneController.text = phoneField;
    // userEmailController.text = currentUser?.email ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("name: $nameField");
    // print("number: $phoneField");
    print("Email: ${currentUser?.email}");

    getDataFromFirestore();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          TextFormField(
                            // autofillHints: const [AutofillHints.username],
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
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              filled: true,
                              fillColor: Colors.orange.shade100,
                              // hintText: 'Name',
                              labelText: 'Name',
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
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: userPhoneController,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r'^(?:[+0]9)?[0-9]{10,12}$')
                                      .hasMatch(value)) {
                                return "Enter Contact Number correctly";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              filled: true,
                              fillColor: Colors.orange.shade100,
                              labelText: 'Contact Number',
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
                          const SizedBox(height: 10),
                          TextFormField(
                            // autofillHints: [AutofillHints.email],
                            controller: userEmailController,
                            validator: (value) {
                              if (value!.isEmpty ||
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
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2.0),
                              ),
                              filled: true,
                              fillColor: Colors.orange.shade100,
                              // hintText: 'Name',
                              labelText: 'Email',
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Total: ${context.watch<CartBloc>().state.calculateTotal().toString()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Quantity: ${context.watch<CartBloc>().state.item.length}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        child: const Text("Pick Delivery location"),
                        onPressed: () {
                          showPlacePicker();
                        },
                      ),
                      // Text("Selected Location: $showPlacePicker"),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing')),
                            );

                            context.read<CartBloc>().add(const ClearCartItem());

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ThankYouView(),
                              ),
                            );
                          }

                          // if (userEmailController == "" ||
                          //     userEmailController == '' ||
                          //     userEmailController == '') {
                          //   return emptyTextFieldSnackbar();
                          // } else {
                          //   context.read<CartBloc>().add(const ClearCartItem());

                          //   Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const ThankYouView(),
                          //     ),
                          //   );
                          // }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(color: Colors.orange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Order Now'),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
