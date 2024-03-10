import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_to_programming_fbla/CoursePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import 'CoursePage.dart';
import 'util/AppColors.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  double uwGPA = 0.0, wGPA = 0.0;

  StatisticsScreen(this.uwGPA, this.wGPA);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();
    String textToCopy = ""; // Text to be copied to clipboard

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Set the color of the icon to white
          size: 30, // Set the size of the icon
        ),
        backgroundColor: colorProvider.primaryColor,
        shadowColor: Colors.black,
        elevation: 4.0,
        title: FutureBuilder<String>(
          future: translator
              .translate('Your Profile', to: languageProvider.selectedLanguage)
              .then((Translation value) => value.text),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                snapshot.data!,
                style: TextStyle(
                  fontSize: 35, // Font size
                  fontWeight: FontWeight.bold, // Font weight (bold)
                  fontStyle: FontStyle.italic, // Font style (italic)
                  color: Colors.white, // Text color
                ),
              );
            } else {
              return SizedBox(); // Return an empty widget if the future hasn't resolved yet
            }
          },
        ),
        actions: [
          infoDialogButton(),
        ],
      ),
      drawer: Drawer(
        backgroundColor: colorProvider.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: colorProvider.primaryColor,
                ),
                child: FutureBuilder<String>(
                  future: translator
                      .translate('Settings',
                          to: languageProvider.selectedLanguage)
                      .then((Translation value) => value.text),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text(
                        snapshot.data!,
                        style: GoogleFonts.poppins(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                    }
                  },
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: FutureBuilder<String>(
                future: translator
                    .translate('User Info',
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
              ),
              onTap: () {
                if (uwGPA > 3.8)
                  textToCopy = "UWGPA: ${uwGPA}, Weighted GPA: ${wGPA} \n \n You qualify for the National Honors Society 🎉🎉!! \n\n Great work keep it up!! \n\n Consider appling if you are a junior or higher!"; // Text to be copied to clipboard
                else if (uwGPA > 3.6)
                  textToCopy = "UWGPA: ${uwGPA}, Weighted GPA: ${wGPA} \n \n With a little more work, you could qualify for the National Honors Society"; // Text to be copied to clipboard
                else if (uwGPA < 3.6 && uwGPA > 0)
                    textToCopy = "UWGPA: ${uwGPA}, Weighted GPA: ${wGPA} \n \n GPA is very important in many different applications!! Make sure you try to maintain a higher GPA!!"; // Text to be copied to clipboard
                else
                    textToCopy = "UWGPA: ${uwGPA}, Weighted GPA: ${wGPA} \n \n Press the \"Update Courses\" in order to add a course"; // Text to be copied to clipboard


                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: FutureBuilder<String>(
                future: translator
                    .translate('Your Info',
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
              ),
                      content: FutureBuilder<String>(
                future: translator
                    .translate(textToCopy,
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
              ),
                      actions: [
                        TextButton(
                          child: Text("Copy"),
                          onPressed: () {
                            // Copy text to clipboard
                            Clipboard.setData(ClipboardData(text: textToCopy))
                                .then((_) {
                              // Show a SnackBar to indicate that text has been copied
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Text copied to clipboard'),
                                ),
                              );
                            });
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.color_lens,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: FutureBuilder<String>(
                future: translator
                    .translate('Color Scheme',
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
              ),
              onTap: () {
                showColorSchemeDialog(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.white, // Set the color of the icon to white
                size: 25, // Set the size of the icon
              ),
              title: FutureBuilder<String>(
                future: translator
                    .translate('Language',
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
              ),
              onTap: () {
                _showLanguageDialog(context, languageProvider);
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
              RoundedGPABox(uwGPA),
              SizedBox(height: 30), // Spacer between the two boxes
              RoundedWeightedGPABox(wGPA),
              SizedBox(height: 20), // Spacer between GPA boxes and button
              editCoursesButton(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedGPABox extends StatelessWidget {
  double uwGPA = 0.0;

  RoundedGPABox(this.uwGPA);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();

    return FutureBuilder<String>(
      future: translator
          .translate('Unweighted GPA', to: languageProvider.selectedLanguage)
          .then((value) => value.toString()),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            width: 300,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                width: 6,
                color: colorProvider.primaryColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  uwGPA.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                SizedBox(height: 10), // Spacer between "???" and "Weighted GPA"
                Text(
                  snapshot.data!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(); // Return an empty widget if the future hasn't resolved yet
        }
      },
    );
  }
}

class RoundedWeightedGPABox extends StatelessWidget {
  double wGPA = 0.0;

  RoundedWeightedGPABox(this.wGPA);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();

    return FutureBuilder<String>(
      future: translator
          .translate('Weighted GPA', to: languageProvider.selectedLanguage)
          .then((value) => value.toString()),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            width: 300,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                width: 6,
                color: colorProvider.primaryColor,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  wGPA.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                SizedBox(height: 10), // Spacer between "???" and "Weighted GPA"
                Text(
                  snapshot.data!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(); // Return an empty widget if the future hasn't resolved yet
        }
      },
    );
  }
}

class editCoursesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CalculatorScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colorProvider.primaryColor, // Background color
        foregroundColor: Colors.black, // Text color
        shadowColor: Colors.black,
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: 15, horizontal: 50), // Button padding
      ),
      child: FutureBuilder<String>(
        future: translator
            .translate('Edit Courses', to: languageProvider.selectedLanguage)
            .then((value) => value.toString()),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Text(
              snapshot.data!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          } else {
            return SizedBox(); // Return an empty widget if the future hasn't resolved yet
          }
        },
      ),
    );
  }
}

class infoDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        // Handle info button press here
        // You can show a dialog, navigate to another screen, etc.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Container(
              height: 400,
              child: SingleChildScrollView(
                child: FutureBuilder<String>(
                  future: translator
                      .translate('What is GPA?',
                          to: languageProvider.selectedLanguage)
                      .then((Translation value) => value.text),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              snapshot.data!,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  30), // Spacer between text and explanation
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: FutureBuilder<Translation>(
                              future: translator.translate(
                                'GPA, or Grade Point Average, is a numerical representation of a student\'s academic performance. A students wieghted GPA factors in the level of classes they are taking, such as Dual Enrollment, Advance Placement, Honors, and Acedemic.',
                                to: languageProvider.selectedLanguage,
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Translation>
                                      explanationSnapshot) {
                                if (explanationSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (explanationSnapshot
                                        .connectionState ==
                                    ConnectionState.done) {
                                  List<String> bulletPoints = [
                                    'At our school, UW GPA is measured on a scale of 0 to 4.0 and UW GPA is measured on a scale of 0 to 4.0.',
                                    'Higher values indicate better performance.',
                                    'Colleges and universities use GPA during admissions.',
                                    'Students should use GPA to track progress and set goals.',
                                    'Our school has a variety of tutoring programs, if you need assistance, please reach out to a teacher.',
                                  ];
                                  List<Widget> translatedBulletPoints =
                                      bulletPoints.map((bullet) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle,
                                              color:
                                                  colorProvider.primaryColor),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: FutureBuilder<Translation>(
                                              future: translator.translate(
                                                bullet,
                                                to: languageProvider
                                                    .selectedLanguage,
                                              ),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Translation>
                                                      bulletSnapshot) {
                                                if (bulletSnapshot
                                                        .connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                } else if (bulletSnapshot
                                                        .connectionState ==
                                                    ConnectionState.done) {
                                                  return Text(
                                                    bulletSnapshot.data!.text,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  );
                                                } else {
                                                  return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList();

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        explanationSnapshot.data!.text,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              20), // Spacer between explanation and bullet points
                                      ...translatedBulletPoints, // Spread the list of translated bullet points
                                    ],
                                  );
                                } else {
                                  return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                    }
                  },
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showColorSchemeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ColorSchemeDialog(); // Instantiate and return the dialog widget
    },
  );
}

class ColorSchemeDialog extends StatefulWidget {
  @override
  _ColorSchemeDialogState createState() => _ColorSchemeDialogState();
}

class _ColorSchemeDialogState extends State<ColorSchemeDialog> {
  late String _selectedColor = 'Blue'; // Variable to hold the selected color

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'Blue':
        return Colors.blue;
      case 'Purple':
        return Colors.purple;
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      default:
        return Colors.blue; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Color Scheme'),
      content: DropdownButtonFormField<String>(
        value: _selectedColor, // Default value
        items: <String>[
          'Blue',
          'Purple',
          'Red',
          'Green',
        ] // List of colors
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedColor = newValue; // Update selected color
            });
          }
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
            final selectedColor = _getColorFromString(_selectedColor);
            Provider.of<ColorProvider>(context, listen: false)
                .updatePrimaryColor(selectedColor);
            AppColors.updatePrimaryColor(
                selectedColor); //to also update it on other pages
            Navigator.of(context).pop();
          },
          child: Text('Apply'),
        ),
      ],
    );
  }
}

void _showLanguageDialog(
    BuildContext context, LanguageProvider languageProvider) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Language'),
        content: DropdownButtonFormField<String>(
          value: languageProvider.selectedLanguage,
          items: <String>[
            "English (en)",
            "Spanish (es)",
            "Chinese - Simplified (zh-cn)",
            "Chinese - Traditional (zh-tw)",
            "Portuguese (pt)",
            "Gujarati (gu)",
            "Hindi (hi)",
            "Tagalog/Filipino (tl)",
            "Korean (ko)",
            "Arabic (ar)",
            "Italian (it)",
            "Polish (pl)",
            "Haitian (ht)",
            //"Russian (ru)", // TEXT TOO LONG
            "French (fr)",
            "Urdu (ur)",
            "Telugu (te)",
            "Tamil (ta)",
            "Bengali (bn)",
            "Ukrainian (uk)",
            "Greek (el)",
            "German (de)",
          ] // Add your language options here
              .map<DropdownMenuItem<String>>((String value) {
            var language = value.substring(0, value.indexOf(' ('));
            var code =
                value.substring(value.indexOf('(') + 1, value.indexOf(')'));
            return DropdownMenuItem<String>(
              value: code,
              child: Text('$language ($code)'),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              languageProvider.setLanguage(newValue);
            }
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
              Navigator.of(context).pop();
              // Implement logic for applying the selected language
            },
            child: Text('Apply'),
          ),
        ],
      );
    },
  );
}

class LanguageProvider with ChangeNotifier {
  String _selectedLanguage = 'en'; // Default language

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}

class ColorProvider with ChangeNotifier {
  late Color _primaryColor = Colors.blue; // Default color

  Color get primaryColor => _primaryColor;

  void updatePrimaryColor(Color color) {
    _primaryColor = color;
    notifyListeners();
  }
}
