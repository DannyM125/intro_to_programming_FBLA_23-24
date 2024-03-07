import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/StatsPage.dart';
import 'package:intro_to_programming_fbla/util/AppColors.dart';
import 'package:intro_to_programming_fbla/util/Course.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'main.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<String> letterGrades = ['A', 'B+', 'B', 'C+', 'C', 'D', 'F'];
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

  double get gpa => calculateGPA();

  @override
  void initState() {
    super.initState();
    // Load courses from SharedPreferences when the widget is created.
    loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translator = GoogleTranslator();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        shadowColor: Colors.black,
        elevation: 4.0,
        title: FutureBuilder<String>(
          future: translator
              .translate('Update Courses',
                  to: languageProvider.selectedLanguage)
              .then((Translation value) => value.text),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                snapshot.data!,
                style: GoogleFonts.poppins(
                    fontSize: 25, // Adjust font size as needed
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              );
            } else {
              return SizedBox(); // Return an empty widget if the future hasn't resolved yet
            }
          },
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 35,
            color: Colors.white,
          ), // Use arrow_back icon for back navigation
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
              printCourses(), //Displaying all courses from each grade level
              SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "UW GPA:",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.blueGrey),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '${calculateGPA().toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                            fontSize: 25, // Adjust font size as needed
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Weighted GPA:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '${calculateWeightedGPA().toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                        fontSize: 25, // Adjust font size as needed
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          _showAddCourseDialog();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }

//Dialog methods:

  void _showAddCourseDialog() {
    // Set initial values for the dialog fields
    courseNameController.text = '';
    selectedGradeLevel = gradeLevels.first;
    selectedLetterGrade = letterGrades.first;
    selectedCredits = credits.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        final translator = GoogleTranslator();
        return AlertDialog(
          title: FutureBuilder<String>(
            future: translator
                .translate('Add Course', to: languageProvider.selectedLanguage)
                .then((Translation value) => value.text),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  snapshot.data!,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                );
              } else {
                return SizedBox(); // Return an empty widget if the future hasn't resolved yet
              }
            },
          ),
          backgroundColor: Colors.white,
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
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
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
                      width: 15,
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
                      width: 15,
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
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addCourse();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditCourseDialog(
    dynamic course,
    int gradeLevel,
    int index,
  ) {
    // Set initial values for the dialog fields
    courseNameController.text = course.name;
    selectedGradeLevel = gradeLevel;
    selectedLetterGrade = course.grade;
    selectedCredits = course.credits;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final languageProvider = Provider.of<LanguageProvider>(context);
        final translator = GoogleTranslator();
        return AlertDialog(
          title: FutureBuilder<String>(
            future: translator
                .translate('Add Course', to: languageProvider.selectedLanguage)
                .then((Translation value) => value.text),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text(
                  snapshot.data!,
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                );
              } else {
                return SizedBox(); // Return an empty widget if the future hasn't resolved yet
              }
            },
          ),
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
                      width: 15,
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
                      width: 15,
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
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateCourse(gradeLevel, index);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'Update',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

//Edit Course list methods:
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

  void updateCourse(int oldGradeLevel, int index) {
    String courseName = courseNameController.text;
    if (courseName.isNotEmpty) {
      setState(() {
        switch (oldGradeLevel) {
          case 9:
            var course = courses_9.removeAt(index);
            break;
          case 10:
            var course = courses_10.removeAt(index);
            break;
          case 11:
            var course = courses_11.removeAt(index);
            break;
          case 12:
            var course = courses_12.removeAt(index);
            break;
          default:
            break;
        }

        switch (selectedGradeLevel) {
          case 9:
            courses_9.add(Course_9(
              name: courseName,
              grade: selectedLetterGrade,
              credits: selectedCredits,
            ));
            break;
          case 10:
            courses_10.add(Course_10(
              name: courseName,
              grade: selectedLetterGrade,
              credits: selectedCredits,
            ));
            break;
          case 11:
            courses_11.add(Course_11(
              name: courseName,
              grade: selectedLetterGrade,
              credits: selectedCredits,
            ));
            break;
          case 12:
            courses_12.add(Course_12(
              name: courseName,
              grade: selectedLetterGrade,
              credits: selectedCredits,
            ));
            break;
          default:
            break;
        }
      });
      saveCourses();
    }
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

  Widget printCourses() {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translator = GoogleTranslator();
    List<Widget> courseWidgets = [];
    for (int gradeLevel in gradeLevels) {
      courseWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String>(
              future: translator
                  .translate('Courses for Grade $gradeLevel:',
                      to: languageProvider.selectedLanguage)
                  .then((Translation value) => value.text),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    snapshot.data!,
                    style: GoogleFonts.poppins(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  );
                } else {
                  return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                }
              },
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: getCourseList(gradeLevel).length,
              itemBuilder: (context, index) {
                final course = getCourseList(gradeLevel)[index];
                return ListTile(
                  title: Text(
                    course.name,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Grade: ${course.grade}, Credits: ${course.credits}',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 30.0,
                        ),
                        color: AppColors.primary,
                        onPressed: () {
                          _showEditCourseDialog(course, gradeLevel, index);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 30.0,
                        ),
                        color: Colors.deepOrange,
                        onPressed: () {
                          removeCourse(gradeLevel, index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
    return Column(children: courseWidgets);
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

//GPA calculation methods:

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
