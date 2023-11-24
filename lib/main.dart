import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/Course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<String> letterGrades = ['A', 'B', 'C', 'D', 'F'];
  String selectedLetterGrade = 'A';
  List<int> gradeLevels = [9, 10, 11, 12];
  int selectedGradeLevel = 9;
  List<double> credits = [5.0, 2.5];
  double selectedCredits = 5.0;
  List<Course> courses = [];
  TextEditingController courseNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load courses from SharedPreferences when the widget is created.
    loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator'),
        leading: IconButton(
          icon: Icon(Icons.school),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StatisticsScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                DropdownButton<int>(
                  value: selectedGradeLevel,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedGradeLevel = newValue!;
                    });
                  },
                  items: gradeLevels.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text('Grade $value'),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16),
                Text(
                  'Add Course for Grade $selectedGradeLevel:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: courseNameController,
                    decoration: InputDecoration(
                      labelText: 'Course Name',
                    ),
                  ),
                ),
                SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedLetterGrade,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLetterGrade = newValue!;
                    });
                  },
                  items: letterGrades
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16),
                DropdownButton<double>(
                  value: selectedCredits,
                  onChanged: (double? newValue) {
                    setState(() {
                      selectedCredits = newValue!;
                    });
                  },
                  items: credits.map<DropdownMenuItem<double>>((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    addCourse();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Courses for Grade $selectedGradeLevel:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(courses[index].name),
                    subtitle: Text(
                      'Grade: ${courses[index].grade}, Credits: ${courses[index].credits}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        removeCourse(index);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'GPA: ${calculateGPA(selectedGradeLevel).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Weighted GPA: ${calculateWeightedGPA().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveCourses();
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void addCourse() {
    String courseName = courseNameController.text;
    if (courseName.isNotEmpty) {
      Course course = Course(
        name: courseName,
        grade: selectedLetterGrade,
        credits: selectedCredits,
      );
      setState(() {
        courses.add(course);
        courseNameController.text = '';
      });
      saveCourses(); // Save courses after adding a new course.
    }
  }

  void removeCourse(int index) {
    setState(() {
      courses.removeAt(index);
      saveCourses(); // Save courses after removing a course.
    });
  }

  void saveCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> coursesJson =
        courses.map((course) => jsonEncode(course.toJson())).toList();
    prefs.setStringList('courses', coursesJson);
  }

  void loadCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? coursesJson = prefs.getStringList('courses');
    if (coursesJson != null) {
      List<Course> loadedCourses =
          coursesJson.map((json) => Course.fromJson(jsonDecode(json))).toList();
      setState(() {
        courses = loadedCourses;
      });
    }
  }

  double calculateGPA(int gradeLevel) {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in courses) {
      totalPoints += gradeToPoint(course.grade) * course.credits;
      totalCredits += course.credits;
    }

    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  double calculateWeightedGPA() {
    double totalGPA = 0;
    int count = 0;

    for (int gradeLevel in gradeLevels) {
      if (courses.isNotEmpty) {
        double gpa = calculateGPA(gradeLevel);
        totalGPA += gpa;
        count++;
      }
    }

    return count > 0 ? totalGPA / count : 0.0;
  }

  double gradeToPoint(String grade) {
    switch (grade) {
      case 'A':
        return 4.0;
      case 'B':
        return 3.0;
      case 'C':
        return 2.0;
      case 'D':
        return 1.0;
      default:
        return 0.0;
    }
  }
}
