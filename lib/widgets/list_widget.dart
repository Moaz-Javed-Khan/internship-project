import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/bloc/theme_bloc.dart';
import 'package:internship_project/views/cart_view.dart';
import 'package:internship_project/views/product_view.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
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
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartView(),
                      ),
                    );
                  },
                  title: const Text(
                    "Cart",
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: const Icon(Icons.shopping_cart),
                ),
                const Divider(color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(state ? 'DarkMode' : 'LightMode'),
                    Switch(
                      value: state,
                      onChanged: (_) =>
                          context.read<ThemeBloc>().add(ThemeToggled()),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.read<ThemeBloc>().add(ThemeToggled()),
                      child: AnimatedCrossFade(
                        firstChild: const Icon(Icons.sunny),
                        secondChild: const Icon(Icons.brightness_2),
                        crossFadeState: state
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: const Duration(milliseconds: 1200),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.black),
              ],
            ),
          ),
        );
      },
    );
  }
}
