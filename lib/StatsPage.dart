import 'package:flutter/material.dart';
import 'package:intro_to_programming_fbla/CoursePage.dart';
import 'util/AppColors.dart';

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

class RoundedGPABox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightAccent,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 4,
          color: Colors.blue,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '???',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          SizedBox(height: 10), // Spacer between "???" and "Weighted GPA"
          Text(
            'Unweighted GPA',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedWeightedGPABox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightAccent,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(
          width: 4,
          color: Colors.black,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '???',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
          ),
          SizedBox(height: 10), // Spacer between "???" and "Weighted GPA"
          Text(
            'Weighted GPA',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class editCoursesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalculatorScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Background color
        foregroundColor: Colors.white, // Text color
        padding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 50), // Button padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Button border radius
          side: BorderSide(width: 4, color: Colors.black), // Outline
        ),
      ),
      child: Text(
        'Edit Courses',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
