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
    final translator = GoogleTranslator();

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
                showColorSchemeDialog(context);
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
              SizedBox(height: 20),
              FutureBuilder<String>(
                future: translator
                    .translate('What is GPA?',
                        to: languageProvider.selectedLanguage)
                    .then((value) => value.toString()),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty widget if the future hasn't resolved yet
                  }
                },
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
    final languageProvider = Provider.of<LanguageProvider>(context);
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
                color: AppColors.primary,
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
                color: AppColors.primary,
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
    final translator = GoogleTranslator();

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

void showColorSchemeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return colorSchemeDialog(); // Instantiate and return the dialog widget
    },
  );
}

class colorSchemeDialog extends StatefulWidget {
  @override
  _ColorSchemeDialogState createState() => _ColorSchemeDialogState();
}

class _ColorSchemeDialogState extends State<colorSchemeDialog> {
  late String _selectedColor = 'Blue'; // Variable to hold the selected color

  Color _getColorFromString(String colorString) {
    switch (colorString) {
      case 'Blue':
        return Colors.blue;
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Yellow':
        return Colors.yellow;
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
        items: <String>['Blue', 'Red', 'Green', 'Yellow'] // List of colors
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
            AppColors.updatePrimaryColor(selectedColor);
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
            "af",
            "sq",
            "ar-sa",
            "ar-iq",
            "ar-eg",
            "ar-ly",
            "ar-dz",
            "ar-ma",
            "ar-tn",
            "ar-om",
            "ar-ye",
            "ar-sy",
            "ar-jo",
            "ar-lb",
            "ar-kw",
            "ar-ae",
            "ar-bh",
            "ar-qa",
            "eu",
            "bg",
            "be",
            "ca",
            "zh-tw",
            "zh-cn",
            "zh-hk",
            "zh-sg",
            "hr",
            "cs",
            "da",
            "nl",
            "nl-be",
            "en",
            "en-us",
            "en-gb",
            "en-au",
            "en-ca",
            "en-nz",
            "en-ie",
            "en-za",
            "en-jm",
            "en-bz",
            "en-tt",
            "et",
            "fo",
            "fa",
            "fi",
            "fr",
            "fr-be",
            "fr-ca",
            "fr-ch",
            "fr-lu",
            "gd",
            "ga",
            "de",
            "de-ch",
            "de-at",
            "de-lu",
            "de-li",
            "el",
            "he",
            "hi",
            "hu",
            "is",
            "id",
            "it",
            "it-ch",
            "ja",
            "ko",
            "lv",
            "lt",
            "mk",
            "ms",
            "mt",
            "no",
            "pl",
            "pt-br",
            "pt",
            "rm",
            "ro",
            "ro-mo",
            "ru",
            "ru-mo",
            "sz",
            "sr",
            "sk",
            "sl",
            "sb",
            "es",
            "es-mx",
            "es-gt",
            "es-cr",
            "es-pa",
            "es-do",
            "es-ve",
            "es-co",
            "es-pe",
            "es-ar",
            "es-ec",
            "es-cl",
            "es-uy",
            "es-py",
            "es-bo",
            "es-sv",
            "es-hn",
            "es-ni",
            "es-pr",
            "sx",
            "sv",
            "sv-fi",
            "th",
            "ts",
            "tn",
            "tr",
            "uk",
            "ur",
            "ve",
            "vi",
            "xh",
            "ji",
            "zu"
          ] // Add your language options here
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
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
