// // // import 'package:flutter/material.dart';

// // // class VocabularyTest extends StatefulWidget {
// // //   @override
// // //   _VocabularyTestState createState() => _VocabularyTestState();
// // // }

// // // class _VocabularyTestState extends State<VocabularyTest> with SingleTickerProviderStateMixin {
// // //   late TabController _tabController;

// // //   // Sample questions data
// // //   final List<Map<String, dynamic>> questions = [
// // //     {
// // //       'question': 'What is the capital of France?',
// // //       'answers': ['Paris', 'London', 'Berlin', 'Madrid'],
// // //       'correctAnswerIndex': 0,
// // //       'selectedAnswerIndex': null // To track the user's selected answer
// // //     },
// // //     {
// // //       'question': 'What is 2 + 2?',
// // //       'answers': ['3', '4', '5', '6'],
// // //       'correctAnswerIndex': 1,
// // //       'selectedAnswerIndex': null // To track the user's selected answer
// // //     },
// // //     {
// // //       'question': 'What is the largest ocean?',
// // //       'answers': ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
// // //       'correctAnswerIndex': 3,
// // //       'selectedAnswerIndex': null // To track the user's selected answer
// // //     },
// // //   ];

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _tabController = TabController(length: questions.length, vsync: this);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _tabController.dispose();
// // //     super.dispose();
// // //   }

// // //   void _submitAnswers() {
// // //     int correctCount = 0;

// // //     for (var question in questions) {
// // //       if (question['selectedAnswerIndex'] == null) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Please answer all questions')),
// // //         );
// // //         return; // Exit if there are unanswered questions
// // //       }

// // //       if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
// // //         correctCount++;
// // //       }
// // //     }

// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(content: Text('You got $correctCount out of ${questions.length} correct!')),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Vocabulary Test'),
// // //         bottom: TabBar(
// // //           controller: _tabController,
// // //           tabs: List.generate(questions.length, (index) {
// // //             return Tab(text: 'Question ${index + 1}');
// // //           }),
// // //         ),
// // //       ),
// // //       body: TabBarView(
// // //         controller: _tabController,
// // //         children: List.generate(questions.length, (index) {
// // //           return _buildQuestionCard(index);
// // //         }),
// // //       ),
// // //       floatingActionButton: FloatingActionButton(
// // //         onPressed: _submitAnswers,
// // //         child: Icon(Icons.check),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildQuestionCard(int index) {
// // //     final question = questions[index];

// // //     return Padding(
// // //       padding: const EdgeInsets.all(16.0),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Text(
// // //             question['question'],
// // //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //           ),
// // //           SizedBox(height: 20),
// // //           ...List.generate(question['answers'].length, (answerIndex) {
// // //             return ListTile(
// // //               title: Text(question['answers'][answerIndex]),
// // //               leading: Radio(
// // //                 value: answerIndex,
// // //                 groupValue: question['selectedAnswerIndex'],
// // //                 onChanged: (value) {
// // //                   setState(() {
// // //                     // Handle answer selection
// // //                     question['selectedAnswerIndex'] = value; // Store selected answer index
// // //                   });
// // //                 },
// // //               ),
// // //             );
// // //           }),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class VocabularyTest extends StatefulWidget {
// //   @override
// //   _VocabularyTestState createState() => _VocabularyTestState();
// // }

// // class _VocabularyTestState extends State<VocabularyTest> with SingleTickerProviderStateMixin {
// //   late TabController _tabController;
// //   List<Map<String, dynamic>> questions = []; // Initialize as empty list

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchQuestions(); // Fetch questions when initializing
// //   }

// //   Future<void> fetchQuestions() async {
// //     try {
// //       final response = await http.get(Uri.parse('http://localhost:8000/fetchVocabularyTestQuestions?organisationId=37&lessonLevel=Vocabulary&userLevel=Intermediate')); // Replace with your actual API endpoint
// //       if (response.statusCode == 200) {
// //         final List<dynamic> data = json.decode(response.body); // Assuming your API returns a list of questions
// //         setState(() {
// //           questions = data.map((question) => {
// //             'question': question['question'],
// //             'answers': question['answers'],
// //             'correctAnswerIndex': question['correctAnswerIndex'],
// //             'selectedAnswerIndex': null // Track user's selected answer
// //           }).toList();
// //           _tabController = TabController(length: questions.length, vsync: this); // Initialize TabController after fetching questions
// //         });
// //       } else {
// //         throw Exception('Failed to load questions');
// //       }
// //     } catch (e) {
// //       // Handle any errors (e.g., network issues)
// //       print('Error fetching questions: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Failed to load questions')),
// //       );
// //     }
// //   }

// //   void _submitAnswers() {
// //     int correctCount = 0;

// //     for (var question in questions) {
// //       if (question['selectedAnswerIndex'] == null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Please answer all questions')),
// //         );
// //         return; // Exit if there are unanswered questions
// //       }

// //       if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
// //         correctCount++;
// //       }
// //     }

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text('You got $correctCount out of ${questions.length} correct!')),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Vocabulary Test'),
// //         bottom: questions.isNotEmpty
// //             ? TabBar(
// //                 controller: _tabController,
// //                 tabs: List.generate(questions.length, (index) {
// //                   return Tab(text: 'Question ${index + 1}');
// //                 }),
// //               )
// //             : null, // Show TabBar only if there are questions
// //       ),
// //       body: questions.isNotEmpty
// //           ? TabBarView(
// //               controller: _tabController,
// //               children: List.generate(questions.length, (index) {
// //                 return _buildQuestionCard(index);
// //               }),
// //             )
// //           : Center(child: CircularProgressIndicator()), // Show loading spinner until questions are fetched
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _submitAnswers,
// //         child: Icon(Icons.check),
// //       ),
// //     );
// //   }

// //   Widget _buildQuestionCard(int index) {
// //     final question = questions[index];

// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             question['question'],
// //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //           ),
// //           SizedBox(height: 20),
// //           ...List.generate(question['answers'].length, (answerIndex) {
// //             return ListTile(
// //               title: Text(question['answers'][answerIndex]),
// //               leading: Radio(
// //                 value: answerIndex,
// //                 groupValue: question['selectedAnswerIndex'],
// //                 onChanged: (value) {
// //                   setState(() {
// //                     // Handle answer selection
// //                     question['selectedAnswerIndex'] = value; // Store selected answer index
// //                   });
// //                 },
// //               ),
// //             );
// //           }),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VocabularyTest extends StatefulWidget {
//   @override
//   _VocabularyTestState createState() => _VocabularyTestState();
// }

// class _VocabularyTestState extends State<VocabularyTest> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // Sample questions data
//   List<Map<String, dynamic>> questions = []; // Initialize as an empty list

//   @override
//   void initState() {
//     super.initState();
//     fetchQuestions(); // Fetch questions when initializing
//   }

//   Future<void> fetchQuestions() async {
//     // Example parameters, replace with actual values
//     int organisationId = 37; // Example organisation ID
//     String lessonLevel = 'Vocabulary'; // Example lesson level
//     String userLevel = 'Intermediate'; // Example user level

//     try {
//       // Include query parameters in the URL
//       final response = await http.get(Uri.parse(
//           'http://localhost:8000/fetchVocabularyTestQuestions?organisationId=$organisationId&lessonLevel=$lessonLevel&userLevel=$userLevel'));

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           questions = data.map((question) => {
//             'question': question['question'],
//             'answers': question['answers'],
//             'correctAnswerIndex': question['correctAnswerIndex'],
//             'selectedAnswerIndex': null // Track user's selected answer
//           }).toList();
//           _tabController = TabController(length: questions.length, vsync: this); // Initialize TabController after fetching questions
//         });
//       } else {
//         throw Exception('Failed to load questions');
//       }
//     } catch (e) {
//       // Handle any errors (e.g., network issues)
//       print('Error fetching questions: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to load questions')),
//       );
//     }
//   }

//   void _submitAnswers() {
//     int correctCount = 0;

//     for (var question in questions) {
//       if (question['selectedAnswerIndex'] == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Please answer all questions')),
//         );
//         return; // Exit if there are unanswered questions
//       }

//       if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
//         correctCount++;
//       }
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('You got $correctCount out of ${questions.length} correct!')),
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vocabulary Test'),
//         bottom: _tabController.length > 0 ? TabBar(
//           controller: _tabController,
//           tabs: List.generate(questions.length, (index) {
//             return Tab(text: 'Question ${index + 1}');
//           }),
//         ) : null,
//       ),
//       body: _tabController.length > 0 ? TabBarView(
//         controller: _tabController,
//         children: List.generate(questions.length, (index) {
//           return _buildQuestionCard(index);
//         }),
//       ) : Center(child: CircularProgressIndicator()),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _submitAnswers,
//         child: Icon(Icons.check),
//       ),
//     );
//   }

//   Widget _buildQuestionCard(int index) {
//     final question = questions[index];

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             question['question'],
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           ...List.generate(question['answers'].length, (answerIndex) {
//             return ListTile(
//               title: Text(question['answers'][answerIndex]),
//               leading: Radio(
//                 value: answerIndex,
//                 groupValue: question['selectedAnswerIndex'],
//                 onChanged: (value) {
//                   setState(() {
//                     // Handle answer selection
//                     question['selectedAnswerIndex'] = value; // Store selected answer index
//                   });
//                 },
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }


import 'package:eduai/Screens/Read/UI/Vocabulary/mywords.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../readmainpage.dart';

class VocabularyTest extends StatefulWidget {
  @override
  _VocabularyTestState createState() => _VocabularyTestState();
}

class _VocabularyTestState extends State<VocabularyTest> with SingleTickerProviderStateMixin {
  TabController? _tabController; // Change to nullable type
  List<Map<String, dynamic>> questions = []; // Initialize as an empty list
    //  final prefs = await SharedPreferences.getInstance();
    // var englishProficency = prefs.getString('englishProficency')

  @override
  void initState() {
    super.initState();
    
fetchQuestions();
  }

//   Future<void> fetchQuestions() async {
//     try {
//         final response = await http.get(Uri.parse('http://localhost:8000/fetchVocabularyTestQuestions?id=51'));

//         if (response.statusCode == 200) {
//             final data = json.decode(response.body);

//             // Check if the answer field is valid
//             if (data['answer'] != null) {
//                 // Decode the JSON string in the answer field
//                 final List<dynamic> questionsData = json.decode(data['answer']);

//                 // Ensure questionsData is a List and map to questions
//                 if (questionsData is List) {
//                     setState(() {
//                         questions = questionsData.map<Map<String, dynamic>>((question) => {
//                             'question': question['question'],
//                             'answers': question['answers'],
//                             'correctAnswerIndex': question['correctAnswerIndex'],
//                             'selectedAnswerIndex': null
//                         }).toList();

//                         _tabController = TabController(length: questions.length, vsync: this);
//                     });
//                 } else {
//                     throw Exception('Parsed answer is not a list');
//                 }
//             } else {
//                 throw Exception('Answer field is missing');
//             }
//         } else {
//             throw Exception('Failed to load questions: ${response.statusCode}');
//         }
//     } catch (e) {
//         print('Error fetching questions: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to load questions')),
//         );
//     }
// }
// Future<void> saveScore()  {
//     String level = "Beginner";  // Set the appropriate level
//     String userId = "12345";    // Replace with actual user ID
//     int score = 85;              // Replace with actual score

//     // await saveTestScore(level, userId, score);
// }


// Future<void> fetchQuestions() async {
//   final prefs = await SharedPreferences.getInstance();
//     var englishProficency = prefs.getString('englishProficency');
//     // var englishProficency = prefs.getString('englishProficency');
//     var organizationID = prefs.getInt('organizationID');



//     try {
//         final response = await http.get(Uri.parse(
//             'http://localhost:8000/fetchVocabularyTestQuestions?userlevel=Beginner&lessonlevel=Vocabulary&orgid=0'));

//         if (response.statusCode == 200) {
//             final data = json.decode(response.body);

//             // Check if the answer field is valid
//             if (data['answer'] != null) {
//                 // Decode the JSON string in the answer field
//                 final List<dynamic> questionsData = json.decode(data['answer']);

//                 // Ensure questionsData is a List and map to questions
//                 if (questionsData is List) {
//                     setState(() {
//                         questions = questionsData.map<Map<String, dynamic>>((question) => {
//                             'question': question['question'],
//                             'answers': question['answers'],
//                             'correctAnswerIndex': question['correctAnswerIndex'],
//                             'selectedAnswerIndex': null
//                         }).toList();

//                         _tabController = TabController(length: questions.length, vsync: this);
//                     });
//                 } else {
//                     throw Exception('Parsed answer is not a list');
//                 }
//             } else {
//                 throw Exception('Answer field is missing');
//             }
//         } else {
//             throw Exception('Failed to load questions: ${response.statusCode}');
//         }
//     } catch (e) {
//         print('Error fetching questions: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to load questions')),
//         );
//     }
// }
Future<void> fetchQuestions() async {
  final prefs = await SharedPreferences.getInstance();
  var organizationID = prefs.getInt('organizationID') ?? 0; // Default to 0 if not found

  try {
    final response = await http.get(Uri.parse(
        'http://localhost:8000/fetchVocabularyTestQuestions?userlevel=Beginner&lessonlevel=Vocabulary&orgid=$organizationID'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Ensure we are treating 'data' as a List
      if (data is List) {
        setState(() {
          questions = data.map<Map<String, dynamic>>((question) => {
                'question': question['question'],
                'answers': question['answers'], // Ensure this is a list of strings
                'correctAnswerIndex': question['correctAnswerIndex'],
                'selectedAnswerIndex': null
              }).toList();

          _tabController = TabController(length: questions.length, vsync: this);
        });
      } else {
        throw Exception('Expected data to be a list');
      }
    } else {
      throw Exception('Failed to load questions: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching questions: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load questions')),
    );
  }
}
void _submitAnswers(String lessonLevel) async {
  int correctCount = 0;

  // Get SharedPreferences instance
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Retrieve stored userId from SharedPreferences
  final int? userId = prefs.getInt('id');  // Ensure this matches the stored key 'id'
  print(userId);

  // Check if userId is null
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not logged in, please login to submit answers.')),
    );
    return;
  }

  // Loop through the questions
  for (var question in questions) {
    if (question['selectedAnswerIndex'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please answer all questions')),
      );
      return; // Exit if there are unanswered questions
    }

    if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
      correctCount++;
    }
  }

  // Check if all answers are correct
  if (correctCount == questions.length) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Congratulations! You answered all questions correctly!')),
    );

    // Save test score with userId and lessonLevel
    await saveTestScore(lessonLevel, userId); // Only save userId and lessonLevel

    // Navigate to ReadMainPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Readmainpage()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You got $correctCount out of ${questions.length} correct. Please try again.')),
    );
    // Navigate to MyWordsLevelPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyWords()),
    );
  }
}

Future<void> saveTestScore(String level, int userId) async {
  try {
    // Send the POST request with userId and level only
    final response = await http.post(
      Uri.parse('http://localhost:8000/saveTestScore'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'level': level,
        'userid': userId.toString(),  // Convert userId to string here
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Score saved: ${data['message']}');
    } else {
      print('Failed to save score: ${response.statusCode}');
    }
  } catch (e) {
    print('Error saving score: $e');
  }
}



// Future<void> saveTestScore(String level, int userId, int score) async {
//   print(level);
//   print(userId);
//   print(score);
//     try {
//         final response = await http.post(
//             Uri.parse('http://localhost:8000/saveTestScore'),
//             headers: {'Content-Type': 'application/json'},
//             body: json.encode({
//                 'level': level,
//                 'userid': userId,
//                 'score': score,
//             }),
//         );

//         if (response.statusCode == 200) {
//             final data = json.decode(response.body);
//             print('Score saved: ${data['message']}');
//         } else {
//             print('Failed to save score: ${response.statusCode}');
//         }
//     } catch (e) {
//         print('Error saving score: $e');
//     }
// }




  // void _submitAnswers() async {
  //   int correctCount = 0;
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int? storedOrganizationId = prefs.getInt('organizationID');
  //   final int? userId = prefs.getInt('id');  
  //     print(userId);
  // // print(score);
  //   for (var question in questions) {
  //     if (question['selectedAnswerIndex'] == null) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Please answer all questions')),
  //       );
  //       return; // Exit if there are unanswered questions
  //     }

  //     if (question['selectedAnswerIndex'] == question['correctAnswerIndex']) {
  //       correctCount++;

  //     }
  //   }

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('You got $correctCount out of ${questions.length} correct!')),
  //   );
  //       // await saveTestScore("Words", userId, correctCount);

  // }

  @override
  void dispose() {
    _tabController?.dispose(); // Dispose only if it's initialized
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary Test'),
        bottom: _tabController?.length != null && _tabController!.length > 0 
            ? TabBar(
                controller: _tabController,
                tabs: List.generate(questions.length, (index) {
                  return Tab(text: 'Question ${index + 1}');
                }),
              ) 
            : null,
      ),
      body: _tabController?.length != null && _tabController!.length > 0 
          ? TabBarView(
              controller: _tabController,
              children: List.generate(questions.length, (index) {
                return _buildQuestionCard(index);
              }),
            ) 
          : Center(child: CircularProgressIndicator()), // Show loading indicator while fetching
      floatingActionButton: FloatingActionButton(
        onPressed:()=> _submitAnswers('Words'),
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildQuestionCard(int index) {
    final question = questions[index];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question['question'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ...List.generate(question['answers'].length, (answerIndex) {
            return ListTile(
              title: Text(question['answers'][answerIndex]),
              leading: Radio(
                value: answerIndex,
                groupValue: question['selectedAnswerIndex'],
                onChanged: (value) {
                  setState(() {
                    // Handle answer selection
                    question['selectedAnswerIndex'] = value; // Store selected answer index
                  });
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
