import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_to_programming_fbla/CoursePage.dart';
import 'package:translator/translator.dart';
import 'CoursePage.dart';
import 'util/AppColors.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);
    final translator = GoogleTranslator();

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
                    .translate('Share', to: languageProvider.selectedLanguage)
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
                // Add your share functionality here
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
              RoundedGPABox(),
              SizedBox(height: 30), // Spacer between the two boxes
              RoundedWeightedGPABox(),
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
                  '???',
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
                  '???',
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
            content: SingleChildScrollView(
              child: FutureBuilder<String>(
                future: translator
                    .translate('What is GPA?',
                        to: languageProvider.selectedLanguage)
                    .then((Translation value) => value.text),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            height: 30), // Spacer between text and explanation
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 15, 0),
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
                              } else if (explanationSnapshot.connectionState ==
                                  ConnectionState.done) {
                                List<String> bulletPoints = [
                                  'GPA is a numerical representation of academic performance.',
                                  'It is measured on a scale of 0 to 4.0 at our school.',
                                  'Higher values indicate better performance.',
                                  'Colleges and universities use GPA during admissions.',
                                  'Students should use GPA to track progress and set goals.',
                                ];
                                List<Widget> translatedBulletPoints =
                                    bulletPoints.map((bullet) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      children: [
                                        Icon(Icons.check_circle,
                                            color: colorProvider.primaryColor),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
            "English (en)", // English
            "Spanish (es)", // Spanish
            "Chinese - Simplified (zh-cn)", // Chinese (Simplified)
            "Chinese - Traditional (zh-tw)", // Chinese (Traditional)
            "Chinese - Hong Kong (zh-hk)", // Chinese (Hong Kong)
            "Portuguese (pt)", // Portuguese
            "Gujarati (gu)", // Gujarati
            "Hindi (hi)", // Hindi
            "Tagalog/Filipino (tl)", // Tagalog (Filipino)
            "Korean (ko)", // Korean
            "Arabic (ar)", // Arabic
            "Italian (it)", // Italian
            "Polish (pl)", // Polish
            "Haitian (ht)", // Haitian
            "Russian (ru)", // Russian
            "French (fr)", // French
            "Urdu (ur)", // Urdu
            "Telugu (te)", // Telugu
            "Tamil (ta)", // Tamil
            "Bengali (bn)", // Bengali
            "Ukrainian (uk)", // Ukrainian
            "Greek (el)", // Greek
            "German (de)", // German
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
