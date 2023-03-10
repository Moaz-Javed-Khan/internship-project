import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/dark_mode/bloc/theme_bloc.dart';
import 'package:internship_project/homepage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (coontext) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc()..add(CartItemInitial()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state;
    return MaterialApp(
      title: 'Intership Project',
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: MyHomePage(),
    );
  }
}
