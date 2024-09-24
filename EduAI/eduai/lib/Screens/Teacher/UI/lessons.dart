
import 'dart:convert';

import 'package:eduai/Screens/Teacher/UI/Vocabulary/UI/vocabulary.dart';
import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SynonymsLesson extends StatefulWidget {
  @override
  _SynonymsLessonState createState() => _SynonymsLessonState();
}





class _SynonymsLessonState extends State<SynonymsLesson> {

        int? Id=0;
        String? message='';
  
@override
void initState(){
  super.initState();
  // _retrieveLoginData();

}



// void showDialogBox(BuildContext context) {
//   final TextEditingController examDateController = TextEditingController();
//   final TextEditingController resultDateController = TextEditingController();
//   final TextEditingController testDurationController = TextEditingController();
//   final TextEditingController lessonNameController = TextEditingController();

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Enter the Details"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min, 
//           children: [
//             TextField(
//               controller: lessonNameController,
//               decoration: InputDecoration(hintText: 'Enter the Lesson Name'),
//             ),
//             TextField(
//               controller: examDateController,
//               decoration: InputDecoration(hintText: 'Enter the Exam Date'),
//             ),
//             TextField(
//               controller: testDurationController,
//               decoration: InputDecoration(hintText: 'Enter the Duration'),
//               keyboardType: TextInputType.number,
//             ),
//               TextField(
//               controller: testDateController,
//               decoration: InputDecoration(hintText: 'Exam Date'),
//               readOnly: true, 
//               onTap: () => _selectDate(context), 
//             ),
//              TextField(
//               controller: testDateController,
//               decoration: InputDecoration(hintText: 'Test Date'),
//               readOnly: true, 
//               onTap: () => _selectresultDate(context), 
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               final lessonName = lessonNameController.text;
//               final examDate = examDateController.text;
//               final testDuration = testDurationController.text;
//               final resultDate = resultDateController.text;

//               // Call savelesson with the collected data
//               savelesson(lessonName, examDate, testDuration, resultDate);

//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text('Submit'),
//           ),
//         ],
//       );
//     },
//   );
// }

// Future<void> savelesson(String lessonname, String testdate, String testduration, String resultdate) async {
//   print('Lesson Name: $lessonname');
//   print('Test Date: $testdate');
//   print('Test Duration: $testduration');
//   print('Result Date: $resultdate');

//   final prefs = await SharedPreferences.getInstance();
//   var classlevel = prefs.getString('class');
//   var createdby = prefs.getString('email');
//   var createdid = prefs.getInt('id'); // Ensure this is an integer

//   if (createdid == null) {
//     print('Error: Created ID is null');
//     return;
//   }

//   // Ensure all values are non-null
//   if (classlevel == null || createdby == null) {
//     print('Error: classlevel or createdby is null');
//     return;
//   }

//   // Convert createdid to integer for backend
//   int teacherid = createdid;

//   print('Class Level: $classlevel');
//   print('Created By: $createdby');
//   print('Created ID: $teacherid');
//   print(createdid.runtimeType);

//   // Prepare question and answer array
//   final List<String> questionArray = [
//     question1.text,
//     question2.text,
//     question3.text,
//     question4.text,
//     question5.text,
//     question6.text,
//     question7.text,
//     question8.text,
//   ];

//   final List<String> answerArray = [
//     answer1.text,
//     answer2.text,
//     answer3.text,
//     answer4.text,
//     answer5.text,
//     answer6.text,
//     answer7.text,
//     answer8.text,
//   ];

//   List<Map<String, String>> learnArray = [];
//   for (int i = 0; i < questionArray.length; i++) {
//     learnArray.add({questionArray[i]: answerArray[i]});
//   }

//   final List<String> testQuestionArray = [
//     testquestion1.text,
//     testquestion2.text,
//     testquestion3.text,
//     testquestion4.text,
//   ];

//   final List<String> testAnswerArray = [
//     testanswer1.text,
//     testanswer2.text,
//     testanswer3.text,
//     testanswer4.text,
//   ];

//   List<Map<String, String>> testArray = [];
//   for (int i = 0; i < testQuestionArray.length; i++) {
//     testArray.add({testQuestionArray[i]: testAnswerArray[i]});
//   }

//   Map<String, dynamic> userData = {
//     'learn': learnArray,
//     'test': testArray,
//   };

//   final int? testdurationminutes = int.tryParse(testduration);
//    String formattedResultDate = "";
//    print(formattedResultDate);

//   final response = await http.post(
//     Uri.parse('http://localhost:8000/savelesson'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode(
//       {
//         "id": 2,
//         "class": classlevel,
//         "lesson": lessonname,
//         "testtime": testdate,
//         "duration": testdurationminutes,
//         "resultdate": formattedResultDate,
//         "createdby": createdby,
//         "questionanswer": userData,
//         "teacherid": teacherid, 
//       },
//     ),
//   );

//   print(response.body);
// }



  

//  Future<void> _retrieveLoginData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() { Id = prefs.getInt('id');});
//   }
// final TextEditingController lessonNameController = TextEditingController();
// final TextEditingController testDateController = TextEditingController();
// DateTime _selectedDate = DateTime.now();
// DateTime _selectedresultDate = DateTime.now();




// Future<void> _selectDate(BuildContext context) async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: _selectedDate,
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );

//   if (pickedDate != null && pickedDate != _selectedDate) {
//     setState(() {
//       _selectedDate = pickedDate;
//       testDateController.text = "${_selectedDate.toLocal()}".split(' ')[0]; // Format as needed
//     });
//   }
// }

// Future<void> _selectresultDate(BuildContext context) async {
//   final DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: _selectedDate,
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2101),
//   );

//   if (pickedDate != null && pickedDate != _selectedDate) {
//     setState(() {
//       _selectedresultDate = pickedDate;
//       testDateController.text = "${_selectedDate.toLocal()}".split(' ')[0]; // Format as needed
//     });
//   }
// }

// void _showStudentIdDialog() {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Enter the Details'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: lessonNameController,
//               decoration: InputDecoration(hintText: 'Lesson Name'),
//             ),
//             SizedBox(height: 10), // Spacing between input fields
//             TextField(
//               controller: testDateController,
//               decoration: InputDecoration(hintText: 'Test Date'),
//               readOnly: true, // Make it read-only to prevent manual entry
//               onTap: () => _selectDate(context), // Trigger date picker on tap
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Selected Date: ${_selectedDate.toLocal()}',
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//           ),
//           TextButton(
//             child: Text('Submit'),
//             onPressed: () {
//               String lessonName = lessonNameController.text;
//               String testDate = testDateController.text;

//               if (lessonName.isNotEmpty && testDate.isNotEmpty) {
//                 // Proceed to save data
//                 Navigator.of(context).pop(); // Close the dialog
//                 _saveData();
//               } else {
//                 // Optionally, show validation message
//                 print('Both fields are required');
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }



  
  
//    Future<void> _saveData() async {
//       // final int studentIdInt = int.parse(studentId);


//     final prefs = await SharedPreferences.getInstance();
// var classname=prefs.getString('class');

// print(1);
//     final List<String> questionArray = [
//       question1.text,
//       question2.text,
//       question3.text,
//       question4.text,
//       question5.text,
//       question6.text,
//       question7.text,
//       question8.text,
//     ];

//     final List<String> answerArray = [
//       answer1.text,
//       answer2.text,
//       answer3.text,
//       answer4.text,
//       answer5.text,
//       answer6.text,
//       answer7.text,
//       answer8.text,
//     ];

//     List<Map<String, String>> learnArray = [];
//     for (int i = 0; i < questionArray.length; i++) {
//       learnArray.add({questionArray[i]: answerArray[i]});
//     }

//     final List<String> testQuestionArray = [
//       testquestion1.text,
//       testquestion2.text,
//       testquestion3.text,
//       testquestion4.text,
//     ];
//     final List<String> testAnswerArray = [
//       testanswer1.text,
//       testanswer2.text,
//       testanswer3.text,
//       testanswer4.text,
//     ];

//     List<Map<String, String>> testArray = [];
//     for (int i = 0; i < testQuestionArray.length; i++) {
//       testArray.add({testQuestionArray[i]: testAnswerArray[i]});
//     }

//     Map<String, dynamic> userData = {
//       'learn': learnArray,
//       'test': testArray,
      
//     };



//     // Send the HTTP POST request
//     final response = await http.post(
//   Uri.parse('http://localhost:8000/savequestionanswer'),
//   headers: {'Content-Type': 'application/json'},
//   body: json.encode(
//     {
//       'studentid': classname,
//       'datas': userData,
//       'teacherid': Id
//     }
//   ),
// );


//     // Handle the response
//     print(response.body);
//     if (response.statusCode == 200) {
//       print('Data saved successfully');
// setState(() {
//   message="Data saved successfully";
// });

//     } else {
//       print('Failed to save data');
//       setState(() {
//   message="Failed to Save the Data";
// });
//     }

//   _showDialog(message.toString());
//   }
// void _showDialog(String message) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("Response"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: Text("OK"),
//           ),
//         ],
//       );
//     },
//   );
// }


// Future<Map<String, String>> fetchDataFromDB(int index) async {
//   try {
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 2));

//     final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

//     if (response.statusCode == 200) {
//       // Print the raw response body for debugging
//       print('Raw response: ${response.body}');

//       // Decode the JSON response
//       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

//       // If you need a specific part of the JSON, e.g., 'data', extract it
//       final List<dynamic> dataList = jsonResponse['data'];

//       // Initialize result map
//       Map<String, String> result = {};

//       // Process the data list
//       for (var item in dataList) {
//         if (item is Map<String, dynamic>) {
//           String datas = item['datas'];
//           final Map<String, dynamic> datasJson = jsonDecode(datas);

//           // Extract questions and answers
//           for (var entry in datasJson['entrylevelquestions']) {
//             if (entry is Map<String, dynamic>) {
//               String question = entry['question'] ?? '';
//               String answer = entry['answer'] ?? '';
//               result[question] = answer;
//             }
//           }
//         }
//       }

//       return result;  
//     } else {
//       return {'Error': 'Failed to fetch data'};
//     }
//   } catch (e) {
//     return {'Error': 'Error: $e'};
//   }
// }


@override
Widget build(BuildContext context) {
  // List of card names
  List<String> cardNames = [
    "Vocabulary", "Words Usage", "Read a Passage",
    "Grammar Test", "Make a Sentence", "Write a Story", 
    "Chat with EDUAI", "Listening to Audio", "Sentence to Speak", 
    "Speak with EDUAI", "Conversation with EDUAI",
  ];

  // List of card descriptions for demonstration
  List<String> cardDescriptions = [
    "Learn new words and expand your vocabulary.",
    "Learn how to use words correctly in sentences.",
    "Read passages and improve your comprehension skills.",
    "Take a grammar test to assess your knowledge.",
    "Form sentences and practice writing.",
    "Write a creative story and improve your skills.",
    "Chat with EDUAI for personalized learning.",
    "Listen to educational audio content.",
    "Turn sentences into speech and practice.",
    "Speak with EDUAI for interactive learning.",
    "Have a conversation with EDUAI on various topics."
  ];

  // List of pages to navigate to
  List<Widget> pages = [
    Vocabulary(), 
    // WordsUsagePage(), 
    // ReadPassagePage(), 
    // GrammarTestPage(), 
    // MakeSentencePage(),
    // WriteStoryPage(), 
    // ChatWithEduaiPage(), 
    // ListeningToAudioPage(), 
    // SentenceToSpeakPage(), 
    // SpeakWithEduaiPage(), 
    // ConversationWithEduaiPage(),
  ];

  return Scaffold(
    appBar: AppBar(
      title: Text('Synonyms Lesson'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0, // Adjust to fit text properly
        ),
        itemCount: cardNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the corresponding detail page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pages[index], // Navigate to specific page
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  cardNames[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
}
class CardDetailPage extends StatelessWidget {
  final String title;
  final String description;

  CardDetailPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      ),
    );
  }
}






// Future<Map<String, String>> fetchDataFromDB(int index) async {
//   try {
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 2));

//     final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

//     if (response.statusCode == 200) {
//       // Print the raw response body for debugging
//       print('Raw response: ${response.body}');

//       // Decode the JSON response
//       final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

//       // If you need a specific part of the JSON, e.g., 'data', extract it
//       final List<dynamic> dataList = jsonResponse['data'];

//       // Initialize result map
//       Map<String, String> result = {};

//       // Process the data list
//       for (var item in dataList) {
//         if (item is Map<String, dynamic>) {
//           String datas = item['datas'];
//           final Map<String, dynamic> datasJson = jsonDecode(datas);

//           // Extract questions and answers
//           for (var entry in datasJson['entrylevelquestions']) {
//             if (entry is Map<String, dynamic>) {
//               String question = entry['question'] ?? '';
//               String answer = entry['answer'] ?? '';
//               result[question] = answer;
//             }
//           }
//         }
//       }

//       return result;  
//     } else {
//       return {'Error': 'Failed to fetch data'};
//     }
//   } catch (e) {
//     return {'Error': 'Error: $e'};
//   }
// }

//  @override
//   Widget build(BuildContext context) {
//     // List of card names
//     List<String> cardNames = [
//       "Vocabulary", "Words Usage", "Read a Passage",
//       "Grammar Test", "Make a Sentence", "Write a STory", "Chat with EDUAI",
//       "Listening to Audio", "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI",
//     ];

//     return DefaultTabController(
//       length: 3, // Three tabs: Beginner, Intermediate, Expert
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Synonyms Lesson'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: "Beginner"),
//               Tab(text: "Intermediate"),
//               Tab(text: "Expert"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // First tab: Fixed Grid View with 3 columns and 4 rows
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // 3 columns
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 4.0, // Adjust to fit text properly
//                 ),
//                 itemCount: cardNames.length, // Total number of items based on the list size
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Show popup window when the card is tapped
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           // Fetch data from DB
//                           return FutureBuilder<Map<String, String>>(
//                             future: fetchDataFromDB(index),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return AlertDialog(
//                                   title: Text(cardNames[index]),
//                                   content: Center(child: CircularProgressIndicator()), // Show loading indicator while fetching
//                                 );
//                               } else if (snapshot.hasError) {
//                                 return AlertDialog(
//                                   title: Text(cardNames[index]),
//                                   content: Text('Error: ${snapshot.error}'),
//                                 );
//                               } else if (snapshot.hasData) {
//                                 final data = snapshot.data!;
//                                 // Create TextEditingControllers for both questions and answers
//                                 Map<String, TextEditingController> questionControllers = {};
//                                 Map<String, TextEditingController> answerControllers = {};

//                                 data.forEach((question, answer) {
//                                   questionControllers[question] = TextEditingController(text: question);
//                                   answerControllers[question] = TextEditingController(text: answer);
//                                 });

//                                 return AlertDialog(
//                                   title: Text(cardNames[index]),
//                                   content: SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: data.entries.map((entry) {
//                                         String question = entry.key;
//                                         String answer = entry.value;
//                                         TextEditingController questionController = questionControllers[question]!;
//                                         TextEditingController answerController = answerControllers[question]!;

//                                         return Padding(
//                                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 'Question:',
//                                                 style: TextStyle(fontWeight: FontWeight.bold),
//                                               ),
//                                               SizedBox(height: 5),
//                                               TextField(
//                                                 controller: questionController,
//                                                 decoration: InputDecoration(
//                                                   labelText: 'Question',
//                                                   border: OutlineInputBorder(),
//                                                 ),
//                                               ),
//                                               SizedBox(height: 10),
//                                               Text(
//                                                 'Answer:',
//                                                 style: TextStyle(fontWeight: FontWeight.bold),
//                                               ),
//                                               SizedBox(height: 5),
//                                               TextField(
//                                                 controller: answerController,
//                                                 decoration: InputDecoration(
//                                                   labelText: 'Answer',
//                                                   border: OutlineInputBorder(),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       child: Text('Save'),
//                                       onPressed: () {
//                                         // Collect the updated data
//                                         Map<String, String> updatedData = {};
//                                         questionControllers.forEach((question, controller) {
//                                           updatedData[controller.text] = answerControllers[question]!.text;
//                                         });
//                                         // Handle save logic here
//                                         // For example, you could send `updatedData` to your server
//                                         Navigator.of(context).pop(); // Close the popup
//                                       },
//                                     ),
//                                     TextButton(
//                                       child: Text('Close'),
//                                       onPressed: () {
//                                         Navigator.of(context).pop(); // Close the popup
//                                       },
//                                     ),
//                                   ],
//                                 );
//                               } else {
//                                 return AlertDialog(
//                                   title: Text(cardNames[index]),
//                                   content: Text('No data found'),
//                                 );
//                               }
//                             },
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       width: 100,  // Set the width of each grid item
//                       height: 150, // Set the height of each grid item
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             cardNames[index], // Display card name for each item
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18.0, // Set font size for the text
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Other tabs here...
//             Center(child: Text("Intermediate Tab Content")),
//             Center(child: Text("Expert Tab Content")),
//           ],
//         ),
//       ),
//     );
//   }
// }




// Widget build(BuildContext context) {
//   // List of card names
//   List<String> cardNames = [
//     "Vocabulary", "Words Usage", "Read a Passage",
//     "Grammar Test", "Make a Sentence", "Write a Story", "Chat with EDUAI",
//     "Listening to Audio", "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI",
//   ];

//   return DefaultTabController(
//     length: 3, // Three tabs: Beginner, Intermediate, Expert
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text('Synonyms Lesson'),
//         bottom: TabBar(
//           tabs: [
//             Tab(text: "Beginner"),
//             Tab(text: "Intermediate"),
//             Tab(text: "Expert"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           // First tab: Fixed Grid View with 3 columns and 4 rows
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // 3 columns
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 4.0, // Adjust to fit text properly
//               ),
//               itemCount: cardNames.length, // Total number of items based on the list size
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Show popup window when the card is tapped
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         // Fetch data from DB
//                         return FutureBuilder<Map<String, String>>(
//                           future: fetchDataFromDB(index),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return AlertDialog(
//                                 title: Text(cardNames[index]),
//                                 content: Center(child: CircularProgressIndicator()), // Show loading indicator while fetching
//                               );
//                             } else if (snapshot.hasError) {
//                               return AlertDialog(
//                                 title: Text(cardNames[index]),
//                                 content: Text('Error: ${snapshot.error}'),
//                               );
//                             } else if (snapshot.hasData) {
//                               final data = snapshot.data!;

//                               // Create TextEditingControllers
//                               Map<String, TextEditingController> controllers = {};
//                               data.forEach((question, answer) {
//                                 controllers[question] = TextEditingController(text: answer);
//                               });

//                               return AlertDialog(
//                                 title: Text(cardNames[index]),
//                                 content: SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: data.entries.map((entry) {
//                                       String question = entry.key;
//                                       TextEditingController controller = controllers[question]!;

//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Question: $question',
//                                               style: TextStyle(fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(height: 5),
//                                             TextField(
//                                               controller: controller,
//                                               decoration: InputDecoration(
//                                                 labelText: 'Answer',
//                                                 border: OutlineInputBorder(),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     child: Text('Save'),
//                                     onPressed: () {
//                                       // Handle save logic here
//                                       // For example, you could collect the updated data and send it to your server
//                                       Navigator.of(context).pop(); // Close the popup
//                                     },
//                                   ),
//                                   TextButton(
//                                     child: Text('Close'),
//                                     onPressed: () {
//                                       Navigator.of(context).pop(); // Close the popup
//                                     },
//                                   ),
//                                 ],
//                               );
//                             } else {
//                               return AlertDialog(
//                                 title: Text(cardNames[index]),
//                                 content: Text('No data found'),
//                               );
//                             }
//                           },
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 100,  // Set the width of each grid item
//                     height: 150, // Set the height of each grid item
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           cardNames[index], // Display card name for each item
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0, // Set font size for the text
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Other tabs here...
//           Center(child: Text("Intermediate Tab Content")),
//           Center(child: Text("Expert Tab Content")),
//         ],
//       ),
//     ),
//   );
// }}

// @override 
// Widget build(BuildContext context) {
//   // List of card names
//   List<String> cardNames = [
//     "Vocabulary", "Words Usage", "Read a Passage",
//     "Grammar Test", "Make a Sentence", "Write a Story", "Chat with EDUAI",
//     "Listening to Audio", "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI",
//   ];

//   return DefaultTabController(
//     length: 3, // Three tabs: Beginner, Intermediate, Expert
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text('Synonyms Lesson'),
//         bottom: TabBar(
//           tabs: [
//             Tab(text: "Beginner"),
//             Tab(text: "Intermediate"),
//             Tab(text: "Expert"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           // First tab: Fixed Grid View with 3 columns and 4 rows
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // 3 columns
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 4.0, // Adjust to fit text properly
//               ),
//               itemCount: cardNames.length, // Total number of items based on the list size
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Show popup window when the card is tapped
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text(cardNames[index]),
//                           content: FutureBuilder<Map<String, String>>(
//                             future: fetchDataFromDB(index), // Fetch data from DB for the clicked card
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return CircularProgressIndicator(); // Show loading indicator while fetching
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else if (snapshot.hasData) {
//                                 final data = snapshot.data!;
//                                 // Show the formatted question and answer
//                                 return SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: data.entries.map((entry) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(vertical: 8.0),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'Question: ${entry.key}',
//                                               style: TextStyle(fontWeight: FontWeight.bold),
//                                             ),
//                                             SizedBox(height: 5),
//                                             Text('Answer: ${entry.value}'),
//                                           ],
//                                         ),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 );
//                               } else {
//                                 return Text('No data found');
//                               }
//                             },
//                           ),
//                           actions: [
//                             TextButton(
//                               child: Text('Close'),
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the popup
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 100,  // Set the width of each grid item
//                     height: 150, // Set the height of each grid item
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           cardNames[index], // Display card name for each item
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0, // Set font size for the text
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Other tabs here...
//           Center(child: Text("Intermediate Tab Content")),
//           Center(child: Text("Expert Tab Content")),
//         ],
//       ),
//     ),
//   );
// }
// }


// Widget build(BuildContext context) {
//   // List of card names
//   List<String> cardNames = [
//     "Vocabulary", "Words Usage", "Read a Passage",
//     "Grammar Test", "Make a Sentence", "Write a Story", "Chat with EDUAI",
//     "Listening to Audio", "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI",
//   ];

//   return DefaultTabController(
//     length: 3, // Three tabs: Beginner, Intermediate, Expert
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text('Synonyms Lesson'),
//         bottom: TabBar(
//           tabs: [
//             Tab(text: "Beginner"),
//             Tab(text: "Intermediate"),
//             Tab(text: "Expert"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           // First tab: Fixed Grid View with 3 columns and 4 rows
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // 3 columns
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 4.0, // Adjust to fit text properly
//               ),
//               itemCount: cardNames.length, // Total number of items based on the list size
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Show popup window when the card is tapped
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text(cardNames[index]),
//                           content: FutureBuilder<Map<String, String>>(
//                             future: fetchDataFromDB(index), // Fetch data from DB for the clicked card
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return CircularProgressIndicator(); // Show loading indicator while fetching
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else if (snapshot.hasData) {
//                                 final data = snapshot.data!;
//                                 // Show the formatted question and answer
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Question: ${data['question']}',
//                                       style: TextStyle(fontWeight: FontWeight.bold),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text('Answer: ${data['answer']}'),
//                                   ],
//                                 );
//                               } else {
//                                 return Text('No data found');
//                               }
//                             },
//                           ),
//                           actions: [
//                             TextButton(
//                               child: Text('Close'),
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the popup
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 100,  // Set the width of each grid item
//                     height: 150, // Set the height of each grid item
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           cardNames[index], // Display card name for each item
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0, // Set font size for the text
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Other tabs here...
//           Center(child: Text("Intermediate Tab Content")),
//           Center(child: Text("Expert Tab Content")),
//         ],
//       ),
//     ),
//   );
// }
// }






//  @override
//   Widget build(BuildContext context) {
//     // List of card names
//   List<String> cardNames = [
//     "Vocabulary ", "Words Usage", "Read a Passage",
//      "Grammer Test", "Make a  Sentence", "Write a Story","Chat with EDUAI",
//       "Listening the Audio", 
//     "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI", 
//   ];

//     return DefaultTabController(
//       length: 3, // Three tabs: Beginner, Intermediate, Expert
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Synonyms Lesson'),
//           bottom: TabBar(
//             tabs: [
//               Tab(text: "Beginner"),
//               Tab(text: "Intermediate"),
//               Tab(text: "Expert"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // First tab: Fixed Grid View with 3 columns and 4 rows
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3, // 3 columns
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 4.0, // Adjust to fit text properly
//                 ),
//                 itemCount: cardNames.length, // Total number of items based on the list size
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       // Show popup window when the card is tapped
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text(cardNames[index]),
//                             content: FutureBuilder(
//                               future: fetchDataFromDB(index), // Fetch data from DB for the clicked card
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState == ConnectionState.waiting) {
//                                   return CircularProgressIndicator(); // Show loading indicator while fetching
//                                 } else if (snapshot.hasError) {
//                                   return Text('Error: ${snapshot.error}');
//                                 } else if (snapshot.hasData) {
//                                   // Show the fetched data
//                                   return Text('Data from DB: ${snapshot.data}');
//                                 } else {
//                                   return Text('No data found');
//                                 }
//                               },
//                             ),
//                             actions: [
//                               TextButton(
//                                 child: Text('Close'),
//                                 onPressed: () {
//                                   Navigator.of(context).pop(); // Close the popup
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       width: 100,  // Set the width of each grid item
//                       height: 150, // Set the height of each grid item
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             cardNames[index], // Display card name for each item
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18.0, // Set font size for the text
//                               fontWeight: FontWeight.bold,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // Other tabs here...
//             Center(child: Text("Intermediate Tab Content")),
//             Center(child: Text("Expert Tab Content")),
//           ],
//         ),
//       ),
//     );
//   }
// // }
// @override
// Widget build(BuildContext context) {
//   // List of card names
//   List<String> cardNames = [
//     "Vocabulary", "Words Usage", "Read a Passage",
//     "Grammar Test", "Make a Sentence", "Write a Story", "Chat with EDUAI",
//     "Listening to Audio", "Sentence to Speak", "Speak with EDUAI", "Conversation with EDUAI",
//   ];

//   return DefaultTabController(
//     length: 3, // Three tabs: Beginner, Intermediate, Expert
//     child: Scaffold(
//       appBar: AppBar(
//         title: Text('Synonyms Lesson'),
//         bottom: TabBar(
//           tabs: [
//             Tab(text: "Beginner"),
//             Tab(text: "Intermediate"),
//             Tab(text: "Expert"),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           // First tab: Fixed Grid View with 3 columns and 4 rows
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3, // 3 columns
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 childAspectRatio: 4.0, // Adjust to fit text properly
//               ),
//               itemCount: cardNames.length, // Total number of items based on the list size
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     // Show popup window when the card is tapped
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text(cardNames[index]),
//                           content: FutureBuilder<String>(
//                             future: fetchDataFromDB(index), // Fetch data from DB for the clicked card
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return CircularProgressIndicator(); // Show loading indicator while fetching
//                               } else if (snapshot.hasError) {
//                                 return Text('Error: ${snapshot.error}');
//                               } else if (snapshot.hasData) {
//                                 // Show the question from the DB
//                                 return Text(snapshot.data ?? 'No question available');
//                               } else {
//                                 return Text('No data found');
//                               }
//                             },
//                           ),
//                           actions: [
//                             TextButton(
//                               child: Text('Close'),
//                               onPressed: () {
//                                 Navigator.of(context).pop(); // Close the popup
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     width: 100,  // Set the width of each grid item
//                     height: 150, // Set the height of each grid item
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 70, 71, 73), // Background color for grid items
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           cardNames[index], // Display card name for each item
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0, // Set font size for the text
//                             fontWeight: FontWeight.bold,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Other tabs here...
//           Center(child: Text("Intermediate Tab Content")),
//           Center(child: Text("Expert Tab Content")),
//         ],
//       ),
//     ),
//   );
// }
// }