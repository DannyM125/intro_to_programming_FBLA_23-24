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
  // void initState() {
  //   getUWGPA();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: StatisticsScreen(uwGPA, wGPA), //! fix this
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  void getUWGPA() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve JSON string from SharedPreferences
    String? jsonString = prefs.getString('uwGPA');

    // Parse JSON string to a Map
    Map<String, dynamic>? gpaMap =
        jsonString != null ? json.decode(jsonString) : null;

    // Check if the GPA exists in the map and assign it to uwGPA
    if (gpaMap != null && gpaMap.containsKey('uwGPA')) {
      uwGPA = gpaMap['uwGPA']; // Parse the value from the map
    }
  }
}
