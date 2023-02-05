import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text(
                "Hello!",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/man.jpg'),
            ),
            const SizedBox(height: 10),
            const ListTile(
              title: Text(
                "My Account",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.account_box),
            ),
            const Divider(color: Colors.black),
            const ListTile(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              leading: Icon(Icons.home),
            ),
            const Divider(color: Colors.black),
          ],
        ),
      ),
    );
  }
}
