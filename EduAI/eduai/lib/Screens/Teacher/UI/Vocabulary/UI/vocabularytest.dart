
// // import 'dart:convert'; // Import this for JSON encoding
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http; // Import the http package for API calls

// // class VocabularyTest extends StatefulWidget {
// //   @override
// //   _VocabularyTest createState() => _VocabularyTest();
// // }

// // class _VocabularyTest extends State<VocabularyTest> {
// //   // List to store multiple questions
// //   List<Map<String, dynamic>> questions = [];

// //   // Controllers for new question and answer inputs
// //   final TextEditingController questionController = TextEditingController();
// //   final List<TextEditingController> answerControllers = [
// //     TextEditingController(),
// //     TextEditingController(),
// //     TextEditingController(),
// //     TextEditingController(),
// //   ];
// //   int? correctAnswerIndex;

// //   // Function to add a new question to the list
// //   void _addQuestion() {
// //     if (questionController.text.isNotEmpty &&
// //         correctAnswerIndex != null &&
// //         answerControllers.every((controller) => controller.text.isNotEmpty)) {
// //       setState(() {
// //         questions.add({
// //           'question': questionController.text,
// //           'answers': answerControllers.map((controller) => controller.text).toList(),
// //           'correctAnswerIndex': correctAnswerIndex,
// //         });

// //         // Clear fields after adding
// //         questionController.clear();
// //         answerControllers.forEach((controller) => controller.clear());
// //         correctAnswerIndex = null;
// //       });
// //     } else {
// //       // Display error message
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Please fill all fields and select the correct answer')),
// //       );
// //     }
// //   }
// // Future<void> _submitTest() async {
// //   if (questions.isNotEmpty) {
// //     // Prepare the data for submission
// //     final data = {
// //       'organisationId': 2, // Replace with your organization ID
// //       'lessonLevel': 'Vocabulary', // Replace with the lesson level
// //       'userLevel': 'Beginner', // Replace with the user level
// //       'testData': questions.map((question) {
// //         return {
// //           'question': question['question'],
// //           'answers': question['answers'],
// //           'correctAnswerIndex': question['correctAnswerIndex'],
// //         };
// //       }).toList(),
// //     };

// //     try {
// //       final response = await http.post(
// //         Uri.parse('http://localhost:8000/savevocabularytestdata'), // Replace with your API URL
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //         body: json.encode(data), // Send the correctly structured data
// //       );
// // print(response.body);
// //       if (response.statusCode == 200) {
// //         // Handle successful submission
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Test submitted successfully')),
// //         );
// //         setState(() {
// //           questions.clear(); // Clear questions after submission
// //         });
// //       } else {
// //         // Handle error response
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Failed to submit test: ${response.body}')),
// //         );
// //       }
// //     } catch (e) {


// // print(e);
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Error submitting test: $e')),
// //       );
// //     }
// //   } else {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('Please add at least one question')),
// //     );
// //   }
// // }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Assign MCQ Test'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             // Question Input
// //             TextField(
// //               controller: questionController,
// //               decoration: InputDecoration(
// //                 labelText: 'Enter Question',
// //               ),
// //             ),
// //             SizedBox(height: 16.0),
// //             // Answer Inputs and Radio Buttons for Correct Answer
// //             ...List.generate(4, (index) {
// //               return ListTile(
// //                 title: TextField(
// //                   controller: answerControllers[index],
// //                   decoration: InputDecoration(
// //                     labelText: 'Answer ${index + 1}',
// //                   ),
// //                 ),
// //                 leading: Radio<int>(
// //                   value: index,
// //                   groupValue: correctAnswerIndex,
// //                   onChanged: (value) {
// //                     setState(() {
// //                       correctAnswerIndex = value;
// //                     });
// //                   },
// //                 ),
// //               );
// //             }),
// //             SizedBox(height: 16.0),
// //             // Add Question Button
// //             ElevatedButton(
// //               onPressed: _addQuestion,
// //               child: Text('Add Question'),
// //             ),
// //             SizedBox(height: 16.0),
// //             // Submit Test Button
// //             ElevatedButton(
// //               onPressed: _submitTest,
// //               child: Text('Submit Test'),
// //             ),
// //             SizedBox(height: 16.0),
// //             // Display added questions in a ListView
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: questions.length,
// //                 itemBuilder: (context, index) {
// //                   final question = questions[index];
// //                   return Card(
// //                     child: ListTile(
// //                       title: Text('${index + 1}. ${question['question']}'),
// //                       subtitle: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: List.generate(4, (i) {
// //                           return Text(
// //                             '${i + 1}. ${question['answers'][i]} ${question['correctAnswerIndex'] == i ? '(Correct)' : ''}',
// //                           );
// //                         }),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert'; // Import this for JSON encoding
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart'; // Import the http package for API calls

// class VocabularyTest extends StatefulWidget {
//   @override
//   _VocabularyTest createState() => _VocabularyTest();
// }

// class _VocabularyTest extends State<VocabularyTest> {
//   // List to store multiple questions
//   List<Map<String, dynamic>> questions = [];

//   // Controllers for new question and answer inputs
//   final TextEditingController questionController = TextEditingController();
//   final List<TextEditingController> answerControllers = [
//     TextEditingController(),
//     TextEditingController(),
//     TextEditingController(),
//     TextEditingController(),
//   ];
//   int? correctAnswerIndex;




// void _showUserLevelDialog(BuildContext context) {
//   String selectedUserLevel = 'Beginner'; // Default user level
//   List<String> userLevels = ['Beginner', 'Intermidiate', 'Advance','Expert',]; // Dropdown options

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Select User Level'),
//         content: StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState) {
//             return DropdownButton<String>(
//               value: selectedUserLevel,
//               items: userLevels.map((String level) {
//                 return DropdownMenuItem<String>(
//                   value: level,
//                   child: Text(level),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedUserLevel = newValue!;
//                 });
//               },
//             );
//           },
//         ),
//         actions: <Widget>[
//           ElevatedButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//               _submitTest(context, selectedUserLevel); // Pass selected user level to _saveQuestions
//             },
//           ),
//         ],
//       );
//     },
//   );
// }
//   void _addQuestion() {
//     if (questionController.text.isNotEmpty &&
//         correctAnswerIndex != null &&
//         answerControllers.every((controller) => controller.text.isNotEmpty)) {
//       setState(() {
//         questions.add({
//           'question': questionController.text,
//           'answers': answerControllers.map((controller) => controller.text).toList(),
//           'correctAnswerIndex': correctAnswerIndex,
//         });

//         // Clear fields after adding
//         questionController.clear();
//         answerControllers.forEach((controller) => controller.clear());
//         correctAnswerIndex = null;
//       });
//     } else {
//       // Display error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please fill all fields and select the correct answer')),
//       );
//     }
//   }
// Future<void> _submitTest(BuildContext context, String userLevel)  async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final String? createdBy = prefs.getString('email');
//   final int? organizationID = prefs.getInt('organizationID');
//   print(questions);
//   if (questions.isNotEmpty) {
//     // Prepare the data for submission
//     final data = {
//       'OrganisationID': organizationID, // Replace with your organization ID
//       'LessonLevel': 'Vocabulary', // Replace with the lesson level
//       'UserLevel': userLevel, // Replace with the user level
//       'TestData': questions
//     };

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:8000/savevocabularytestdata'), // Replace with your API URL
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(data), // Send the correctly structured data
//       );

//       print(response.body);
//       if (response.statusCode == 200) {
//         // Handle successful submission
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Test submitted successfully')),
//         );
//         setState(() {
//           questions.clear(); // Clear questions after submission
//         });
//       } else {
//         // Handle error response
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to submit test: ${response.body}')),
//         );
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error submitting test: $e')),
//       );
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Please add at least one question')),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Assign MCQ Test'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Question Input
//             TextField(
//               controller: questionController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Question',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             // Answer Inputs and Radio Buttons for Correct Answer
//             ...List.generate(4, (index) {
//               return ListTile(
//                 title: TextField(
//                   controller: answerControllers[index],
//                   decoration: InputDecoration(
//                     labelText: 'Answer ${index + 1}',
//                   ),
//                 ),
//                 leading: Radio<int>(
//                   value: index,
//                   groupValue: correctAnswerIndex,
//                   onChanged: (value) {
//                     setState(() {
//                       correctAnswerIndex = value;
//                     });
//                   },
//                 ),
//               );
//             }),
//             SizedBox(height: 16.0),
//             // Add Question Button
//             ElevatedButton(
//               onPressed: _addQuestion,
//               child: Text('Add Question'),
//             ),
//             SizedBox(height: 16.0),
//             // Submit Test Button
//             ElevatedButton(
//  onPressed: () => _showUserLevelDialog(context),
//                child: Text('Submit Test'),
//             ),
//             SizedBox(height: 16.0),
//             // Display added questions in a ListView
//             Expanded(
//               child: ListView.builder(
//                 itemCount: questions.length,
//                 itemBuilder: (context, index) {
//                   final question = questions[index];
//                   return Card(
//                     child: ListTile(
//                       title: Text('${index + 1}. ${question['question']}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: List.generate(4, (i) {
//                           return Text(
//                             '${i + 1}. ${question['answers'][i]} ${question['correctAnswerIndex'] == i ? '(Correct)' : ''}',
//                           );
//                         }),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VocabularyTest extends StatefulWidget {
  @override
  _VocabularyTest createState() => _VocabularyTest();
}

class _VocabularyTest extends State<VocabularyTest> {
  // List to store multiple questions
  List<Map<String, dynamic>> questions = [];

  // Controllers for new question and answer inputs
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> answerControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  int? correctAnswerIndex;

  // This method checks if the user has completed all levels
  bool _hasCompletedAllLevels() {
    // Logic to determine if the user has completed all levels
    // For example, check if questions are answered correctly
    return questions.isNotEmpty; // Adjust logic as necessary
  }

  void _showUserLevelDialog(BuildContext context) {
    String selectedUserLevel = 'Beginner'; // Default user level
    List<String> userLevels = ['Beginner', 'Intermediate', 'Advanced', 'Expert']; // Dropdown options

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
                _submitTest(context, selectedUserLevel); // Pass selected user level to _submitTest
              },
            ),
          ],
        );
      },
    );
  }

  void _addQuestion() {
    if (questionController.text.isNotEmpty &&
        correctAnswerIndex != null &&
        answerControllers.every((controller) => controller.text.isNotEmpty)) {
      setState(() {
        questions.add({
          'question': questionController.text,
          'answers': answerControllers.map((controller) => controller.text).toList(),
          'correctAnswerIndex': correctAnswerIndex,
        });

        // Clear fields after adding
        questionController.clear();
        answerControllers.forEach((controller) => controller.clear());
        correctAnswerIndex = null;
      });
    } else {
      // Display error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select the correct answer')),
      );
    }
  }

  Future<void> _submitTest(BuildContext context, String userLevel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? createdBy = prefs.getString('email');
    final int? organizationID = prefs.getInt('organizationID');

    if (questions.isNotEmpty) {
      // Prepare the data for submission
      final data = {
        'OrganisationID': organizationID, // Replace with your organization ID
        'LessonLevel': 'Vocabulary', // Replace with the lesson level
        'UserLevel': userLevel, // Replace with the user level
        'TestData': questions
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8000/savevocabularytestdata'), // Replace with your API URL
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data), // Send the correctly structured data
        );

        if (response.statusCode == 200) {
          // Handle successful submission
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Test submitted successfully')),
          );
          setState(() {
            questions.clear(); // Clear questions after submission
          });

          // Check if the user has completed all levels and navigate accordingly
          if (_hasCompletedAllLevels()) {
            Navigator.pushReplacementNamed(context, '/readMainPage'); // Adjust your route name
          } else {
            Navigator.pushReplacementNamed(context, '/myWordsLevelPage'); // Adjust your route name
          }
        } else {
          // Handle error response
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit test: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting test: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add at least one question')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign MCQ Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Input
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Enter Question',
              ),
            ),
            SizedBox(height: 16.0),
            // Answer Inputs and Radio Buttons for Correct Answer
            ...List.generate(4, (index) {
              return ListTile(
                title: TextField(
                  controller: answerControllers[index],
                  decoration: InputDecoration(
                    labelText: 'Answer ${index + 1}',
                  ),
                ),
                leading: Radio<int>(
                  value: index,
                  groupValue: correctAnswerIndex,
                  onChanged: (value) {
                    setState(() {
                      correctAnswerIndex = value;
                    });
                  },
                ),
              );
            }),
            SizedBox(height: 16.0),
            // Add Question Button
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 16.0),
            // Submit Test Button
            ElevatedButton(
              onPressed: () => _showUserLevelDialog(context),
              child: Text('Submit Test'),
            ),
            SizedBox(height: 16.0),
            // Display added questions in a ListView
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Card(
                    child: ListTile(
                      title: Text('${index + 1}. ${question['question']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(4, (i) {
                          return Text(
                            '${i + 1}. ${question['answers'][i]} ${question['correctAnswerIndex'] == i ? '(Correct)' : ''}',
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
