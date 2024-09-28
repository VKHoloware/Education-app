
import 'dart:convert';
import 'dart:io';
import 'package:eduai/Screens/Read/UI/Vocabulary/vocabularytest.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../LoginRegister/UI/login.dart';

class Vocabulary1 extends StatefulWidget {
  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<Vocabulary1> {
  final AudioPlayer audioPlayer = AudioPlayer();
   final FlutterTts flutterTts = FlutterTts();
  final TextEditingController controller = TextEditingController();

  Future<void> _speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(controller.text);
  }
  String? audioFilePath;
  List<Map<String, String>> cardData = [];
  int currentIndex = 0;
  bool _isIndividual=false;

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
// Future<void> _submitWord() async {
//   print(2);
//   String _message = '';

//  if (cardData.isNotEmpty && currentIndex < cardData.length) {
//     var currentWordData = cardData[currentIndex];
//     String word = currentWordData["Words"] ?? "N/A";
//     String definition = currentWordData["definition"] ?? "N/A";
//     String pronounce = currentWordData["pronunciation"] ?? "N/A";

//     // int totalData = cardData.length;
//  // Create a map for the JSON structure
//     Map<String, dynamic> jsonOutput = {
//       "Word": word,
//       "Definition": definition,
//       "Pronunciation": pronounce,
//       // "TotalData": totalData,
//     };

//     // Convert map to JSON string
//     String jsonString = jsonEncode(jsonOutput);

//     // Print the JSON string
//     print(jsonString);
 
//   // Create a JSON object
//   final Map<String, dynamic> data = {
//     'id': 2, // Ensure this matches your structure.AddWords definition
//     'mywords':jsonString
//   };

//   // Make the POST request
//   try {
//     final response = await http.post(
//       Uri.parse('http://localhost:8000/savewords'), // Ensure this URL is correct
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data), // Encode the JSON object
//     );

//     if (response.statusCode == 200) {
//       // If the server returns an OK response, parse the message
//       final responseData = json.decode(response.body);
//       setState(() {
//         _message = responseData['message']; // Get success message
//       });
//     } else {
//       // If the server did not return a 200 OK response, throw an error.
//       final responseData = json.decode(response.body);
//       setState(() {
//         _message = 'Error: ${responseData['error']}'; // Get error message
//       });
//     }
//   } catch (e) {
//     setState(() {
//       _message = 'An error occurred: $e'; // Handle error
//     });
//   }
//    } else {
//     print("No data available.");
//   }
// }

void getapi() async {
  String word = "Hello";
  print('Sending word to backend: $word');

  try {
    // Prepare the data to send to the backend
    Map<String, String> data = {'word': word};

    final response = await http.post(
      Uri.parse('http://localhost:8000/getword'), // Your Go API URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data), // Send the word as JSON
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final responseData = json.decode(response.body);
      print('Response Data: $responseData'); // Print the entire response

      // Assuming responseData is a list
      if (responseData.isNotEmpty) {
        var firstEntry = responseData[0]; // Get the first entry
        var meanings = firstEntry['meanings'];

        // Initialize variables to hold formatted data
        List<String> definitionsList = [];
        List<String> synonymsList = [];
        List<String> antonymsList = [];
        
        // Loop through the meanings and extract definitions, synonyms, and antonyms
        for (var meaning in meanings) {
          var partOfSpeech = meaning['partOfSpeech'];
          print('Part of Speech: $partOfSpeech');

          var definitions = meaning['definitions'];
          if (definitions.isNotEmpty) {
            for (var definition in definitions) {
              String definitionText = definition['definition'];
              definitionsList.add(definitionText); // Add definition to the list
            }
          }

          // Fetch synonyms
          List<dynamic> synonyms = meaning['synonyms'];
          if (synonyms.isNotEmpty) {
            synonymsList.addAll(synonyms.cast<String>()); // Add synonyms to the list
          }

          // Fetch antonyms
          List<dynamic> antonyms = meaning['antonyms'];
          if (antonyms.isNotEmpty) {
            antonymsList.addAll(antonyms.cast<String>()); // Add antonyms to the list
          }
        }

        // Create the final formatted result
        Map<String, dynamic> result = {
          'word': word,
          'syn': synonymsList.isNotEmpty ? synonymsList.join(', ') : 'None',
          'ant': antonymsList.isNotEmpty ? antonymsList.join(', ') : 'None',
          'def': definitionsList,
        };

        // Print the formatted result
        print('Formatted Result: $result');

      } else {
        print('No data available for the word: $word');
      }
    } else {
      print('Failed to fetch meaning: ${response.statusCode}');
      final errorData = json.decode(response.body);
      print('Error: ${errorData['error']}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}


Future<void> _submitWord() async {
  print(2);
  String _message = '';

  if (cardData.isNotEmpty && currentIndex < cardData.length) {
    var currentWordData = cardData[currentIndex];
    String word = currentWordData["Words"] ?? "N/A";
    String definition = currentWordData["definition"] ?? "N/A";
    String pronounce = currentWordData["pronunciation"] ?? "N/A";

    // Create a JSON object
    final Map<String, dynamic> data = {
      'id': 2, // Ensure this matches your structure.AddWords definition
      'mywords': [
        {
          'Word': word,
          'Definition': definition,
          'Pronunciation': pronounce,
        }
      ] // Ensure it's a list of maps
    };

    // Make the POST request getwords
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/savewords'), // Ensure this URL is correct
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data), // Encode the JSON object
      );
      //  final response = await http.get(
      //   Uri.parse('http://localhost:8000/getwords?id=2'), // Ensure this URL is correct
      //   headers: {'Content-Type': 'application/json'},
      //   // body: json.encode(data), // Encode the JSON object
      // );
print(response.body);

      if (response.statusCode == 200) {
        // If the server returns an OK response, parse the message
        final responseData = json.decode(response.body);
        setState(() {
          _message = responseData['message']; // Get success message
        });
      } else {
        // If the server did not return a 200 OK response, throw an error.
        final responseData = json.decode(response.body);
        setState(() {
          _message = 'Error: ${responseData['error']}'; // Get error message
        });
      }
      print(_message);
    } catch (e) {
      setState(() {
        _message = 'An error occurred: $e'; // Handle error
      });
    }
  } else {
    print("No data available.");
  }
        print(_message);

}

void checkstudent() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  
  // Get the 'role' value from SharedPreferences
  String? role = prefs.getString('role');
  
  // Print the role value for debugging
  print(1);
  print(role);

  // Check if the role is empty or null, and set _isIndividual to true if it is
  if (role == null || role.isEmpty) {
    _isIndividual = true;
  } else {
    _isIndividual = false;
  }

  // Print the value of _isIndividual for debugging
  print('_isIndividual: $_isIndividual');
}


  Future<void> _playAudio(word) async {


  // Future<void> _speak(word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(word);
  // }
    
    // if (audioFilePath != null) {
    //   await audioPlayer.play(DeviceFileSource(audioFilePath!));
    // } else {
    //   print("Audio file path is null.");
    // }
  }

  void _fetchVocabulary() async {
    checkstudent();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _englishProficiency = prefs.getString('englishProficency');
    int? _organizationID = prefs.getInt('organizationID');
    String _lessonLevel = 'Vocabulary';
    print(_englishProficiency);
    print('EP:$_englishProficiency');


    // if (_englishProficiency == null || _organizationID == null) {
    //   print("Missing required fields");
    //   return;
    // }

    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      print(response.body.runtimeType);


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          cardData = (data['datas'] as List<dynamic>).map((item) {
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

  @override
  void initState() {
    super.initState();
    _fetchVocabulary(); // Fetch vocabulary data when the widget is initialized
    checkstudent();
  }
  final List<String> _roles = ['Teacher'];
  String? data; // Declare this variable at the class level

void _saveWords() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Save the Word"),
        content: Container(
          width: 300, // You can set a fixed width for the dialog
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the dialog wrap its content
            children: [
          
              SizedBox(height: 20), // Add some space before the next dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Folder Name',
                ),
                value: data, // Use the same variable or a different one
                items: _roles.map<DropdownMenuItem<String>>((String proficiency) {
                  return DropdownMenuItem<String>(
                    value: proficiency,
                    child: Text(proficiency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    data = newValue; // Update the state
                  });
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
void _submitWords() {
  // Assuming cardData is a List<Map<String, dynamic>>
  if (cardData.isNotEmpty && currentIndex < cardData.length) {
    var currentWordData = cardData[currentIndex];
    String word = currentWordData["Words"] ?? "N/A";
    String definition = currentWordData["definition"] ?? "N/A";
    String pronounce = currentWordData["pronunciation"] ?? "N/A";

    // int totalData = cardData.length;
 // Create a map for the JSON structure
    Map<String, dynamic> jsonOutput = {
      "Word": word,
      "Definition": definition,
      "Pronunciation": pronounce,
      // "TotalData": totalData,
    };

    // Convert map to JSON string
    String jsonString = jsonEncode(jsonOutput);

    // Print the JSON string
    print(jsonString);
  } else {
    print("No data available.");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                message: "Logout",
                child: Icon(Icons.account_circle_outlined),
              ),
            ),
          ],
        ),
      ),
      body: cardData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: 500,
                    width: 1000,
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
                    child: Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          // _buildInfoRow("Word: ", cardData[currentIndex]["Words"]),
                          Row(
  mainAxisSize: MainAxisSize.min, // Adjust to take only the needed width
  children: [
                          _buildInfoRow("Word: ", cardData[currentIndex]["Words"]),

IconButton(onPressed:()=> getapi(), icon:Tooltip(
                message: "Add to our words",
                child: Icon(Icons.add),
              ), )

  ],
),
                          SizedBox(height: 20),
 SizedBox(height: 20),

   
   
  Row(
  mainAxisSize: MainAxisSize.min, // Adjust to take only the needed width
  children: [
    _buildInfoRow("Pronunciation: ", cardData[currentIndex]["pronunciation"]),
   IconButton(onPressed:()=> _playAudio(cardData[currentIndex]["Words"]), icon:Tooltip(
                message: "Play Prounce",
                child: Icon(Icons.multitrack_audio_rounded),
              ), )

  ],
),


                          SizedBox(height: 20),
                          _buildInfoRow("Definition: ", cardData[currentIndex]["definition"]),
                          SizedBox(height: 20),
                          _buildInfoRow("Similar Words: ", cardData[currentIndex]["similarwords"]),
                          SizedBox(height: 20),
                          _buildInfoRow("Example: ", cardData[currentIndex]["example"]),
                          SizedBox(height: 20),
                          _buildNextButton(),
                        !_isIndividual 
  ? ElevatedButton(
      onPressed: () {
        // Navigate to VocabularyTest screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VocabularyTest()),
        );
      },
      child: Text('Go to Test'),
    )
  : SizedBox.shrink(),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(8.0),
          child: Text(
            "$label$value",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: nextCard,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          )),
          elevation: MaterialStateProperty.all(8),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color.fromARGB(255, 1, 14, 36).withOpacity(0.5);
              }
              if (states.contains(MaterialState.pressed)) {
                return const Color.fromARGB(255, 68, 255, 84).withOpacity(0.7);
              }
              return null;
            },
          ),
        ),
        child: Text('Next'),
      ),
    );
  }



}