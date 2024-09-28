import 'package:eduai/Screens/Teacher/UI/Vocabulary/UI/vocabularytest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class VocabularyScreen extends StatefulWidget {
  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  List<Map<String, dynamic>> wordData = [];
  bool isLoading = true;

  // Create controllers for each word
  List<TextEditingController> wordDataControllers = [];
  List<TextEditingController> definitionControllers = [];
  List<TextEditingController> pronunciationControllers = [];
  List<TextEditingController> similarWordsControllers = [];
  List<TextEditingController> exampleWordsControllers = [];


  @override
  void initState() {
    super.initState();
    fetchDataFromDB();
  }

  Future<void> fetchDataFromDB() async {

    String userLevel = 'Beginner';

    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay
      final response = await http.get(Uri.parse(
          'http://localhost:8000/fetchvocabulary?LessonLevel=Vocabulary&UserLevel=$userLevel&OrganisationId=0'));
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> wordsList = jsonResponse['datas']['words'];

        // Clear existing controllers and data before initializing
        wordData.clear();
        wordDataControllers.clear();
        definitionControllers.clear();
        pronunciationControllers.clear();
        similarWordsControllers.clear();

        // Map the word data into a list
        wordData = wordsList.map<Map<String, dynamic>>((item) {
          return {
            'definition': item['definition'],
            'word': item['Words'],
            'pronunciation': item['pronunciation'],
            'similarwords': item['similarwords'],//example
            'example': item['example'],//example

          };
        }).toList();

        // Initialize controllers based on the number of words
        for (var word in wordData) {
          wordDataControllers.add(TextEditingController(text: word['word']));
          definitionControllers.add(TextEditingController(text: word['definition']));
          pronunciationControllers.add(TextEditingController(text: word['pronunciation']));
          similarWordsControllers.add(TextEditingController(text: word['similarwords']));
          exampleWordsControllers.add(TextEditingController(text: word['example']));

        }

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          wordData = [{'Error': 'Failed to fetch data'}];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        wordData = [{'Error': 'Error: $e'}];
        isLoading = false;
      });
    }
  }


// void _saveQuestions() async {
//   List<Map<String, dynamic>> entryLevelQuestions = [];
//   String userLevel = 'Beginner';
//       final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String? createdBy = prefs.getString('email');
//     final int? organizationID = prefs.getInt('organizationID');


//   // Collecting data from the controllers
//   for (var i = 0; i < wordData.length; i++) {
//     entryLevelQuestions.add({
//       'Words': wordDataControllers[i].text,
//       'pronunciation': pronunciationControllers[i].text,
//       'definition': definitionControllers[i].text,
//       'similarwords': similarWordsControllers[i].text,
//       'example': exampleWordsControllers[i].text, // Uncomment if you have an example field
//     });
//   }

//   final Map<String, dynamic> vocabularyData = {
//     'Datas': entryLevelQuestions,  // Use 'Datas' as expected by the backend
//   };

//   // Send this data to your backend
//   http.post(
//     Uri.parse('http://localhost:8000/savevocabulary'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'LessonLevel': 'Vocabulary',  // Match the expected field names
//       'UserLevel': userLevel,
//       'Datas': vocabularyData['Datas'], // Directly use the entryLevelQuestions
//       'organisationid': organizationID,
//     }),
//   ).then((response) {
//     if (response.statusCode == 200) {
//       print("Data saved successfully");
//     } else {
//       print("Failed to save data: ${response.body}");
//     }
//   }).catchError((e) {
//     print("Error occurred: $e");
//   });
// // }
// void _saveQuestions(BuildContext context) async {
//   List<Map<String, dynamic>> entryLevelQuestions = [];

//   // Get preferences for createdBy and organizationID
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? createdBy = prefs.getString('email');
//   final int? organizationID = prefs.getInt('organizationID');

//   // Collecting data from the controllers
//   for (var i = 0; i < wordData.length; i++) {
//     entryLevelQuestions.add({
//       'Words': wordDataControllers[i].text,
//       'pronunciation': pronunciationControllers[i].text,
//       'definition': definitionControllers[i].text,
//       'similarwords': similarWordsControllers[i].text,
//       'example': exampleWordsControllers[i].text, // Example field
//     });
//   }

//   final Map<String, dynamic> vocabularyData = {
//     'Datas': entryLevelQuestions,
//   };

//   try {
//     final response = await http.post(
//       Uri.parse('http://localhost:8000/savevocabulary'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'LessonLevel': 'Vocabulary',  // Match the expected field names
//         'UserLevel': userLevel,       // Send userLevel in the request body
//         'Datas': vocabularyData['Datas'],
//         'organisationid': organizationID,
//         'CreatedBy': createdBy,       // Include createdBy if needed
//       }),
//     );

//     // Show the dialog after the response
//     if (response.statusCode == 200) {
//       // If the request was successful, show a success dialog
//       _showDialog(context, 'Success', 'Data saved successfully for $userLevel.');
//     } else {
//       // Show a failure dialog with the response message
//       _showDialog(context, 'Failure', 'Failed to save data: ${response.body}');
//     }
//   } catch (e) {
//     // Show an error dialog in case of exceptions
//     _showDialog(context, 'Error', 'Error occurred: $e');
//   }
// }

// // Function to show an alert dialog
// void _showDialog(BuildContext context, String title, String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// // }

// void _showUserLevelDialog(BuildContext context) {
//   String userLevel = 'Beginner'; // Default value for userLevel
//   TextEditingController userLevelController = TextEditingController();

//   // Show a dialog to input user level
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Enter User Level'),
//         content: TextField(
//           controller: userLevelController,
//           decoration: InputDecoration(
//             hintText: 'Enter user level',
//           ),
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('OK'),
//             onPressed: () {
//               // Pass the input user level and trigger the saveQuestions function
//               userLevel = userLevelController.text.isNotEmpty
//                   ? userLevelController.text
//                   : 'Beginner'; // Use default if empty
//               Navigator.of(context).pop(); // Close the dialog
//               _saveQuestions(context, userLevel); // Pass userLevel to _saveQuestions
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// void _saveQuestions(BuildContext context, String userLevel) async {
//   List<Map<String, dynamic>> entryLevelQuestions = [];

//   // Get preferences for createdBy and organizationID
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? createdBy = prefs.getString('email');
//   final int? organizationID = prefs.getInt('organizationID');

//   // Collecting data from the controllers
//   for (var i = 0; i < wordData.length; i++) {
//     entryLevelQuestions.add({
//       'Words': wordDataControllers[i].text,
//       'pronunciation': pronunciationControllers[i].text,
//       'definition': definitionControllers[i].text,
//       'similarwords': similarWordsControllers[i].text,
//       'example': exampleWordsControllers[i].text, // Example field
//     });
//   }

//   final Map<String, dynamic> vocabularyData = {
//     'Datas': entryLevelQuestions,
//   };

//   try {
//     final response = await http.post(
//       Uri.parse('http://localhost:8000/savevocabulary'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'LessonLevel': 'Vocabulary',  // Match the expected field names
//         'UserLevel': userLevel,       // Send userLevel in the request body
//         'Datas': vocabularyData['Datas'],
//         'organisationid': organizationID,
//         'CreatedBy': createdBy,       // Include createdBy if needed
//       }),
//     );

//     // Show the dialog after the response
//     if (response.statusCode == 200) {
//       // If the request was successful, show a success dialog
//       _showDialog(context, 'Success', 'Data saved successfully for $userLevel.');
//     } else {
//       // Show a failure dialog with the response message
//       _showDialog(context, 'Failure', 'Failed to save data: ${response.body}');
//     }
//   } catch (e) {
//     // Show an error dialog in case of exceptions
//     _showDialog(context, 'Error', 'Error occurred: $e');
//   }
// }

// // Function to show an alert dialog
// void _showDialog(BuildContext context, String title, String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

void _showUserLevelDialog(BuildContext context) {
  String selectedUserLevel = 'Beginner'; // Default user level
  List<String> userLevels = ['Beginner', 'Intermidiate', 'Advance','Expert',]; // Dropdown options

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select User Level'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DropdownButton<String>(
              value: selectedUserLevel,
              items: userLevels.map((String level) {
                return DropdownMenuItem<String>(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedUserLevel = newValue!;
                });
              },
            );
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _saveQuestions(context, selectedUserLevel); // Pass selected user level to _saveQuestions
            },
          ),
        ],
      );
    },
  );
}

// Function to save questions and send them to the server
void _saveQuestions(BuildContext context, String userLevel) async {
  List<Map<String, dynamic>> entryLevelQuestions = [];

  // Get preferences for createdBy and organizationID
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? createdBy = prefs.getString('email');
  final int? organizationID = prefs.getInt('organizationID');

  // Collecting data from the controllers
  for (var i = 0; i < wordData.length; i++) {
    entryLevelQuestions.add({
      'Words': wordDataControllers[i].text,
      'pronunciation': pronunciationControllers[i].text,
      'definition': definitionControllers[i].text,
      'similarwords': similarWordsControllers[i].text,
      'example': exampleWordsControllers[i].text, // Example field
    });
  }

  final Map<String, dynamic> vocabularyData = {
    'Datas': entryLevelQuestions,
  };

  try {
    final response = await http.post(
      Uri.parse('http://localhost:8000/savevocabulary'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'LessonLevel': 'Vocabulary',  // Match the expected field names
        'UserLevel': userLevel,       // Send selected user level in the request body
        'Datas': vocabularyData['Datas'],
        'organisationid': organizationID,
        'CreatedBy': createdBy,       // Include createdBy if needed
      }),
    );

    // Show the dialog after the response
    if (response.statusCode == 200) {
      _showDialog(context, 'Success', 'Data saved successfully for $userLevel.');
    } else {
      _showDialog(context, 'Failure', 'Failed to save data: ${response.body}');
    }
  } catch (e) {
    _showDialog(context, 'Error', 'Error occurred: $e');
  }
}

// Function to show an alert dialog with a message
void _showDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          ElevatedButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vocabulary')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: wordData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                decoration: InputDecoration(labelText: 'Word'),
                                controller: wordDataControllers[index],
                              ),
                              TextField(
                                decoration: InputDecoration(labelText: 'Definition'),
                                controller: definitionControllers[index],
                              ),
                              TextField(
                                decoration: InputDecoration(labelText: 'Pronunciation'),
                                controller: pronunciationControllers[index],
                              ),
                              TextField(
                                decoration: InputDecoration(labelText: 'Similar Words'),
                                controller: similarWordsControllers[index],
                              ),           
                                TextField(
                                decoration: InputDecoration(labelText: 'Example'),
                                controller: exampleWordsControllers[index],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
               ElevatedButton(
  onPressed: () => _showUserLevelDialog(context), // Pass the context to _saveQuestions
  child: Text('Save Changes'),
),
ElevatedButton(
  onPressed: () {
    // Navigate to VocabularyTest screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VocabularyTest()),
    );
  },
  child: Text('Test Questions'),
)
              ],
            ),
    );
  }
}



// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;


// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;

// // class Vocabulary extends StatefulWidget {
// //   @override
// //   _VocabularyState createState() => _VocabularyState();
// // }

// // class _VocabularyState extends State<Vocabulary> {
// //   Map<String, String> vocabularyData = {};
// //   bool isLoading = true;
// //   final List<TextEditingController> _wordControllers = [];
// //   final List<TextEditingController> _synonymsControllers = [];
// //   final List<TextEditingController> _antonymsControllers = [];
// //   final List<TextEditingController> _hintControllers = [];
// //   final List<TextEditingController> _phoneticsControllers = [];
// //   String _selectedProficiency = 'Beginner'; // Default selection
// //   final List<String> _proficiencyLevels = ['Beginner', 'Intermediate', 'Advanced', 'Unknown'];

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchDataFromDB();
// //   }

// //   Future<void> fetchDataFromDB() async {
// //     try {
// //       await Future.delayed(Duration(seconds: 2)); // Simulating network delay
// //       final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

// //       if (response.statusCode == 200) {
// //         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
// //         final List<dynamic> dataList = jsonResponse['data'];
// //         Map<String, String> result = {};
// // print(jsonResponse);
// // print(dataList);
// // // print();

// //         for (var item in dataList) {
// //           if (item is Map<String, dynamic>) {
// //             String datas = item['datas'];
// //             final Map<String, dynamic> datasJson = jsonDecode(datas);
// //             for (var entry in datasJson['entrylevelquestions']) {
// //               if (entry is Map<String, dynamic>) {
// //                 String word = entry['word'] ?? '';
// //                 String synonyms = entry['synonyms'] ?? '';
// //                 String antonyms = entry['antonyms'] ?? '';
// //                 String phonetics = entry['phonetics'] ?? '';
// //                 String hint = entry['hint'] ?? '';

// //                 // Populate vocabularyData
// //                 result[word] = synonyms; // Assuming synonyms are the value here
// //                 _wordControllers.add(TextEditingController(text: word));
// //                 _synonymsControllers.add(TextEditingController(text: synonyms));
// //                 _antonymsControllers.add(TextEditingController(text: antonyms));
// //                 _phoneticsControllers.add(TextEditingController(text: phonetics));
// //                 _hintControllers.add(TextEditingController(text: hint));
// //               }
// //             }
// //           }
// //         }

// //         setState(() {
// //           vocabularyData = result;
// //           isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           vocabularyData = {'Error': 'Failed to fetch data'};
// //           isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         vocabularyData = {'Error': 'Error: $e'};
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   void _saveQuestions() {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: Text("Save Questions"),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text("Level"),
// //               DropdownButtonFormField<String>(
// //                 decoration: const InputDecoration(
// //                   labelText: 'English Proficiency',
// //                 ),
// //                 value: _selectedProficiency, // Initial value
// //                 items: _proficiencyLevels.map((String proficiency) {
// //                   return DropdownMenuItem<String>(
// //                     value: proficiency,
// //                     child: Text(proficiency),
// //                   );
// //                 }).toList(),
// //                 onChanged: (newValue) {
// //                   setState(() {
// //                     _selectedProficiency = newValue!;
// //                   });
// //                 },
// //               ),
// //             ],
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 if (_selectedProficiency.isNotEmpty) {
// // _saveQuestion();

// //                   Navigator.of(context).pop();
// //                 } else {
// //                   // Optionally show a message if no level is selected
// //                   print('Please select a level.');
// //                 }
// //               },
// //               child: Text("Save"),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Text("Cancel"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // //   void _saveQuestion() {
// // //   // Construct the vocabulary object
// // //   List<Map<String, dynamic>> entryLevelQuestions = [];

// // //   for (int i = 0; i < _wordControllers.length; i++) {
// // //     entryLevelQuestions.add({
// // //       'word': _wordControllers[i].text,
// // //       'synonyms': _synonymsControllers[i].text,
// // //       'antonyms': _antonymsControllers[i].text,
// // //       'phonetics': _phoneticsControllers[i].text,
// // //       'hint': _hintControllers[i].text,
// // //     });
// // //   }

// // //   final Map<String, dynamic> vocabularyData = {
// // //     'LessonLevel':'Vocabulary' , // Assuming you're saving this level
// // //     'UserLevel': _selectedProficiency, // Replace with actual user level if needed
// // //     'Datas': {'entrylevelquestions': entryLevelQuestions},
// // //     'CreatedBy': 2, // Replace with actual creator name
// // //   };

// // //   // Send this data to your backend
// // //   http.post(
// // //     Uri.parse('http://localhost:8000/savevocabulary'),
// // //     headers: {
// // //       'Content-Type': 'application/json',
// // //     },
// // //     body: jsonEncode(vocabularyData),
// // //   ).then((response) {
// // //     if (response.statusCode == 200) {
// // //       // Handle successful response
// // //       print("Data saved successfully");
// // //     } else {
// // //       // Handle error response
// // //       print("Failed to save data: ${response.body}");
// // //     }
// // //   }).catchError((e) {
// // //     print("Error occurred: $e");
// // //   });
// // // // }


// void _saveQuestion() {
//   List<Map<String, dynamic>> entryLevelQuestions = [];

//   for (int i = 0; i < _wordControllers.length; i++) {
//     entryLevelQuestions.add({
//       'word': _wordControllers[i].text,
//       'synonyms': _synonymsControllers[i].text,
//       'antonyms': _antonymsControllers[i].text,
//       'phonetics': _phoneticsControllers[i].text,
//       'hint': _hintControllers[i].text,
//     });
//   }

//   final List<Map<String, dynamic>> vocabularyData = [
//     {
//       'LessonLevel': 'Vocabulary',
//       'UserLevel': _selectedProficiency,
//       'Datas': entryLevelQuestions, // Changed to match the required JSON format
//       'CreatedBy': 2, // Replace with actual creator ID
//     },
//   ];

//   // Send this data to your backend
//   http.post(
//     Uri.parse('http://localhost:8000/savevocabulary'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(vocabularyData), // Sending the modified vocabulary data
//   ).then((response) {
//     if (response.statusCode == 200) {
//       print("Data saved successfully");
//     } else {
//       print("Failed to save data: ${response.body}");
//     }
//   }).catchError((e) {
//     print("Error occurred: $e");
//   });
// }
// // void _saveQuestion() {
// //   List<Map<String, dynamic>> entryLevelQuestions = [];

// //   for (int i = 0; i < _wordControllers.length; i++) {
// //     entryLevelQuestions.add({
// //       'word': _wordControllers[i].text,
// //       'synonyms': _synonymsControllers[i].text,
// //       'antonyms': _antonymsControllers[i].text,
// //       'phonetics': _phoneticsControllers[i].text,
// //       'hint': _hintControllers[i].text,
// //     });
// //   }

// //   final Map<String, dynamic> vocabularyData = {
// //     'LessonLevel': 'Vocabulary',
// //     'UserLevel': _selectedProficiency,
// //     'Datas': entryLevelQuestions, // Adjusted to match the expected format
// //     'CreatedBy': 2, // Replace with actual creator ID
// //   };

// //   // Send this data to your backend
// //   http.post(
// //     Uri.parse('http://localhost:8000/savevocabulary'),
// //     headers: {
// //       'Content-Type': 'application/json',
// //     },
// //     body: jsonEncode(vocabularyData), // Sending a single object
// //   ).then((response) {
// //     if (response.statusCode == 200) {
// //       print("Data saved successfully");
// //     } else {
// //       print("Failed to save data: ${response.body}");
// //     }
// //   }).catchError((e) {
// //     print("Error occurred: $e");
// //   });
// // }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Vocabulary Level'),
// //       ),
// //       body: isLoading
// //           ? Center(child: CircularProgressIndicator())
// //           : Column(
// //               children: [
// //                 Expanded(
// //                   child: ListView.builder(
// //                     itemCount: vocabularyData.length,
// //                     itemBuilder: (context, index) {
// //                       String word = vocabularyData.keys.elementAt(index);
// //                       String synonyms = vocabularyData[word] ?? 'No synonyms';

// //                       return Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Card(
// //                           elevation: 4,
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(16.0),
// //                             child: Column(
// //                               children: [
// //                                 TextField(
// //                                   controller: _wordControllers[index],
// //                                   decoration: InputDecoration(
// //                                     labelText: 'Word',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 8),
// //                                 TextField(
// //                                   controller: _synonymsControllers[index],
// //                                   decoration: InputDecoration(
// //                                     labelText: 'Synonyms',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 8),
// //                                 TextField(
// //                                   controller: _antonymsControllers[index],
// //                                   decoration: InputDecoration(
// //                                     labelText: 'Antonyms',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 8),
// //                                 TextField(
// //                                   controller: _hintControllers[index],
// //                                   decoration: InputDecoration(
// //                                     labelText: 'Hint',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 8),
// //                                 TextField(
// //                                   controller: _phoneticsControllers[index],
// //                                   decoration: InputDecoration(
// //                                     labelText: 'Phonetics',
// //                                     border: OutlineInputBorder(),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: _saveQuestions,
// //                   child: Text('Save Changes'),
// //                 ),
// //                 SizedBox(height: 16),
// //               ],
// //             ),
// //     );
// //   }
// // }


// // // class Vocabulary extends StatefulWidget {
// // //   @override
// // //   _VocabularyState createState() => _VocabularyState();
// // // }

// // // class _VocabularyState extends State<Vocabulary> {
// // //   Map<String, String> vocabularyData = {};
// // //   bool isLoading = true;
// // //   final List<TextEditingController> _wordControllers = [];
// // //   final List<TextEditingController> _synonymsControllers = [];
// // //   final List<TextEditingController> _antonymsControllers = [];
// // //   final List<TextEditingController> _hintControllers = [];
// // //   final List<TextEditingController> _phoneticsControllers = [];


// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchDataFromDB();
// // //   }

// // //   Future<void> fetchDataFromDB() async {
// // //     try {
// // //       await Future.delayed(Duration(seconds: 2)); // Simulating network delay
// // //       final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

// // //       if (response.statusCode == 200) {
// // //         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
// // //         final List<dynamic> dataList = jsonResponse['data'];
// // //         Map<String, String> result = {};

// // //         for (var item in dataList) {
// // //           if (item is Map<String, dynamic>) {
// // //             String datas = item['datas'];
// // //             final Map<String, dynamic> datasJson = jsonDecode(datas);
// // //             for (var entry in datasJson['entrylevelquestions']) {
// // //               if (entry is Map<String, dynamic>) {
// // //                 String word = entry['word'] ?? '';
// // //                 String synonyms = entry['synonyms'] ?? '';
// // //                 String antonyms = entry['antonyms'] ?? '';
// // //                 String phonetics = entry['phonetics'] ?? '';
// // //                 String hint = entry['hint'] ?? '';
// // //                 // result[question] = answer;
// // //               }
// // //             }
// // //           }
// // //         }

// // //         setState(() {
// // //           vocabularyData = result;
// // //           isLoading = false;

// // //           // Initialize controllers
// // //           _wordControllers.clear();
// // //           _synonymsControllers.clear();
// // //           vocabularyData.forEach((word,synonyms,antonyms,phonetics,hint) {
// // //             _wordControllers.add(TextEditingController(text: word));
// // //             _synonymsControllers.add(TextEditingController(text: synonyms));
// // //             _synonymsControllers.add(TextEditingController(text: antonyms));
// // //             _synonymsControllers.add(TextEditingController(text: phonetics));
// // //             _synonymsControllers.add(TextEditingController(text: hint));

// // //           });
// // //         });
// // //       } else {
// // //         setState(() {
// // //           vocabularyData = {'Error': 'Failed to fetch data'};
// // //           isLoading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       setState(() {
// // //         vocabularyData = {'Error': 'Error: $e'};
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }

 
// // // void _saveQuestions() {
// // //   String selectedLevel = ''; // Variable to hold the selected level
// // //   final List<String> levels = ['Beginner', 'Intermediate', 'Advanced']; // Define your level options
// // //   String _selectedProficiency = 'Beginner'; // Default selection

// // //   // List of proficiency options
// // //   final List<String> _proficiencyLevels = ['Beginner', 'Intermediate', 'Advanced','UnKnown'];


// // //   showDialog(
// // //     context: context,
// // //     builder: (BuildContext context) {
// // //       return AlertDialog(
// // //         title: Text("Save Questions"),
// // //         content: Column(
// // //           mainAxisSize: MainAxisSize.min,
// // //           children: [
// // //             Text("Level"),
// // //             DropdownButtonFormField<String>(
// // //               decoration: const InputDecoration(
// // //                 labelText: 'English Proficiency',
// // //               ),
// // //               value: _selectedProficiency, // Initial value
// // //               items: _proficiencyLevels.map((String proficiency) {
// // //                 return DropdownMenuItem<String>(
// // //                   value: proficiency,
// // //                   child: Text(proficiency),
// // //                 );
// // //               }).toList(),
// // //               onChanged: (newValue) {
// // //                 setState(() {
// // //                   _selectedProficiency = newValue!;
// // //                 });
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_selectedProficiency.isNotEmpty) {
// // //                 print('Level saved: $_selectedProficiency');
// // //                 Navigator.of(context).pop();
// // //               } else {
// // //                 // Optionally show a message if no level is selected
// // //                 print('Please select a level.');
// // //               }
// // //             },
// // //             child: Text("Save"),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               Navigator.of(context).pop();
// // //             },
// // //             child: Text("Cancel"),
// // //           ),
// // //         ],
// // //       );
// // //     },
// // //   );
// // // }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Vocabulary Level'),
// // //       ),
// // //       body: isLoading
// // //           ? Center(child: CircularProgressIndicator())
// // //           : Column(
// // //               children: [
// // //                 Expanded(
// // //                   child: ListView.builder(
// // //                     itemCount: vocabularyData.length,
// // //                     itemBuilder: (context, index) {
// // //                       String question = vocabularyData.keys.elementAt(index);
// // //                       String answer = vocabularyData[question] ?? 'No answer';

// // //                       return Padding(
// // //                         padding: const EdgeInsets.all(8.0),
// // //                         child: Card(
// // //                           elevation: 4,
// // //                           child: Padding(
// // //                             padding: const EdgeInsets.all(16.0),
// // //                             child: Column(
// // //                               children: [
// // //                                 TextField(
// // //                                   controller: _wordControllers[index],
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Word',
// // //                                     border: OutlineInputBorder(),
// // //                                   ),
// // //                                 ),
// // //                                 SizedBox(height: 8),
// // //                                 TextField(
// // //                                   controller: _synonymsControllers[index],
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Synonyms',
// // //                                     border: OutlineInputBorder(),
// // //                                   ),
// // //                                 ),
// // //                                 SizedBox(height: 8),
// // //                                    TextField(
// // //                                   controller: _antonymsControllers[index],
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Antonyms',
// // //                                     border: OutlineInputBorder(),
// // //                                   ),
// // //                                 ),
// // //                                 SizedBox(height: 8),   TextField(
// // //                                   controller: _hintControllers[index],
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Hint',
// // //                                     border: OutlineInputBorder(),
// // //                                   ),
// // //                                 ),
// // //                                  SizedBox(height: 8),   TextField(
// // //                                   controller: _phoneticsControllers[index],
// // //                                   decoration: InputDecoration(
// // //                                     labelText: 'Phonetics',
// // //                                     border: OutlineInputBorder(),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   ),
// // //                 ),
// // //                 ElevatedButton(
// // //                   onPressed: () {
// // //                     _saveQuestions();
// // //                   },
// // //                   child: Text('Save Changes'),
// // //                 ),
// // //                 SizedBox(height: 16),
// // //               ],
// // //             ),
// // //     );
// // //   }
// // // }



// //  // void _saveQuestions() {
// //   //   TextEditingController levelController = TextEditingController();

// //   //   showDialog(
// //   //     context: context,
// //   //     builder: (BuildContext context) {
// //   //       return AlertDialog(
// //   //         title: Text("Save Questions"),
// //   //         content: Column(
// //   //           mainAxisSize: MainAxisSize.min,
// //   //           children: [
// //   //             Text("Level"),
// //   //             TextField(
// //   //               controller: levelController,
// //   //               decoration: InputDecoration(
// //   //                 hintText: "Enter the level",
// //   //               ),
// //   //             ),
// //   //           ],
// //   //         ),
// //   //         actions: [
// //   //           TextButton(
// //   //             onPressed: () {
// //   //               String level = levelController.text;
// //   //               print('Level saved: $level');
// //   //               Navigator.of(context).pop();
// //   //             },
// //   //             child: Text("Save"),
// //   //           ),
// //   //           TextButton(
// //   //             onPressed: () {
// //   //               Navigator.of(context).pop();
// //   //             },
// //   //             child: Text("Cancel"),
// //   //           ),
// //   //         ],
// //   //       );
// //   //     },
// //   //   );
// //   // }


// //   // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // class Vocabulary extends StatefulWidget {
// // //   @override
// // //   _VocabularyState createState() => _VocabularyState();
// // // }

// // // class _VocabularyState extends State<Vocabulary> {
// // //   Map<String, String> vocabularyData = {};
// // //   bool isLoading = true;
// // //   final List<TextEditingController> _questionControllers = [];
// // //   final List<TextEditingController> _answerControllers = [];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchDataFromDB(); // Fetch data when the widget is initialized
// // //   }

// // //   Future<void> fetchDataFromDB() async {
// // //     try {
// // //       await Future.delayed(Duration(seconds: 2)); // Simulating network delay

// // //       final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

// // //       if (response.statusCode == 200) {
// // //         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
// // //         final List<dynamic> dataList = jsonResponse['data'];

// // //         Map<String, String> result = {};

// // //         for (var item in dataList) {
// // //           if (item is Map<String, dynamic>) {
// // //             String datas = item['datas'];
// // //             final Map<String, dynamic> datasJson = jsonDecode(datas);

// // //             for (var entry in datasJson['entrylevelquestions']) {
// // //               if (entry is Map<String, dynamic>) {
// // //                 String question = entry['question'] ?? '';
// // //                 String answer = entry['answer'] ?? '';
// // //                 result[question] = answer;
// // //               }
// // //             }
// // //           }
// // //         }

// // //         setState(() {
// // //           vocabularyData = result; // Update the state with fetched data
// // //           isLoading = false; // Data loading is complete

// // //           // Initialize controllers for each question and answer
// // //           _questionControllers.clear();
// // //           _answerControllers.clear();
// // //           vocabularyData.forEach((question, answer) {
// // //             _questionControllers.add(TextEditingController(text: question));
// // //             _answerControllers.add(TextEditingController(text: answer));
// // //           });
// // //         });
// // //       } else {
// // //         setState(() {
// // //           vocabularyData = {'Error': 'Failed to fetch data'};
// // //           isLoading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       setState(() {
// // //         vocabularyData = {'Error': 'Error: $e'};
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }
// // //  void _saveQuestions() {
// // //   TextEditingController levelController = TextEditingController();

// // //   showDialog(
// // //     context: context,
// // //     builder: (BuildContext context) {
// // //       return AlertDialog(
// // //         title: Text("Save Questions"),
// // //         content: Column(
// // //           mainAxisSize: MainAxisSize.min, 
// // //           children: [
// // //             Text("Level"),
// // //             TextField(
// // //               controller: levelController, 
// // //               decoration: InputDecoration(
// // //                 hintText: "Enter the level",
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () {
// // //               String level = levelController.text;
// // //               print('Level saved: $level');

// // //               // Close the dialog
// // //               Navigator.of(context).pop();
// // //             },
// // //             child: Text("Save"),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               Navigator.of(context).pop();
// // //             },
// // //             child: Text("Cancel"),
// // //           ),
// // //         ],
// // //       );
// // //     },
// // //   );
// // // }


// // // @override
// // // Widget build(BuildContext context) {
// // //   return Scaffold(
// // //     appBar: AppBar(
// // //       title: Text('Vocabulary Level'),
// // //     ),
// // //     body: isLoading
// // //         ? Center(child: CircularProgressIndicator()) // Show loading indicator
// // //         : Column(
// // //             children: [
// // //               Expanded(
// // //                 child: ListView.builder(
// // //                   itemCount: vocabularyData.length,
// // //                   itemBuilder: (context, index) {
// // //                     String question = vocabularyData.keys.elementAt(index);
// // //                     String answer = vocabularyData[question] ?? 'No answer';

// // //                     return Padding(
// // //                       padding: const EdgeInsets.all(8.0),
// // //                       child: Card(
// // //                         elevation: 4,
// // //                         child: Padding(
// // //                           padding: const EdgeInsets.all(16.0),
// // //                           child: Column(
// // //                             children: [
// // //                               TextField(
// // //                                 controller: _questionControllers[index],
// // //                                 decoration: InputDecoration(
// // //                                   labelText: 'Question',
// // //                                   border: OutlineInputBorder(),
// // //                                 ),
// // //                               ),
// // //                               SizedBox(height: 8),
// // //                               TextField(
// // //                                 controller: _answerControllers[index],
// // //                                 decoration: InputDecoration(
// // //                                   labelText: 'Answer',
// // //                                   border: OutlineInputBorder(),
// // //                                 ),
// // //                               ),
// // //                               SizedBox(height: 8),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // // _saveQuestions();            
// // //                 },
// // //                 child: Text('Save Changes'),
// // //               ),
// // //               SizedBox(height: 16), // Add some spacing below the button
// // //             ],
// // //           ),
// // //   );
// // // }
// // // }


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VocabularyScreen extends StatefulWidget {
//   @override
//   _VocabularyScreenState createState() => _VocabularyScreenState();
// }

// class _VocabularyScreenState extends State<VocabularyScreen> {
//   List<Map<String, dynamic>> wordData = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromDB();
//   }

//   Future<void> fetchDataFromDB() async {
//     try {
//       await Future.delayed(Duration(seconds: 2)); // Simulating network delay
//       final response = await http.get(Uri.parse(
//           'http://localhost:8000/fetchvocabulary?LessonLevel=Vocabulary&UserLevel=Beginner&OrganisationId=2'), // Ensure "OrganisationId" matches your Go API
//     );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         final List<dynamic> wordsList = jsonResponse['datas']['words'];

//         // Map the word data into a list
//         wordData = wordsList.map<Map<String, dynamic>>((item) {
//           return {
//             'definition': item['definition'],
//             'word': item['word'],
//             'pronunciation': item['pronunciation'],
//             'similarwords': item['similarwords'],
//           };
//         }).toList();

//         setState(() {
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           wordData = [{'Error': 'Failed to fetch data'}];
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         wordData = [{'Error': 'Error: $e'}];
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Vocabulary')),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: wordData.length,
//               itemBuilder: (context, index) {
//                 final wordItem = wordData[index];
//                 return Card(
//                   margin: EdgeInsets.all(8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         TextField(
//                           decoration: InputDecoration(labelText: 'word'),
//                           controller: TextEditingController(text: wordItem['word']),
//                           onChanged: (value) {
//                             wordItem['word'] = value; // Update the value in wordData
//                           },
//                         ),
//                         TextField(
//                           decoration: InputDecoration(labelText: 'Definition'),
//                           controller: TextEditingController(text: wordItem['definition']),
//                           onChanged: (value) {
//                             wordItem['definition'] = value; // Update the value in wordData
//                           },
//                         ),
//                         TextField(
//                           decoration: InputDecoration(labelText: 'Pronunciation'),
//                           controller: TextEditingController(text: wordItem['pronunciation']),
//                           onChanged: (value) {
//                             wordItem['pronunciation'] = value; // Update the value in wordData
//                           },
//                         ),
//                         TextField(
//                           decoration: InputDecoration(labelText: 'Similar Words'),
//                           controller: TextEditingController(text: wordItem['similarwords']),
//                           onChanged: (value) {
//                             wordItem['similarwords'] = value; // Update the value in wordData
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
            
//     );
//   }
// }




// void _saveQuestion() {
  // List<Map<String, dynamic>> entryLevelQuestions = [];

  // for (int i = 0; i < _wordControllers.length; i++) {
  //   entryLevelQuestions.add({
  //     'word': _wordControllers[i].text,
  //     'synonyms': _synonymsControllers[i].text,
  //     'antonyms': _antonymsControllers[i].text,
  //     'phonetics': _phoneticsControllers[i].text,
  //     'hint': _hintControllers[i].text,
  //   });
  // }

//   final List<Map<String, dynamic>> vocabularyData = [
//     {
//       'LessonLevel': 'Vocabulary',
//       'UserLevel': _selectedProficiency,
//       'Datas': entryLevelQuestions, // Changed to match the required JSON format
//       'CreatedBy': 2, // Replace with actual creator ID
//     },
//   ];

//   // Send this data to your backend
//   http.post(
//     Uri.parse('http://localhost:8000/savevocabulary'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode(vocabularyData), // Sending the modified vocabulary data
//   ).then((response) {
//     if (response.statusCode == 200) {
//       print("Data saved successfully");
//     } else {
//       print("Failed to save data: ${response.body}");
//     }
//   }).catchError((e) {
//     print("Error occurred: $e");
//   });
// }

  // Placeholder for saving changes

  // void _saveQuestions() {
  //     List<Map<String, dynamic>> entryLevelQuestions = [];
  //   String userLevel = 'Beginner';


  //   // Logic to save changes to the server
  //   for (var i = 0; i < wordData.length; i++) {

  //     // wordData[i]['Word'] = wordDataControllers[i].text;
  //     // wordData[i]['definition'] = definitionControllers[i].text;
  //     // wordData[i]['pronunciation'] = pronunciationControllers[i].text;
  //     // wordData[i]['similarwords'] = similarWordsControllers[i].text;
  //      entryLevelQuestions.add({
  //     'word': wordDataControllers[i].text,
  //     'definition': definitionControllers[i].text,
  //     'pronunciation': pronunciationControllers[i].text,
  //     'similarwords': similarWordsControllers[i].text,
  //     // 'hint': _hintControllers[i].text,
  //   });


  //   }

  // // for (int i = 0; i < _wordControllers.length; i++) {
  // //   // entryLevelQuestions.add({
  // //   //   'word': _wordControllers[i].text,
  // //   //   'synonyms': _synonymsControllers[i].text,
  // //   //   'antonyms': _antonymsControllers[i].text,
  // //   //   'phonetics': _phoneticsControllers[i].text,
  // //   //   'hint': _hintControllers[i].text,
  // //   // });
  // // }

  // final List<Map<String, dynamic>> vocabularyData = [
  //   {
  //     'Datas': entryLevelQuestions, 
  //   },
  // ];

  // // Send this data to your backend
  // http.post(
  //   Uri.parse('http://localhost:8000/savevocabulary'),
  //   headers: {
  //     'Content-Type': 'application/json',
  //   },
  //   body: jsonEncode(
  //     {       'lessonlevel':'Vocabulary',
  //             'userlevel':userLevel,
  //             'Datas': entryLevelQuestions, 
  //             'organisationid':2

  //     }
  //   ), // Sending the modified vocabulary data
  // ).then((response) {
  //   if (response.statusCode == 200) {
  //     print("Data saved successfully");
  //   } else {
  //     print("Failed to save data: ${response.body}");
  //   }
  // }).catchError((e) {
  //   print("Error occurred: $e");
  // });
  //   // Perform HTTP request to save the updated wordData
  //   print('Saving data: $wordData'); // Replace with actual saving logic
  // }
//   void _saveQuestions() {
//   List<Map<String, dynamic>> entryLevelQuestions = [];
//   String userLevel = 'Beginner';

//   // Logic to save changes to the server
//   for (var i = 0; i < wordData.length; i++) {
//     entryLevelQuestions.add({
//       'Words': wordDataControllers[i].text,
//       'pronunciation': pronunciationControllers[i].text,
//       'definition': definitionControllers[i].text,
//       'similarwords': similarWordsControllers[i].text,
//       // 'example': _exampleControllers[i].text, // Uncomment if you have an example field
//     });
//   }

//   final Map<String, dynamic> vocabularyData = {
//     'words': entryLevelQuestions,
//   };

//   // Send this data to your backend
//   http.post(
//     Uri.parse('http://localhost:8000/savevocabulary'),
//     headers: {
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'lessonlevel': 'Vocabulary',
//       'userlevel': userLevel,
//       'Datas': vocabularyData, 
//       'organisationid': 2,
//     }), // Sending the modified vocabulary data
//   ).then((response) {
//     if (response.statusCode == 200) {
//       print("Data saved successfully");
//     } else {
//       print("Failed to save data: ${response.body}");
//     }
//   }).catchError((e) {
//     print("Error occurred: $e");
//   });
// }