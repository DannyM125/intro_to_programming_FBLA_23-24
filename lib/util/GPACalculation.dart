import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/util/Course.dart';

class GPACalculation {
  //static Color lightAccent = Color.fromRGBO(173, 223, 255, 1);
  static Color primary = Colors.blue;
  static Color darkBlue1 = Color.fromRGBO(9, 12, 155, 1);

  //GPA calculation methods:

  static double calculateUWGPA(
      List<Course_9> course_9,
      List<Course_10> course_10,
      List<Course_11> course_11,
      List<Course_12> course_12) {
    List<List<Course>> allCourses = [course_9, course_10, course_11, course_12];
    double totalPoints = 0;
    double totalCredits = 0;

    for (List<Course> courseList in allCourses) {
      if (courseList.isNotEmpty) {
        for (var course in courseList) {
          totalPoints += gradeToPointUW(course.grade) * course.credits;
          totalCredits += course.credits;
        }
      }
    }

    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  //TODO this is identical to UW currently
  //TODO CHANGE THIS TO ACCOUNT FOR DE and AP
  static double calculateWeightedGPA(
      List<Course_9> course_9,
      List<Course_10> course_10,
      List<Course_11> course_11,
      List<Course_12> course_12) {
    List<List<Course>> allCourses = [course_9, course_10, course_11, course_12];

    double totalPoints = 0;
    double totalCredits = 0;

    for (List<Course> courseList in allCourses) {
      if (courseList.isNotEmpty) {
        for (var course in courseList) {
          totalPoints += gradeToPointUW(course.grade) * course.credits;
          totalCredits += course.credits;
        }
      }
    }

    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  static double gradeToPointUW(String grade) {
    switch (grade) {
      case 'A':
        return 4.0;
      case 'B+':
        return 3.5;
      case 'B':
        return 3.0;
      case 'C+':
        return 2.5;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }
}
