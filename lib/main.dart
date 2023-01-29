import 'package:scorpion_plus/screens/auth/login_screen.dart';
import 'package:scorpion_plus/screens/home_screen.dart';
import 'package:flutter/material.dart';

late Size mq;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scorpion+',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.normal, fontSize: 19),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
          )),
      home: const LoginScreen(),
      routes: {
        HomeScreen.routeName: (_) => HomeScreen()
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}