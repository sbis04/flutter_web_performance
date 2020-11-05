import 'package:flutter/material.dart';
import 'package:flutter_web_performance/screens/about_page.dart';
import 'package:flutter_web_performance/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'about': (_) => AboutPage(),
      },
    );
  }
}
