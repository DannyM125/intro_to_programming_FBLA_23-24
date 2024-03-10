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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double uwGPA = 0.0, wGPA = 0.0;

  @override
  void initState() {
    super.initState();
    loadGPA();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: StatisticsScreen(uwGPA, wGPA),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> loadGPA() async {
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
      uwGPA = GPACalculation.calculateUWGPA(
          courses9, courses10, courses11, courses12);
      wGPA = GPACalculation.calculateWeightedGPA(
          courses9, courses10, courses11, courses12);
    });
  }
}
