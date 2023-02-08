import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:internship_project/bloc/theme_bloc.dart';
import 'package:internship_project/views/cart_view.dart';
import 'package:internship_project/views/favorites_view.dart';
import 'package:internship_project/widgets/list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
    const CartView(),
    const FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                onTabChange: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                backgroundColor: Colors.black,
                color: Colors.white,
                tabBackgroundColor: Colors.grey,
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
            title: const Text("E-commerce App"),
            actions: [
              // Icon(state ? Icons.sunny : Icons.brightness_2),
              Padding(
                padding: const EdgeInsets.all(12.0),
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
              )
            ],
          ),
          drawer: const ListWidget(),
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