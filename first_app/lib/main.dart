import 'package:first_app/week3.dart';
import 'package:flutter/material.dart';
import 'greeting_widget.dart';
import 'package:first_app/form_regitration.dart';
import 'package:first_app/aqi_example/aqi_example.dart';
import 'package:first_app/AssignmentWeek5.dart';
import 'package:first_app/Assigmentweek5.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    home: const Assigmentweek5(),
    );
  }
}
