import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/StatsPage.dart';
import 'CoursePage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StatisticsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}