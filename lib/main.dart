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
  List<Course_9> courses_9 = [];
  List<Course_10> courses_10 = [];
  List<Course_11> courses_11 = [];
  List<Course_12> courses_12 = [];
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
                itemCount: getCourseList(selectedGradeLevel).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(getCourseList(selectedGradeLevel)[index].name),
                    subtitle: Text(
                      'Grade: ${getCourseList(selectedGradeLevel)[index].grade}, Credits: ${getCourseList(selectedGradeLevel)[index].credits}',
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
    if (selectedGradeLevel == 9) {
      if (courseName.isNotEmpty) {
        Course_9 course = Course_9(
          name: courseName,
          grade: selectedLetterGrade,
          credits: selectedCredits,
        );
        setState(() {
          courses_9.add(course);
          courseNameController.text = '';
        });
        saveCourses(); // Save courses after adding a new course.
      }
    } else if (selectedGradeLevel == 10) {
      if (courseName.isNotEmpty) {
        Course_10 course = Course_10(
          name: courseName,
          grade: selectedLetterGrade,
          credits: selectedCredits,
        );
        setState(() {
          courses_10.add(course);
          courseNameController.text = '';
        });
        saveCourses(); // Save courses after adding a new course.
      }
    } else if (selectedGradeLevel == 11) {
      if (courseName.isNotEmpty) {
        Course_11 course = Course_11(
          name: courseName,
          grade: selectedLetterGrade,
          credits: selectedCredits,
        );
        setState(() {
          courses_11.add(course);
          courseNameController.text = '';
        });
        saveCourses(); // Save courses after adding a new course.
      }
    } else {
      if (courseName.isNotEmpty) {
        Course_12 course = Course_12(
          name: courseName,
          grade: selectedLetterGrade,
          credits: selectedCredits,
        );
        setState(() {
          courses_12.add(course);
          courseNameController.text = '';
        });
        saveCourses(); // Save courses after adding a new course.
      }
    }
  }

  void removeCourse(int index) {
    setState(() {
      if (selectedGradeLevel == 9) {
        courses_9.removeAt(index);
      } else if (selectedGradeLevel == 10) {
        courses_10.removeAt(index);
      } else if (selectedGradeLevel == 11) {
        courses_11.removeAt(index);
      } else {
        courses_12.removeAt(index);
      }
      saveCourses(); // Save courses after removing a course.
    });
  }

  void saveCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> coursesJson =
        courses_9.map((course) => jsonEncode(course.toJson())).toList();
    prefs.setStringList('courses_9', coursesJson);

    coursesJson =
        courses_10.map((course) => jsonEncode(course.toJson())).toList();
    prefs.setStringList('courses_10', coursesJson);

    coursesJson =
        courses_11.map((course) => jsonEncode(course.toJson())).toList();
    prefs.setStringList('courses_11', coursesJson);

    coursesJson =
        courses_12.map((course) => jsonEncode(course.toJson())).toList();
    prefs.setStringList('courses_12', coursesJson);
  }

  void loadCourses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? coursesJson = prefs.getStringList('courses_9');
    if (coursesJson != null) {
      List<Course_9> loadedCourses = coursesJson
          .map((json) => Course_9.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        courses_9 = loadedCourses;
      });
    }

    coursesJson = prefs.getStringList('courses_10');
    if (coursesJson != null) {
      List<Course_10> loadedCourses = coursesJson
          .map((json) => Course_10.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        courses_10 = loadedCourses;
      });
    }

    coursesJson = prefs.getStringList('courses_11');
    if (coursesJson != null) {
      List<Course_11> loadedCourses = coursesJson
          .map((json) => Course_11.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        courses_11 = loadedCourses;
      });
    }

    coursesJson = prefs.getStringList('courses_12');
    if (coursesJson != null) {
      List<Course_12> loadedCourses = coursesJson
          .map((json) => Course_12.fromJson(jsonDecode(json)))
          .toList();
      setState(() {
        courses_12 = loadedCourses;
      });
    }
  }

  double calculateGPA(int gradeLevel) {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in getCourseList(gradeLevel)) {
      totalPoints += gradeToPoint(course.grade) * course.credits;
      totalCredits += course.credits;
    }

    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  //might need fixing
  double calculateWeightedGPA() {
    double totalGPA = 0;
    int count = 0;

    for (int gradeLevel in gradeLevels) {
      if (getCourseList(gradeLevel).isNotEmpty) {
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

  List<dynamic> getCourseList(int selectedGradeLevel) {
    switch (selectedGradeLevel) {
      case 9:
        return courses_9;
      case 10:
        return courses_10;
      case 11:
        return courses_11;
      case 12:
        return courses_12;
      default:
        return courses_9;
    }
  }
}
