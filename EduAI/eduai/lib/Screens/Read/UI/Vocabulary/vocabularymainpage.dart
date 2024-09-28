import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:eduai/Screens/LoginRegister/UI/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VocabularyMainlevel extends StatefulWidget {
  @override 
  _Vocabulary createState() => _Vocabulary();
}

class _Vocabulary extends State<VocabularyMainlevel> {
  final AudioPlayer audioPlayer = AudioPlayer();
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController controller = TextEditingController();
  String? audioFilePath;
  List<Map<String, String>> cardData = [];
  bool _isHoveredNext = false;
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();
    _fetchVocabulary();
  }

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(controller.text);
  }

  Future<void> _convertBase64ToAudio(String base64String) async {
    final decodedBytes = base64Decode(base64String);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/audio.wav';

    final File audioFile = File(filePath);
    await audioFile.writeAsBytes(decodedBytes);

    setState(() {
      audioFilePath = filePath;
    });
  }

  Future<void> _submitWord() async {
    String _message = '';

    if (cardData.isNotEmpty && currentIndex < cardData.length) {
      var currentWordData = cardData[currentIndex];
      String word = currentWordData["Words"] ?? "N/A";
      String definition = currentWordData["definition"] ?? "N/A";
      String pronounce = currentWordData["pronunciation"] ?? "N/A";

      final Map<String, dynamic> data = {
        'id': 2,
        'mywords': [
          {
            'Word': word,
            'Definition': definition,
            'Pronunciation': pronounce,
          }
        ]
      };

      try {
        final response = await http.post(
          Uri.parse('http://localhost:8000/savewords'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(data),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          setState(() {
            _message = responseData['message'];
          });
        } else {
          final responseData = json.decode(response.body);
          setState(() {
            _message = 'Error: ${responseData['error']}';
          });
        }
      } catch (e) {
        setState(() {
          _message = 'An error occurred: $e';
        });
      }
    } else {
      print("No data available.");
    }
    print(_message);
  }

  Future<void> _playAudio(String word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(word);
  }

  void _fetchVocabulary() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _englishProficiency = prefs.getString('englishProficency');
    int? _organizationID = prefs.getInt('organizationID');
    String _lessonLevel = 'Vocabulary';

    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cardData = (data['datas']['greetings'] as List<dynamic>).map((item) {
            return Map<String, String>.from(item);
          }).toList();
        });
      } else {
        print("Failed to fetch data: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % cardData.length;
    });
  }
  void _showAlertDialog() {
  showDialog(
    context: context, // Make sure context is available
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Audio Playback Error"),
        content: Text("Did not pronounce the  word "),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

  bool _isHovered = false; // Initialize hover state

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            title: Row(
              children: [
                Text(
                  "Vocabulary Page", 
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Spacer(),
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovered = false;
                    });
                  },
                  child: IconButton(
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
                      message: "Logout",
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: _isHovered ? Colors.red : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          SizedBox(width:100),

          Expanded(
            
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 3.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  child:
                  Card(
  elevation: 0,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns items with space between
        //   children: [
        //     Expanded( // Wrap it in Expanded to take the available space
        //       child: _buildWordRow(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
        //     ),
            
        //     IconButton(
        //       onPressed: () => _submitWord(),
        //       icon: Tooltip(
        //         message: "Add to our words",
        //         child: Icon(Icons.add),
        //       ),
        //     ),
        //   ],
          
        // ),
        // SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Aligns items with space between
        //   children: [
        //   Expanded(child:  _buildpronounceRow( cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),),
        //     Row(
        //       children: [
        //         IconButton(
        //           onPressed: () {
        //             // Check if cardData is not empty and the current word is not null
        //             final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
        //             if (word != null) {
        //               _playAudio(word); // Call the method only if the word is not null
        //             } else {
        //               // Handle the case where the word is null (e.g., show a message)
        //               _showAlertDialog(); // Call the function to show the dialog
        //             }
        //           },
        //           icon: Tooltip(
        //             message: "Play Pronunciation",
        //             child: Icon(Icons.multitrack_audio_rounded),
        //           ),
        //         ),
        //         _buildNextButton(), // Add the "Next" button
        //       ],
        //     ),
        //   ],
        // ),
          //  Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       _buildWordRow(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
          //       _buildpronounceRow(cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
          //        IconButton(
          //             onPressed: () {
          //               final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
          //               if (word != null) {
          //                 _playAudio(word); // Call the method only if the word is not null
          //               } else {
          //                 _showAlertDialog(); // Show dialog if the word is null
          //               }
          //             },
          //             icon: Tooltip(
          //               message: "Play Pronunciation",
          //               child: Icon(Icons.multitrack_audio_rounded),
          //             ),
          //           ),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           IconButton(
          //             onPressed: () {
          //               final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
          //               if (word != null) {
          //                 _playAudio(word); // Call the method only if the word is not null
          //               } else {
          //                 _showAlertDialog(); // Show dialog if the word is null
          //               }
          //             },
          //             icon: Tooltip(
          //               message: "Play Pronunciation",
          //               child: Icon(Icons.multitrack_audio_rounded),
          //             ),
          //           ),
          //           _buildNextButton(), // Add the "Next" button
          //         ],
          //       ),
          //     ],
          //   ),
          // Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // children: [
          //   // Word Row
          //   _buildWordRow(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
          //   SizedBox(height: 10), // Add some spacing
          //   // Pronunciation Row with Audio Button
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Expanded(
          //         child: _buildpronounceRow(cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
          //       ),
          //       IconButton(
          //         onPressed: () {
          //           final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
          //           if (word != null) {
          //             _playAudio(word); // Call the method only if the word is not null
          //           } else {
          //             _showAlertDialog(); // Show dialog if the word is null
          //           }
          //         },
          //         icon: Tooltip(
          //           message: "Play Pronunciation",
          //           child: Icon(Icons.multitrack_audio_rounded),
          //         ),
          //       ),
          //     ],
          //   ),
          //   SizedBox(height: 20), // Space before the Next button
          //   // Next Button Row
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       _buildNextButton(), // Add the "Next" button
          //     ],
          //   ),
          // ],),
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Word Row
            _buildWordRow(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
            SizedBox(height: 10), // Add some spacing
            // Pronunciation Row with Audio Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildpronounceRow(cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
                ),
                IconButton(
                  onPressed: () {
                    final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
                    if (word != null) {
                      _playAudio(word); // Call the method only if the word is not null
                    } else {
                      _showAlertDialog(); // Show dialog if the word is null
                    }
                  },
                  icon: Tooltip(
                    message: "Play Pronunciation",
                    child: Icon(Icons.multitrack_audio_rounded),
                  ),
                ),
                // Next Button
                IconButton(
                  onPressed: () {
                    // Handle the action for the "Next" button
                    _buildNextButton();
                  },
                  icon: Tooltip(
                    message: "Next",
                    child: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ],
        ),
    
        SizedBox(height: 20),
        ExpansionTile(
          title: Text("Details"),
          children: [
            _buildInfoRow("Definition: ", cardData.isNotEmpty ? cardData[currentIndex]["definition"] : "N/A"),
            SizedBox(height: 20),
            _buildInfoRow("Similar Words: ", cardData.isNotEmpty ? cardData[currentIndex]["similarwords"] : "N/A"),
            SizedBox(height: 20),
            _buildInfoRow("Example: ", cardData.isNotEmpty ? cardData[currentIndex]["example"] : "N/A"),
          ],
        ),
        SizedBox(height: 20),
      ],
    ),
  ),
),



                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  
Widget _buildNextButton() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHoveredNext = true; // Change hover state on mouse enter
        });
      },
      onExit: (_) {
        setState(() {
          _isHoveredNext = false; // Change hover state on mouse exit
        });
      },
      child: IconButton(
        onPressed: cardData.isNotEmpty ? nextCard : null, // Check if there is card data to proceed
        icon: Tooltip(
          message: "Next word",
          child: Icon(
            Icons.navigate_next,
            color: !_isHoveredNext ? Color.fromARGB(255, 8, 5, 216) : Colors.blue, // Change color based on hover state
          ),
        ),
      ),
    ),
  );
}




  Widget _buildInfoRow(String label, String? value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(width: 10),
        Flexible(
          child: Text(
            value ?? "N/A",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

 Widget _buildWordRow(String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the row horizontally
    children: [
      SizedBox(width: 10),
      Flexible(
        child: Text(
          value ?? "N/A",
          textAlign: TextAlign.center, // Center the text within the flexible widget
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(width: 10), // Add space after the text
    ],
  );
}

 Widget _buildpronounceRow(String? value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center, // Center the row horizontally
    children: [
      SizedBox(width: 10),
      Flexible(
        child: Text(
          value ?? "N/A",
          textAlign: TextAlign.center, // Center the text within the flexible widget
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      SizedBox(width: 10), // Add space after the text
    ],
  );
}
// }

//   Widget _buildInfoRow(String label, String value) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(width: 10),
//         Expanded(child: Text(value)),
//       ],
//     );
//   }
// }


///---------------------------------------------------


// import 'dart:convert';
// import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:eduai/Screens/LoginRegister/UI/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class VocabularyMainlevel extends StatefulWidget {
//   @override 
//   _Vocabulary createState() => _Vocabulary();
// }

// class _Vocabulary extends State<VocabularyMainlevel> {
//   final AudioPlayer audioPlayer = AudioPlayer();
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController controller = TextEditingController();
//   String? audioFilePath;
//   List<Map<String, String>> cardData = [];
//   int currentIndex = 0;

//   Future<void> _speak() async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(controller.text);
//   }

//   Future<void> _convertBase64ToAudio(String base64String) async {
//     final decodedBytes = base64Decode(base64String);
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/audio.wav';

//     final File audioFile = File(filePath);
//     await audioFile.writeAsBytes(decodedBytes);

//     setState(() {
//       audioFilePath = filePath;
//     });
//   }

//   Future<void> _submitWord() async {
//     String _message = '';

//     if (cardData.isNotEmpty && currentIndex < cardData.length) {
//       var currentWordData = cardData[currentIndex];
//       String word = currentWordData["Words"] ?? "N/A";
//       String definition = currentWordData["definition"] ?? "N/A";
//       String pronounce = currentWordData["pronunciation"] ?? "N/A";

//       final Map<String, dynamic> data = {
//         'id': 2,
//         'mywords': [
//           {
//             'Word': word,
//             'Definition': definition,
//             'Pronunciation': pronounce,
//           }
//         ]
//       };

//       try {
//         final response = await http.post(
//           Uri.parse('http://localhost:8000/savewords'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode(data),
//         );

//         if (response.statusCode == 200) {
//           final responseData = json.decode(response.body);
//           setState(() {
//             _message = responseData['message'];
//           });
//         } else {
//           final responseData = json.decode(response.body);
//           setState(() {
//             _message = 'Error: ${responseData['error']}';
//           });
//         }
//       } catch (e) {
//         setState(() {
//           _message = 'An error occurred: $e';
//         });
//       }
//     } else {
//       print("No data available.");
//     }
//     print(_message);
//   }

//   Future<void> _playAudio(String word) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(word);
//   }

//   void _fetchVocabulary() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? _englishProficiency = prefs.getString('englishProficency');
//     int? _organizationID = prefs.getInt('organizationID');
//     String _lessonLevel = 'Vocabulary';

//     try {
//       final response = await http.get(
//         Uri.parse(
//             'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID'),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           cardData = (data['datas']['greetings'] as List<dynamic>).map((item) {
//             return Map<String, String>.from(item);
//           }).toList();
//         });
//       } else {
//         print("Failed to fetch data: ${response.body}");
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//     }
//   }

//   void nextCard() {
//     setState(() {
//       currentIndex = (currentIndex + 1) % cardData.length;
//     });
//   }

//   bool _isHovered = false; // Initialize hover state




//   @override 
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: Padding(
//           padding: const EdgeInsets.only(top: 16.0),
//           child: AppBar(
//             title: Row(
//               children: [
//                 Text(
//                   "Vocabulary Page", 
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Spacer(),
//                 MouseRegion(
//                   onEnter: (_) {
//                     setState(() {
//                       _isHovered = true;
//                     });
//                   },
//                   onExit: (_) {
//                     setState(() {
//                       _isHovered = false;
//                     });
//                   },
//                   child: IconButton(
//                     onPressed: () async {
//                       SharedPreferences prefs = await SharedPreferences.getInstance();
//                       await prefs.clear();

//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (context) => Login()),
//                         (route) => false,
//                       );
//                     },
//                     icon: Tooltip(
//                       message: "Logout",
//                       child: Icon(
//                         Icons.account_circle_outlined,
//                         color: _isHovered ? Colors.red : Colors.blue,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Row(
//         children: [
//           SizedBox(width:100),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Align(
//                 alignment: Alignment.topLeft,
//                 child: Opacity(
//                   opacity: 0.8,
//                   child: Container(
//                     height: 400,
//                     width: 400,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 10,
//                           offset: Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Card(
//                       elevation: 0,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 20),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildInfoRow("Word: ", cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
//                               IconButton(
//                                 onPressed: () => _submitWord(),
//                                 icon: Tooltip(
//                                   message: "Add to our words",
//                                   child: Icon(Icons.add),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               _buildInfoRow("Pronunciation: ", cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
//                               IconButton(
//                                 onPressed: () => print(1),
//                                 // _playAudio(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
//                                 icon: Tooltip(
//                                   message: "Play Pronunciation",
//                                   child: Icon(Icons.multitrack_audio_rounded),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           _buildInfoRow("Definition: ", cardData.isNotEmpty ? cardData[currentIndex]["definition"] : "N/A"),
//                           SizedBox(height: 20),
//                           _buildInfoRow("Similar Words: ", cardData.isNotEmpty ? cardData[currentIndex]["similarwords"] : "N/A"),
//                           SizedBox(height: 20),
//                           _buildInfoRow("Example: ", cardData.isNotEmpty ? cardData[currentIndex]["example"] : "N/A"),
//                           SizedBox(height: 20),
//                           _buildNextButton(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           // Additional widgets can go here
//         ],
//       ),
//     );
// //   }
// @override 
// Widget build(BuildContext context) {
//   // Get the screen width and height
//   final screenWidth = MediaQuery.of(context).size.width;
//   final screenHeight = MediaQuery.of(context).size.height;

//   // Calculate card size as one-fourth of the screen dimensions
//   final cardWidth = screenWidth / 4;
//   final cardHeight = screenHeight / 4;

//   return Scaffold(
//     appBar: PreferredSize(
//       preferredSize: Size.fromHeight(70.0),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 16.0),
//         child: AppBar(
//           title: Row(
//             children: [
//               Text(
//                 "Vocabulary Page", 
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Spacer(),
//               MouseRegion(
//                 onEnter: (_) {
//                   setState(() {
//                     _isHovered = true;
//                   });
//                 },
//                 onExit: (_) {
//                   setState(() {
//                     _isHovered = false;
//                   });
//                 },
//                 child: IconButton(
//                   onPressed: () async {
//                     SharedPreferences prefs = await SharedPreferences.getInstance();
//                     await prefs.clear();

//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Login()),
//                       (route) => false,
//                     );
//                   },
//                   icon: Tooltip(
//                     message: "Logout",
//                     child: Icon(
//                       Icons.account_circle_outlined,
//                       color: _isHovered ? Colors.red : Colors.blue,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//     body: Row(
//       children: [
//         SizedBox(width: 100),
//         Expanded(
//           child: SingleChildScrollView(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Opacity(
//                 opacity: 0.8,
//                 child: Container(
//                   height: cardHeight, // Set height to one-fourth of screen height
//                   width: cardWidth, // Set width to one-fourth of screen width
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         spreadRadius: 2,
//                         blurRadius: 10,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Card(
//                     elevation: 0,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             _buildInfoRow("Word: ", cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
//                             IconButton(
//                               onPressed: () => _submitWord(),
//                               icon: Tooltip(
//                                 message: "Add to our words",
//                                 child: Icon(Icons.add),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             _buildInfoRow("Pronunciation: ", cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
//                             IconButton(
//                               onPressed: () =>print(975),
                              
//                               //  _playAudio(cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
//                               icon: Tooltip(
//                                 message: "Play Pronunciation",
//                                 child: Icon(Icons.multitrack_audio_rounded),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         _buildInfoRow("Definition: ", cardData.isNotEmpty ? cardData[currentIndex]["definition"] : "N/A"),
//                         SizedBox(height: 20),
//                         _buildInfoRow("Similar Words: ", cardData.isNotEmpty ? cardData[currentIndex]["similarwords"] : "N/A"),
//                         SizedBox(height: 20),
//                         _buildInfoRow("Example: ", cardData.isNotEmpty ? cardData[currentIndex]["example"] : "N/A"),
//                         SizedBox(height: 20),
//                         _buildNextButton(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Additional widgets can go here
//       ],
//     ),
//   );
// }


//   Widget _buildNextButton() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       child: ElevatedButton(
//         onPressed: cardData.isNotEmpty ? nextCard : null, // Disable if no data
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.green),
//           foregroundColor: MaterialStateProperty.all(Colors.white),
//           padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
//           shape: MaterialStateProperty.all(RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           )),
//           elevation: MaterialStateProperty.all(8),
//           overlayColor: MaterialStateProperty.resolveWith<Color?>(
//             (Set<MaterialState> states) {
//               if (states.contains(MaterialState.hovered)) {
//                 return const Color.fromARGB(255, 1, 14, 36).withOpacity(0.5);
//               }
//               if (states.contains(MaterialState.pressed)) {
//                 return Colors.blue.withOpacity(0.5);
//               }
//               return null; // Defer to the widget's default.
//             },
//           ),
//         ),
//         child: const Text('Next', style: TextStyle(fontSize: 20)),
//       ),
//     );
//   }


  // @override
  // void initState() {
  //   super.initState();
  //   _fetchVocabulary();
  // }




// Card(
//   elevation: 0,
//   child: SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,  
//           children: [
//             _buildInfoRow("Word: ", cardData.isNotEmpty ? cardData[currentIndex]["Words"] : "N/A"),
//             IconButton(
//               onPressed: () => _submitWord(),
//               icon: Tooltip(
//                 message: "Add to our words",
//                 child: Icon(Icons.add),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildInfoRow("Pronunciation: ", cardData.isNotEmpty ? cardData[currentIndex]["pronunciation"] : "N/A"),
//             IconButton(
//               onPressed: () {
//                 final word = cardData.isNotEmpty ? cardData[currentIndex]["Words"] : null;
//                 if (word != null) {
//                   _playAudio(word); 
//                 } else {
//                   // print("No word available to play audio.");
//       _showAlertDialog();
//                 }
//               },
//               icon: Tooltip(
//                 message: "Play Pronunciation",
//                 child: Icon(Icons.multitrack_audio_rounded),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         ExpansionTile(
//           title: Text("Details"),
//           children: [
//             _buildInfoRow("Definition: ", cardData.isNotEmpty ? cardData[currentIndex]["definition"] : "N/A"),
//             SizedBox(height: 20),
//             _buildInfoRow("Similar Words: ", cardData.isNotEmpty ? cardData[currentIndex]["similarwords"] : "N/A"),
//             SizedBox(height: 20),
//             _buildInfoRow("Example: ", cardData.isNotEmpty ? cardData[currentIndex]["example"] : "N/A"),
//           ],
//         ),
//         SizedBox(height: 20),
//         _buildNextButton(),
//       ],
//     ),
//   ),
// ),