import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/Course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

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
          icon:
              Icon(Icons.arrow_back), // Use arrow_back icon for back navigation
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              //9th grade courses:
              Text(
                'Courses for Grade 9:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getCourseList(9).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(getCourseList(9)[index].name),
                    subtitle: Text(
                      'Grade: ${getCourseList(9)[index].grade}, Credits: ${getCourseList(9)[index].credits}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        removeCourse(9, index);
                      },
                    ),
                  );
                },
              ),
              //10th grade courses:
              Text(
                'Courses for Grade 10:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getCourseList(10).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(getCourseList(10)[index].name),
                    subtitle: Text(
                      'Grade: ${getCourseList(10)[index].grade}, Credits: ${getCourseList(10)[index].credits}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        removeCourse(10, index);
                      },
                    ),
                  );
                },
              ),
              //11th grade courses:
              Text(
                'Courses for Grade 11:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getCourseList(11).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(getCourseList(11)[index].name),
                    subtitle: Text(
                      'Grade: ${getCourseList(11)[index].grade}, Credits: ${getCourseList(11)[index].credits}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        removeCourse(11, index);
                      },
                    ),
                  );
                },
              ),
              //12th grade courses:
              Text(
                'Courses for Grade 12:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: getCourseList(12).length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(getCourseList(12)[index].name),
                    subtitle: Text(
                      'Grade: ${getCourseList(12)[index].grade}, Credits: ${getCourseList(12)[index].credits}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        removeCourse(12, index);
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'GPA: ${calculateGPA().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Weighted GPA: ${calculateWeightedGPA().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddCourseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Course'),
          content: Container(
            width: 320,
            height: 150,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    labelStyle: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return DropdownButton<int>(
                          value: selectedGradeLevel,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedGradeLevel = newValue!;
                            });
                          },
                          items: gradeLevels
                              .map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(
                                'Grade $value',
                                style: TextStyle(
                                  fontSize: 20, // Font size
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return DropdownButton<String>(
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
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 20, // Font size
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return DropdownButton<double>(
                          value: selectedCredits,
                          onChanged: (double? newValue) {
                            setState(() {
                              selectedCredits = newValue!;
                            });
                          },
                          items: credits
                              .map<DropdownMenuItem<double>>((double value) {
                            return DropdownMenuItem<double>(
                              value: value,
                              child: Text(
                                value.toString(),
                                style: TextStyle(
                                  fontSize: 20, // Font size
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                addCourse();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
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

  void removeCourse(int gradeLevel, int index) {
    setState(() {
      switch (gradeLevel) {
        case 9:
          courses_9.removeAt(index);
          break;
        case 10:
          courses_10.removeAt(index);
          break;
        case 11:
          courses_11.removeAt(index);
          break;
        case 12:
          courses_12.removeAt(index);
          break;
        default:
          break;
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

  double calculateGPA() {
    int count = 0;
    double totalPoints = 0;
    double totalCredits = 0;

    for (int gradeLevel in gradeLevels) {
      if (getCourseList(gradeLevel).isNotEmpty) {
        for (var course in getCourseList(gradeLevel)) {
          totalPoints += gradeToPointUW(course.grade) * course.credits;
          totalCredits += course.credits;
        }
        count++;
      }
    }
    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }
/*   double calculateGPA(int gradeLevel) {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in getCourseList(gradeLevel)) {
      totalPoints += gradeToPointUW(course.grade) * course.credits;
      totalCredits += course.credits;
    }

    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  } */

  //TODO this is identical to UW currently
  //TODO CHANGE THIS TO ACCOUNT FOR DE and AP
  double calculateWeightedGPA() {
    int count = 0;
    double totalPoints = 0;
    double totalCredits = 0;

    for (int gradeLevel in gradeLevels) {
      if (getCourseList(gradeLevel).isNotEmpty) {
        for (var course in getCourseList(gradeLevel)) {
          totalPoints += gradeToPointUW(course.grade) * course.credits;
          totalCredits += course.credits;
        }
        count++;
      }
    }
    return totalCredits != 0 ? totalPoints / totalCredits : 0.0;
  }

  double gradeToPointUW(String grade) {
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
