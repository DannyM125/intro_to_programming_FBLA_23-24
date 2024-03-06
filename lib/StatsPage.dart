import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_to_programming_fbla/CoursePage.dart';
import 'CoursePage.dart';
import 'util/AppColors.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  CalculatorScreen calculatorScreen = new CalculatorScreen();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the icon to white
          size: 30, // Set the size of the icon
        ),
        backgroundColor: AppColors.primary,
        shadowColor: Colors.black,
        elevation: 4.0,
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
      drawer: Drawer(
        backgroundColor: AppColors.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Text(
                  'Settings',
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: Text(
                'Share',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Add your share functionality here
              },
            ),
            ListTile(
              leading: Icon(
                Icons.color_lens,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: Text(
                'Color Scheme',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Add your color scheme functionality here
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: Text(
                'Language',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Add your language selection functionality here
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100), // Spacer between the boxes and the app bar
              RoundedGPABox(),
              SizedBox(height: 30), // Spacer between the two boxes
              RoundedWeightedGPABox(),
              SizedBox(height: 20), // Spacer between GPA boxes and button
              editCoursesButton(),
              SizedBox(height: 20),
              Text(
                'What is GPA?',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            width: 6,
            color: AppColors.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            width: 6,
            color: AppColors.primary,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
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
        backgroundColor: AppColors.primary, // Background color
        foregroundColor: Colors.black, // Text color
        shadowColor: Colors.black,
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 50), // Button padding
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

class colorSchemeDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Color Scheme'),
          content: DropdownButtonFormField<String>(
            value: 'Blue', // Default value
            items: <String>['Blue', 'Red', 'Green', 'Yellow'] // List of colors
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              // Handle color scheme selection here
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement logic for applying selected color scheme
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
