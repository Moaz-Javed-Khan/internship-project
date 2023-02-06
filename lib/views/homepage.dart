import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/bloc/theme_bloc.dart';
import 'package:internship_project/views/list_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sample"),
            actions: [
              // Icon(state ? Icons.sunny : Icons.brightness_2),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AnimatedCrossFade(
                  firstChild: const Icon(Icons.sunny),
                  secondChild: const Icon(Icons.brightness_2),
                  crossFadeState: state
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1200),
                ),
              )
            ],
          ),
          drawer: const ListWidget(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image.jpg'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: pressed ? Colors.blue : Colors.amber),
                  onPressed: () {
                    setState(() {
                      pressed = true;
                    });
                  },
                  child: const Text("Press to change Color"),
                ),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  state ? 'DarkMode' : 'LightMode',
                  style: TextStyle(
                    fontSize: 30,
                    color: state ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Switch(
                  value: state,
                  onChanged: (_) =>
                      context.read<ThemeBloc>().add(ThemeToggled()),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
