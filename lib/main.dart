import 'package:flutter/material.dart';
import 'package:pintrestt/presentation/mainscreen/components/mainscreen.dart';
import 'package:pintrestt/presentation/mainscreen/resourses/pages/homescreen.dart';
import 'package:pintrestt/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(


      ),
      home: MainScreen(),
    );
  }
}
