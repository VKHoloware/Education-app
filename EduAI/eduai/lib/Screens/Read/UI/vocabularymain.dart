// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class VocabularyFetcher extends StatefulWidget {
//   @override
//   _VocabularyFetcherState createState() => _VocabularyFetcherState();
// }

// class _VocabularyFetcherState extends State<VocabularyFetcher> {
//   String _lessonLevel = 'Vocabulary'; // Example lesson level
//   String _userLevel = 'Beginner'; // Example user level
//   List<dynamic> _vocabularyData = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchVocabulary();
  // }

// //   void _fetchVocabulary() async {
// //         final SharedPreferences prefs = await SharedPreferences.getInstance();


// // String? _englishProficency=await prefs.getString('englishProficency');
// // int? _organizationID=await prefs.getInt('organizationID');

// //     print('EP:$_englishProficency');
// //     print('EP:$_organizationID');

// //     try {
// //       final response = await http.get(
// //         Uri.parse('http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficency&organizationID=2'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         // Parse the JSON data
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           _vocabularyData = data['datas']; // Update the state with the fetched data
// //         });
// //       } else {
// //         print("Failed to fetch data: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error occurred: $e");
// //     }
// //   }
// void _fetchVocabulary() async {
//   // Retrieve values from SharedPreferences
//   final SharedPreferences prefs = await SharedPreferences.getInstance();

//   // Get the values of englishProficiency and organizationID
//   String? _englishProficiency = prefs.getString('englishProficency'); // Note the corrected spelling
//   int? _organizationID = prefs.getInt('organizationID');

//   print('EP:$_englishProficiency');
//   print('OrganizationID:$_organizationID');

//   // Check if all required values are available before making the request
//   if (_englishProficiency == null || _organizationID == null) {
//     print("Missing required fields");
//     return;
//   }

//   try {
//     // Construct the query string using the retrieved values
//     final response = await http.get(
//       Uri.parse(
//           'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID'), // Ensure "OrganisationId" matches your Go API
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       // Parse the JSON data
//       final data = jsonDecode(response.body);
//       setState(() {
//         _vocabularyData = data['datas']; // Update the state with the fetched data
//       });
//     } else {
//       print("Failed to fetch data: ${response.body}");
//     }
//   } catch (e) {
//     print("Error occurred: $e");
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vocabulary Fetcher'),
//       ),
//       body: ListView.builder(
//         itemCount: _vocabularyData.length,
//         itemBuilder: (context, index) {
//           final item = _vocabularyData[index];
//           return ListTile(
//             title: Text(item['word'] ?? 'No word'),
//             subtitle: Text('Synonyms: ${item['synonyms'] ?? 'N/A'}\n'
//                 'Antonyms: ${item['antonyms'] ?? 'N/A'}\n'
//                 'Phonetics: ${item['phonetics'] ?? 'N/A'}\n'
//                 'Hint: ${item['hint'] ?? 'N/A'}'),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:eduai/Screens/LoginRegister/UI/UserRegistration.dart';
import 'package:eduai/Screens/Read/UI/Vocabulary/vocabulary.dart';
import 'package:eduai/Screens/Read/UI/readmainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Comman/UI/Customcard.dart';
import '../../LoginRegister/UI/login.dart';
import '../../Teacher/UI/Vocabulary/Function/vocabulary.dart';
import 'Vocabulary/mywords.dart';

class VocabularyMainpage extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<VocabularyMainpage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = 250.0; // Fixed card width
    final cardHeight = 250.0; // Fixed card height

    final gapBetweenCards = (screenWidth - 2 * cardWidth) / 3; // Gap between cards in first two rows
    final gapForThreeCards = (screenWidth - 3 * cardWidth) / 4; // Gap between cards in the third row

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            title: Row(
              children: [
                Text("Vocabulary"),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false,
                    );
                  },
                  icon: Tooltip(
                    message: "Logout", // Hover text
                    child: Icon(Icons.account_circle_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // First row: Two cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyWords(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "My Words",
                          data: ["Add your Words to search the meaning."],
                        ),
                      ),
                    ),
                  ),
                                    SizedBox(width: gapBetweenCards), // Gap between cards

                   GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Vocabulary1(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Vocabulary",
                      data: ["To learn Words with Phonetics"],
                        ),
                      ),
                    ),
                  ),
             
                ],
              ),
              SizedBox(height: 40), // Vertical gap between rows

              // Second row: Two cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Readmainpage(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Idioms & Expressions",
                          data: ["Check the Idioms based on the Topics."],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: gapBetweenCards), // Gap between cards
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    child: CustomCard(
                      height: cardHeight,
                      width: cardWidth,
                      label: "Topical Vocabulary",
                      data: ["Vocabulary based on the Topics"],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40), // Vertical gap between rows

              // Third row: Three cards
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    child: CustomCard(
                      height: cardHeight,
                      width: cardWidth,
                      label: "Adverb",
                      data: ["Here, you will find a variety of adverbs grouped by meanings, topics, and more, helping you explore their different uses and contexts."],
                    ),
                  ),
                  SizedBox(width: gapForThreeCards), // Gap between cards
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    child: CustomCard(
                      height: cardHeight,
                      width: cardWidth,
                      label: "Verb",
                      data: ["Here, you will find a variety of verbs grouped by meanings, topics, and more, helping you explore their different uses and contexts."],
                    ),
                  ),
                  SizedBox(width: gapForThreeCards), // Gap between cards
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    child: CustomCard(
                      height: cardHeight,
                      width: cardWidth,
                      label: "Adjectives",
                      data: ["Here, you will find a variety of adjectives grouped by meanings, topics, and more, helping you explore their different uses and contexts."],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
