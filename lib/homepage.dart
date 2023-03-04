import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internship_project/auth/sign%20in/view/sign_in_view.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/dark_mode/bloc/theme_bloc.dart';
import 'package:internship_project/cart/view/cart_view.dart';
import 'package:internship_project/favorites/view/favorites_view.dart';
import 'package:internship_project/models/cart_item_model.dart';
import 'package:internship_project/products/view/product_view.dart';
// import 'package:internship_project/widgets/badge.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  final CartViewState cartViewInstance = CartViewState();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
    });
  }

  bool pressed = false;
  int _index = 0;

  final screen = [
    const ProductPage(),
    const FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                onTabChange: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                backgroundColor: Colors.orange,
                color: Colors.white,
                tabBackgroundColor: Colors.white,
                activeColor: Colors.black,
                padding: const EdgeInsets.all(16),
                gap: 12,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const GButton(
                    icon: Icons.home,
                    text: "Home",
                  ),
                  const GButton(
                    icon: Icons.favorite,
                    text: "Favorites",
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text("E-commerce App"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 12),
                child: Badge(
                  // label: const Text("0"),
                  label: Text(
                      context.watch<CartBloc>().state.item.length.toString()),
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartView(),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Icon(state ? Icons.sunny : Icons.brightness_2),
              Padding(
                padding: const EdgeInsets.only(top: 18.0, right: 10),
                child: GestureDetector(
                  onTap: () => context.read<ThemeBloc>().add(ThemeToggled()),
                  child: AnimatedCrossFade(
                    firstChild: const Icon(Icons.sunny),
                    secondChild: const Icon(Icons.brightness_2),
                    crossFadeState: state
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 1200),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInView(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // drawer: const ListWidget(),
          body: screen[_index],
        );
      },
    );
  }
}



// Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset('assets/image.jpg'),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: pressed ? Colors.blue : Colors.amber),
//                   onPressed: () {
//                     setState(() {
//                       pressed = true;
//                     });
//                   },
//                   child: const Text("Press to change Color"),
//                 ),
//                 const Text(
//                   'You have pushed the button this many times:',
//                 ),
//                 Text(
//                   '$_counter',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 Text(
//                   state ? 'DarkMode' : 'LightMode',
//                   style: TextStyle(
//                     fontSize: 30,
//                     color: state ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 12,
//                 ),
//                 Switch(
//                   value: state,
//                   onChanged: (_) =>
//                       context.read<ThemeBloc>().add(ThemeToggled()),
//                 ),
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: _incrementCounter,
//             tooltip: 'Increment',
//             child: const Icon(Icons.add),
//           ),