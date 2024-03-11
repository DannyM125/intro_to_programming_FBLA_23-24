import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/util/Course.dart';

/// A class for calculating GPA based on different methods.
class GPACalculation {
  //static Color lightAccent = Color.fromRGBO(173, 223, 255, 1);
  static Color primary = Colors.blue;
  static Color darkBlue1 = Color.fromRGBO(9, 12, 155, 1);

  //GPA calculation methods:

  /// Calculates the unweighted GPA.
  ///
  /// This method takes four lists of courses corresponding to each grade level
  /// (9th, 10th, 11th, and 12th grades) and calculates the unweighted GPA
  /// based on the grades and credits of the courses.
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

  /// Calculates the weighted GPA.
  ///
  /// This method takes four lists of courses corresponding to each grade level
  /// (9th, 10th, 11th, and 12th grades) and calculates the weighted GPA
  /// based on the grades, credits, and type of courses (Honors, AP, Dual Enrollment).
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
          if (course.type == 'Honors')
            totalPoints +=
                (gradeToPointUW(course.grade) + 0.25) * course.credits;
          else if (course.type == 'AP' || course.type == 'Dual Enrollment')
            totalPoints +=
                (gradeToPointUW(course.grade) + 0.5) * course.credits;
          else
            totalPoints += gradeToPointUW(course.grade) * course.credits;
          totalCredits += course.credits;
        }
      }
    }
    print("${totalPoints}/${totalCredits}");
    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  /// Converts a letter grade to its corresponding point value.
  ///
  /// This method takes a letter grade as input and returns its corresponding
  /// unweighted point value based on the standard GPA scale.
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
