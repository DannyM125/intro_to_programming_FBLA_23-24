import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/Utils/WidgetUtils.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            fontSize: 35, // Font size
            fontWeight: FontWeight.bold, // Font weight (bold)
            fontStyle: FontStyle.italic, // Font style (italic)
            color: Colors.white, // Text color
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedGPABox(),
            SizedBox(height: 30), // Spacer between the two boxes
            RoundedWeightedGPABox(),
            SizedBox(height: 20), // Spacer between GPA boxes and button
            editCoursesButton(),
            SizedBox(
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
