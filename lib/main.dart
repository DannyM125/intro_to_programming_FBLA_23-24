import 'package:flutter/material.dart';
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
  List<String> grades = ['A', 'B', 'C', 'D', 'F'];
  String selectedGrade = 'A';
  List<double> credits = [5.0, 2.5];
  double selectedCredits = 5.0;
  List<Map<String, dynamic>> courses = [];
  TextEditingController courseNameController = TextEditingController();

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
            Text(
              'Add Course:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  value: selectedGrade,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGrade = newValue!;
                    });
                  },
                  items: grades
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
                  items: credits
                      .map<DropdownMenuItem<double>>((double value) {
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
              'Courses:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(courses[index]['name']),
                    subtitle: Text(
                      'Grade: ${courses[index]['grade']}, Credits: ${courses[index]['credits']}',
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
                  'GPA: ${calculateGPA().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addCourse() {
    String courseName = courseNameController.text;
    if (courseName.isNotEmpty) {
      Map<String, dynamic> course = {
        'name': courseName,
        'grade': selectedGrade,
        'credits': selectedCredits,
      };
      setState(() {
        courses.add(course);
        courseNameController.text = '';
      });
    }
  }

  void removeCourse(int index) {
    setState(() {
      courses.removeAt(index);
    });
  }

  double calculateGPA() {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var course in courses) {
      totalPoints += gradeToPoint(course['grade']) * course['credits'];
      totalCredits += course['credits'];
    }

    return totalPoints / totalCredits;
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