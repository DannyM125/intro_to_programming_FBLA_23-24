import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/StatsPage.dart';
import 'package:intro_to_programming_fbla/util/AppColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CoursePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ColorProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  double uwGPA = 0.0, wGPA = 0.0;

  // TODO
  void initState() {
    getUWGPA();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: StatisticsScreen(uwGPA, wGPA), // fix this
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void getUWGPA() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve JSON string from SharedPreferences
    String? jsonString = prefs.getString('uwGPA');

    if (jsonString != null) {
      String loadedString = jsonString.toString();
      uwGPA = double.parse(loadedString);
    } else {
      uwGPA = 0.0;
    }
  }
}
