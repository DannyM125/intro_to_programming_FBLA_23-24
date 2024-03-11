/**
 * Main class to run the application.
 */
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/StatsPage.dart';
import 'package:intro_to_programming_fbla/util/AppColors.dart';
import 'package:intro_to_programming_fbla/util/Course.dart';
import 'package:intro_to_programming_fbla/util/GPACalculation.dart';
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

/**
 * Main application widget.
 */
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

/**
 * Main application state.
 */
class _MyAppState extends State<MyApp> {
  double uwGpa = 0.0, wGpa = 0.0;

  @override
  void initState() {
    super.initState();
    loadGpa();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: StatisticsScreen(uwGpa, wGpa),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  /**
   * Loads GPA data from SharedPreferences.
   */
  Future<void> loadGpa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Course_9> courses9 = [];
    List<Course_10> courses10 = [];
    List<Course_11> courses11 = [];
    List<Course_12> courses12 = [];

    List<String>? coursesJson = prefs.getStringList('courses_9');
    if (coursesJson != null) {
      List<Course_9> loadedCourses = coursesJson
          .map((json) => Course_9.fromJson(jsonDecode(json)))
          .toList();
      courses9 = loadedCourses;
    }

    coursesJson = prefs.getStringList('courses_10');
    if (coursesJson != null) {
      List<Course_10> loadedCourses = coursesJson
          .map((json) => Course_10.fromJson(jsonDecode(json)))
          .toList();
      courses10 = loadedCourses;
    }

    coursesJson = prefs.getStringList('courses_11');
    if (coursesJson != null) {
      List<Course_11> loadedCourses = coursesJson
          .map((json) => Course_11.fromJson(jsonDecode(json)))
          .toList();
      courses11 = loadedCourses;
    }

    coursesJson = prefs.getStringList('courses_12');
    if (coursesJson != null) {
      List<Course_12> loadedCourses = coursesJson
          .map((json) => Course_12.fromJson(jsonDecode(json)))
          .toList();
      courses12 = loadedCourses;
    }

    setState(() {
      uwGpa = GPACalculation.calculateUWGPA(
          courses9, courses10, courses11, courses12);
      wGpa = GPACalculation.calculateWeightedGPA(
          courses9, courses10, courses11, courses12);
    });
  }
}