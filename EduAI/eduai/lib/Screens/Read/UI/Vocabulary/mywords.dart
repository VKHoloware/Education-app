


// // import 'dart:convert';

// // import 'package:eduai/Screens/LoginRegister/UI/login.dart';
// // import 'package:eduai/Screens/Read/UI/Vocabulary/savedwords.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';

// // class MyWords extends StatefulWidget {
// //   @override
// //   _MyWordslevelState createState() => _MyWordslevelState();
// // }
// // class _MyWordslevelState extends State<MyWords> {
// //   List<Map<String, String?>> allItems = []; // Allow null for some string fields
// //   List<String> filteredItems = [];
// //   TextEditingController _searchController = TextEditingController();

// //   String? selectedPronunciation;
// //   String? selectedSimilarWords;
// //   String? selecteddefinition;
// //   String? selectedWordsexample;


// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchVocabulary();
// //   }

// //   List<Map<String, String>> cardData = [];
// //   int currentIndex = 0;
// //   // Fetch vocabulary and populate allItems
// //   void _fetchVocabulary() async {
// //     final SharedPreferences prefs = await SharedPreferences.getInstance();
// //     String? _englishProficiency = prefs.getString('englishProficency');
// //     int? _organizationID = prefs.getInt('organizationID');
// //     String _lessonLevel = 'Vocabulary';
// //     print(_englishProficiency);
    

// //     if (_englishProficiency == null || _organizationID == null) {
// //       print("Missing required fields");
// //       return;
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse(
// //           'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID',
// //         ),
// //         headers: {
// //           'Content-Type': 'application/json',
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         print(response.body);
// //         final data = jsonDecode(response.body);
// //         setState(() {
// //           // Extracting words and details from the response and storing in allItems
// //           allItems = (data['datas']['greetings'] as List<dynamic>).map((item) {
// //             return {
// //               'Words': item['Words'] as String?, // Word itself
// //               'Pronunciation': item['pronunciation'] as String?, // Nullable pronunciation
// //               'SimilarWords': item['similarwords'] as String? ,
// //               'definition': item['definition'] as String? // Nullable similar words
// //             };
// //           }).toList();
// //           filteredItems = allItems.map((item) => item['Words']!).toList(); // Initially display all words
// //         });
// //       } else {
// //         print("Failed to fetch data: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error occurred: $e");
// //     }
// //   }
// // void getapi() async {
// //   String word = _searchController.text.trim();
// //   print('Sending word to backend: $word');

// //   if (word.isEmpty) {
// //     print('Please enter a word to search.');
// //     return; // Exit if the input is empty
// //   }

// //   try {
// //     // Prepare the data to send to the backend
// //     Map<String, String> data = {'word': word};

// //     final response = await http.post(
// //       Uri.parse('http://localhost:8000/getword'), // Your Go API URL
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode(data), // Send the word as JSON
// //     );

// //     if (response.statusCode == 200) {
// //       // Parse the JSON response
// //       final responseData = json.decode(response.body);
// //       print('Response Data: $responseData'); // Print the entire response

// //       // Assuming responseData is a list
// //       if (responseData.isNotEmpty) {
// //         var firstEntry = responseData[0]; // Get the first entry
// //         var meanings = firstEntry['meanings'];

// //         // Initialize variables to hold formatted data
// //         List<String> definitionsList = [];
// //         List<String> synonymsList = [];
// //         List<String> antonymsList = [];
        
// //         // Loop through the meanings and extract definitions, synonyms, and antonyms
// //         for (var meaning in meanings) {
// //           var partOfSpeech = meaning['partOfSpeech'];
// //           print('Part of Speech: $partOfSpeech');

// //           var definitions = meaning['definitions'];
// //           if (definitions.isNotEmpty) {
// //             for (var definition in definitions) {
// //               String definitionText = definition['definition'];
// //               definitionsList.add(definitionText); // Add definition to the list
// //             }
// //           }

// //           // Fetch synonyms
// //           List<dynamic> synonyms = meaning['synonyms'];
// //           if (synonyms.isNotEmpty) {
// //             synonymsList.addAll(synonyms.cast<String>()); // Add synonyms to the list
// //           }

// //           // Fetch antonyms
// //           List<dynamic> antonyms = meaning['antonyms'];
// //           if (antonyms.isNotEmpty) {
// //             antonymsList.addAll(antonyms.cast<String>()); // Add antonyms to the list
// //           }
// //         }

// //         // Create the final formatted result
// //         Map<String, dynamic> result = {
// //           'word': word,
// //           'syn': synonymsList.isNotEmpty ? synonymsList.join(', ') : 'None',
// //           'ant': antonymsList.isNotEmpty ? antonymsList.join(', ') : 'None',
// //           'def': definitionsList,
// //         };

// //         // Update the state to display the fetched word details
// //         setState(() {
// //           selectedPronunciation = firstEntry['pronunciation']; // Ensure you fetch pronunciation
// //           selectedSimilarWords = synonymsList.join(', ');
// //           selecteddefinition = definitionsList.join(', ');
// //           print('Formatted Result: $result');
// //         });

// //       } else {
// //         print('No data available for the word: $word');
// //       }
// //     } else {
// //       print('Failed to fetch meaning: ${response.statusCode}');
// //       final errorData = json.decode(response.body);
// //       print('Error: ${errorData['error']}');
// //     }
// //   } catch (e) {
// //     print('An error occurred: $e');
// //   }
// // }


// // // Filter the vocabulary based on search input
// // void _filterItems(String query) {
// //   setState(() {
// //     // Filter allItems based on the 'Words' field
// //     filteredItems = allItems
// //         .where((item) => item['Words']?.toLowerCase().contains(query.toLowerCase()) ?? false)
// //         .map((item) => item['Words']!) // Ensure the filtered result is a list of words (String)
// //         .toList();
// //   });
// // }
// // void _onWordSelected(String word) {
// //   setState(() {
// //     _searchController.text = word; // Set the text to the selected word
// //     final selectedItem = allItems.firstWhere((item) => item['Words'] == word);
// //     selectedPronunciation = selectedItem['Pronunciation'];
// //     selectedSimilarWords = selectedItem['SimilarWords'];
// //     selecteddefinition = selectedItem['definition'];
// //     // selectedWordsexample = selectedItem['SimilarWords'];

    
// //     // Clear filtered items to prevent showing other options
// //     filteredItems = []; // or set it to [word] if you want to show the selected item
// //   });
// // }

// // Future<void> _submitWord() async {
// //   print(2);
// //   String _message = '';

// //   // Ensure that a word has been selected before submitting
// //   if (_searchController.text.isNotEmpty &&
// //       selectedPronunciation != null &&
// //       selecteddefinition != null &&
// //       selectedSimilarWords != null) {
    
// //     // Create a JSON object with the selected data
// //     final Map<String, dynamic> data = {
// //       'id': 2, // Example ID. Replace this with the actual ID if needed.
// //       'mywords': [
// //         {
// //           'Word': _searchController.text, // Selected word from the search field
// //           'Definition': selecteddefinition,
// //           'Pronunciation': selectedPronunciation,
// //           'SimilarWords': selectedSimilarWords,
// //         }
// //       ]
// //     };

// //     // Make the POST request
// //     try {
// //       final response = await http.post(
// //         Uri.parse('http://localhost:8000/savewords'), // Update this URL as needed
// //         headers: {'Content-Type': 'application/json'},
// //         body: json.encode(data), // Encode the JSON object
// //       );

// //       if (response.statusCode == 200) {
// //         // If the server returns an OK response, parse the message
// //         final responseData = json.decode(response.body);
// //         setState(() {
// //           _message = responseData['message']; // Success message from the server
// //         });
// //         print("Success: $_message");
        
// //         // Clear the selected word fields after submission
// //         setState(() {
// //           _searchController.clear();
// //           selectedPronunciation = null;
// //           selectedSimilarWords = null;
// //           selecteddefinition = null;
// //           filteredItems = []; // Clear filtered list
// //         });
// //       } else {
// //         // Handle the case where the server returns an error
// //         final responseData = json.decode(response.body);
// //         setState(() {
// //           _message = 'Error: ${responseData['error']}'; // Error message from the server
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _message = 'An error occurred: $e'; // Handle error
// //       });
// //     }
// //   } else {
// //     print("No word or incomplete data available for submission.");
// //     setState(() {
// //       _message = 'Please select a word and ensure all fields are filled.';
// //     });
// //   }
  
// //   print(_message); // Log the message
// // }


// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     appBar: AppBar(
// //       title: Text('Autocomplete Search Box'),
// //     ),
// //     body: Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: Column(
// //         children: [
// //           // Search TextField
// //           // TextField(
// //           //   controller: _searchController,
// //           //   onChanged: _filterItems,
// //           //   decoration: InputDecoration(
// //           //     labelText: 'Search',
// //           //     suffixIcon: _searchController.text.isNotEmpty
// //           //         ? IconButton(
// //           //             icon: Icon(Icons.clear),
// //           //             onPressed: () {
// //           //               _searchController.clear();
// //           //               _filterItems('');
// //           //             },
// //           //           )
// //           //         : null,
// //           //     border: OutlineInputBorder(),
// //           //   ),
// //           // ),
// //          TextField(
// //               controller: _searchController,
// //               decoration: InputDecoration(
// //                 labelText: 'Search',
// //                 suffixIcon: IconButton(
// //                   icon: Icon(Icons.search),
// //                   onPressed: () {
// //                     getapi(); // Call the function on search button press
// //                   },
// //                 ),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //           // Display the card directly below the search box
// //           if (selectedPronunciation != null || selectedSimilarWords != null || selecteddefinition != null)
// //             Padding(
// //               padding: const EdgeInsets.only(top: 20.0),
// //               child: Card(
// //                 elevation: 4,
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             if (selectedPronunciation != null)
// //                               Text(
// //                                 'Pronunciation: $selectedPronunciation',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             if (selectedSimilarWords != null)
// //                               Text(
// //                                 'Similar Words: $selectedSimilarWords',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             if (selecteddefinition != null)
// //                               Text(
// //                                 'Definition: $selecteddefinition',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                       IconButton(
// //                         onPressed: () => _submitWord(),
// //                         icon: Icon(Icons.add),
// //                         tooltip: "Save the word",
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),

// //           // Add a gap below the card before the containers
// //           SizedBox(height: 20), // Gap of 20 pixels

// //           // Two containers below the card
// //         Row(
// //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //   children: [
// //     // First Container with GestureDetector
// //     GestureDetector(
// //       onTap: () {
// //           Navigator.pushAndRemoveUntil(
// //                   context,
// //                   MaterialPageRoute(builder: (context) => Savedwords()),
// //                   (route) => true,
// //                 );
// //       },
// //       child: Container(
// //         width: MediaQuery.of(context).size.width / 2 - 24, // Adjust the width accordingly
// //         height: 100, // Set a height for the container
// //         color: const Color.fromARGB(255, 220, 225, 230), // Example color
// //         child: const Center(child: Text("Saved Data 1")),
// //       ),
// //     ),
// //     const SizedBox(width: 8), // Spacer between containers
// //     // Second Container with GestureDetector
// //     GestureDetector(
// //       onTap: () {
// //         // Navigator.push(
// //         //   context,
// //         //   MaterialPageRoute(builder: (context) => SavedDataPage2()),
// //         // );
// //       },
// //       child: Container(
// //         width: MediaQuery.of(context).size.width / 2 - 24, // Adjust the width accordingly
// //         height: 100, // Set a height for the container
// //         color: const Color.fromARGB(255, 235, 245, 235), // Example color
// //         child: const Center(child: Text("Saved Data 2")),
// //       ),
// //     ),
// //   ],
// // ),


// //           // ListView to display filtered items
// //           Expanded(
// //             child: filteredItems.isNotEmpty && _searchController.text.isNotEmpty
// //                 ? ListView.builder(
// //                     itemCount: filteredItems.length,
// //                     itemBuilder: (context, index) {
// //                       return ListTile(
// //                         title: Text(filteredItems[index]),
// //                         onTap: () {
// //                           _onWordSelected(filteredItems[index]);
// //                         },
// //                       );
// //                     },
// //                   )
// //                 : Container(), // Hide the ListView if no filtered items
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }
// // }

// // // @override
// // // Widget build(BuildContext context) {
// // //   return Scaffold(
// // //     appBar: AppBar(
// // //       title: Text('Autocomplete Search Box'),
// // //     ),
// // //     body: Padding(
// // //       padding: const EdgeInsets.all(16.0),
// // //       child: Column(
// // //         children: [
// // //           // Search TextField
// // //           TextField(
// // //             controller: _searchController,
// // //             onChanged: _filterItems,
// // //             decoration: InputDecoration(
// // //               labelText: 'Search',
// // //               suffixIcon: _searchController.text.isNotEmpty
// // //                   ? IconButton(
// // //                       icon: Icon(Icons.clear),
// // //                       onPressed: () {
// // //                         _searchController.clear();
// // //                         _filterItems('');
// // //                       },
// // //                     )
// // //                   : null,
// // //               border: OutlineInputBorder(),
// // //             ),
// // //           ),
          
// // //           // Display the card directly below the search box
// // //           if (selectedPronunciation != null || selectedSimilarWords != null || selecteddefinition != null)
// // //             Padding(
// // //               padding: const EdgeInsets.only(top: 20.0),
// // //               child: Card(
// // //                 elevation: 4,
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(16.0),
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                     children: [
// // //                       Expanded(
// // //                         child: Column(
// // //                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                           children: [
// // //                             if (selectedPronunciation != null)
// // //                               Text(
// // //                                 'Pronunciation: $selectedPronunciation',
// // //                                 style: TextStyle(fontWeight: FontWeight.bold),
// // //                               ),
// // //                             if (selectedSimilarWords != null)
// // //                               Text(
// // //                                 'Similar Words: $selectedSimilarWords',
// // //                                 style: TextStyle(fontWeight: FontWeight.bold),
// // //                               ),
// // //                             if (selecteddefinition != null)
// // //                               Text(
// // //                                 'Definition: $selecteddefinition',
// // //                                 style: TextStyle(fontWeight: FontWeight.bold),
// // //                               ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                       IconButton(
// // //                         onPressed: () => print(2),
// // //                         icon: Icon(Icons.add),
// // //                         tooltip: "Save the word",
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),

// // //           // Two containers below the card
// // //           Padding(
// // //             padding: const EdgeInsets.only(top: 20.0),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 // First Container
// // //                 Container(
// // //                   width: MediaQuery.of(context).size.width / 2 - 24, // Adjust the width accordingly
// // //                   height: 100, // Set a height for the container
// // //                   color: Colors.blue, // Example color
// // //                   child: Center(child: Text("Container 1")),
// // //                 ),
// // //                 SizedBox(width: 8), // Spacer between containers
// // //                 // Second Container
// // //                 Container(
// // //                   width: MediaQuery.of(context).size.width / 2 - 24, // Adjust the width accordingly
// // //                   height: 100, // Set a height for the container
// // //                   color: Colors.green, // Example color
// // //                   child: Center(child: Text("Container 2")),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),

// // //           // ListView to display filtered items
// // //           Expanded(
// // //             child: filteredItems.isNotEmpty && _searchController.text.isNotEmpty
// // //                 ? ListView.builder(
// // //                     itemCount: filteredItems.length,
// // //                     itemBuilder: (context, index) {
// // //                       return ListTile(
// // //                         title: Text(filteredItems[index]),
// // //                         onTap: () {
// // //                           _onWordSelected(filteredItems[index]);
// // //                         },
// // //                       );
// // //                     },
// // //                   )
// // //                 : Container(), // Hide the ListView if no filtered items
// // //           ),
// // //         ],
// // //       ),
// // //     ),
// // //   );
// // // }
// // // }




// // // import 'dart:convert';

// // // import 'package:eduai/Screens/LoginRegister/UI/login.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:shared_preferences/shared_preferences.dart';



// // // class MyWords extends StatefulWidget {
// // //   @override
// // //   _MyWordslevelState createState() => _MyWordslevelState();
// // // }

// // // class _MyWordslevelState extends State<MyWords> {
// // //   int currentIndex = 0;
// // //   List<Map<String, String>> cardData=[];


// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchVocabulary();
// // //   }


// // // void _fetchVocabulary() async {
// // //   // Retrieve values from SharedPreferences
// // //   final SharedPreferences prefs = await SharedPreferences.getInstance();

// // //   // Get the values of englishProficiency and organizationID
// // //   String? _englishProficiency = prefs.getString('englishProficency'); // Note the corrected spelling
// // //   int? _organizationID = prefs.getInt('organizationID');
// // //   String _lessonLevel = 'Vocabulary';

// // //   print('EP: $_englishProficiency');
// // //   print('OrganizationID: $_organizationID');

// // //   // Check if all required values are available before making the request
// // //   if (_englishProficiency == null || _organizationID == null) {
// // //     print("Missing required fields");
// // //     return;
// // //   }

// // //   try {
// // //     // Construct the query string using the retrieved values
// // //     final response = await http.get(
// // //       Uri.parse(
// // //           'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID'), // Ensure "OrganisationId" matches your Go API
// // //       headers: {
// // //         'Content-Type': 'application/json',
// // //       },
// // //     );

// // //     if (response.statusCode == 200) {
// // //       // Parse the JSON data
// // //       final data = jsonDecode(response.body);
// // //       print(data);

// // //       setState(() {
// // //         // Correctly access the greetings list
// // //         cardData = (data['datas']['greetings'] as List<dynamic>).map((item) {
// // //           return Map<String, String>.from(item);
// // //         }).toList();
// // //       });

// // //       print(cardData.length);
// // //     } else {
// // //       print("Failed to fetch data: ${response.body}");
// // //     }
// // //   } catch (e) {
// // //     print("Error occurred: $e");
// // //   }
// // // }

// // //   // // Define your card details here
// // //   // final List<Map<String, String>> cardDetails = [
// // //   //   {
// // //   //     "greeting": "Hello",
// // //   //     "pronunciation": "/həˈloʊ/, /hɛˈloʊ/",
// // //   //     "similarwords":"hullo,howdy,how-do-you-do,hi",
// // //   //     "definition": "A word we say when we see someone and want to greet them, or when we begin to talk on the phone",
// // //   //     "example": "Hello, how are you?"
// // //   //   },
// // //   //   {
// // //   //     "greeting": "Hi",
// // //   //     "pronunciation": "/haɪ/",
// // //   //     "definition": "A casual greeting used between friends or acquaintances.",
// // //   //     "similarwords":"hullo,howdy,how-do-you-do,hi",
// // //   //     "example": "Hi there! Nice to see you."
// // //   //   },
// // //   //   {
// // //   //     "greeting": "Greetings",
// // //   //     "pronunciation": "/ˈɡriːtɪŋz/",
// // //   //     "definition": "Words or actions that express goodwill or respect when meeting someone.",
// // //   //     "similarwords":"hullo,howdy,how-do-you-do,hi",

// // //   //     "example": "Greetings, my friend!"
// // //   //   },
// // //   //   // Add more card details as needed
// // //   // ];

// // //   // void nextCard() {
// // //   //   setState(() {
// // //   //     currentIndex = (currentIndex + 1) % cardData.length; // Loop back to the first card
// // //   //   });
// // //   // }
// // // @override
// // // Widget build(BuildContext context) {
// // //   return Scaffold(
// // //     appBar: PreferredSize(
// // //       preferredSize: Size.fromHeight(70.0),
// // //       child: Padding(
// // //         padding: const EdgeInsets.only(top: 16.0),
// // //         child: AppBar(
// // //           title: Row(
// // //             children: [
// // //               Text("Search Greetings"),
// // //               Spacer(),
// // //               IconButton(
// // //                 onPressed: () async {
// // //                   // Clear SharedPreferences data
// // //                   SharedPreferences prefs = await SharedPreferences.getInstance();
// // //                   await prefs.clear();

// // //                   Navigator.pushAndRemoveUntil(
// // //                     context,
// // //                     MaterialPageRoute(builder: (context) => Login()),
// // //                     (route) => false,
// // //                   );
// // //                 },
// // //                 icon: Tooltip(
// // //                   message: "Logout", // Hover text
// // //                   child: Icon(Icons.account_circle_outlined),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     ),
// // //     body: Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding around the search box
// // //       child: Column( // Use Column to stack the search box and cards vertically
// // //         children: [
// // //           Opacity(
// // //             opacity: 0.8, // Set the desired opacity level (0.0 to 1.0)
// // //             child: SizedBox( // Wrap the TextField in a SizedBox to control its size
// // //               width: 300, // Set the desired width for the TextField
// // //               child: TextField(
// // //                 onChanged: (value) {
// // //                   // Handle search logic here
// // //                 },
// // //                 decoration: InputDecoration(
// // //                   labelText: 'Search', // Label for the search box
// // //                   border: OutlineInputBorder(), // Outline border
// // //                   suffixIcon: Icon(Icons.search), // Search icon
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //           SizedBox(height: 20), // Space between the search box and card container
// // //           Row( // Use Row to display cards in a horizontal layout
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between cards
// // //             children: [
// // //               Expanded( // Make the first card take the remaining width
// // //                 child: Container(
// // //                   height: 250, // Adjusted height for the card
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white, // Background color for the card container
// // //                     borderRadius: BorderRadius.circular(10), // Rounded corners
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2), // Shadow color
// // //                         spreadRadius: 2, // Spread radius
// // //                         blurRadius: 10, // Blur radius
// // //                         offset: Offset(0, 4), // Offset of the shadow
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(16.0), // Padding inside the container
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text("Add New Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //                         SizedBox(height: 10), // Space between text elements
// // //                         Text(".", style: TextStyle(color: Colors.grey)),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               SizedBox(width: 16), // Space between the two cards
// // //               Expanded( // Make the second card take the remaining width
// // //                 child: Container(
// // //                   height: 250, // Adjusted height for the card
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white, // Background color for the card container
// // //                     borderRadius: BorderRadius.circular(10), // Rounded corners
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2), // Shadow color
// // //                         spreadRadius: 2, // Spread radius
// // //                         blurRadius: 10, // Blur radius
// // //                         offset: Offset(0, 4), // Offset of the shadow
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.all(16.0), // Padding inside the container
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       children: [
// // //                         Text("Existing word container", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// // //                         SizedBox(height: 10), // Space between text elements
// // //                         Text("Existing word based on topic.", style: TextStyle(color: Colors.grey)),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     ),
// // //   );
// // // }
// // // }

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:eduai/Screens/Read/UI/Vocabulary/vocabularytest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// class MyWords extends StatefulWidget {
//   @override
//   _MyWordslevelState createState() => _MyWordslevelState();
// }

// class _MyWordslevelState extends State<MyWords> {
//   List<Map<String, String?>> allItems = [];
//   List<String> filteredItems = [];
//   TextEditingController _searchController = TextEditingController();

//   String? selectedPronunciation;
//   String? selectedSimilarWords;
//   String? selecteddefinition;
//   String? selectedPartOfSpeech;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVocabulary();
//   }

//   // Fetch vocabulary and populate allItems
//   void _fetchVocabulary() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? _englishProficiency = prefs.getString('englishProficency');
//     int? _organizationID = prefs.getInt('organizationID');
//     String _lessonLevel = 'Vocabulary';

//     if (_englishProficiency == null || _organizationID == null) {
//       print("Missing required fields");
//       return;
//     }

//     try {
//       final response = await http.get(
//         Uri.parse(
//           'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID',
//         ),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           allItems = (data['datas']['greetings'] as List<dynamic>).map((item) {
//             return {
//               'Words': item['Words'] as String?,
//               'Pronunciation': item['pronunciation'] as String?,
//               'SimilarWords': item['similarwords'] as String?,
//               'definition': item['definition'] as String?,
//             };
//           }).toList();
//           filteredItems = allItems.map((item) => item['Words']!).toList();
//         });
//       } else {
//         print("Failed to fetch data: ${response.body}");
//       }
//     } catch (e) {
//       print("Error occurred: $e");
//     }
//   }
  
//  final AudioPlayer audioPlayer = AudioPlayer();  
//     final FlutterTts flutterTts = FlutterTts();

//   Future<void> _playAudio(word) async {


//   // Future<void> _speak(word) async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(word);
//   // }
    
//     // if (audioFilePath != null) {
//     //   await audioPlayer.play(DeviceFileSource(audioFilePath!));
//     // } else {
//     //   print("Audio file path is null.");
//     // }
//   }

// void getapi() async {
//   String word = _searchController.text.trim();
//   if (word.isEmpty) {
//     print('Please enter a word to search.');
//     return;
//   }

//   try {
//     Map<String, String> data = {'word': word};
//     final response = await http.post(
//       Uri.parse('http://localhost:8000/getword'),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(data),
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       if (responseData.isNotEmpty) {
//         var firstEntry = responseData[0];
//         var meanings = firstEntry['meanings'];
//         List<String> definitionsList = [];
//         List<String> synonymsList = [];
//         List<String> antonymsList = [];
//         List<String> partOfSpeechList = []; // List to hold parts of speech

//         for (var meaning in meanings) {
//           var partOfSpeech = meaning['partOfSpeech'];
//           partOfSpeechList.add(partOfSpeech); // Add part of speech to the list
//           var definitions = meaning['definitions'];
//           if (definitions.isNotEmpty) {
//             for (var definition in definitions) {
//               definitionsList.add(definition['definition']);
//             }
//           }
//           synonymsList.addAll(meaning['synonyms']?.cast<String>() ?? []);
//           antonymsList.addAll(meaning['antonyms']?.cast<String>() ?? []);
//         }

//         setState(() {
//           selectedPronunciation = firstEntry['pronunciation'];
//           selectedSimilarWords = synonymsList.join(', ');
//           selecteddefinition = definitionsList.join(', ');
//           selectedPartOfSpeech = partOfSpeechList.join(', '); // Join parts of speech
//         });
//         print(meanings);
//       } else {
//         print('No data available for the word: $word');
//       }
//     } else {
//       print('Failed to fetch meaning: ${response.statusCode}');
//       final errorData = json.decode(response.body);
//       print('Error: ${errorData['error']}');
//     }
//   } catch (e) {
//     print('An error occurred: $e');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Autocomplete Search Box'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.clear),
//                       onPressed: () {
//                         _searchController.clear();
//                         setState(() {
//                           selectedPronunciation = null;
//                           selectedSimilarWords = null;
//                           selecteddefinition = null;
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: getapi,
//                     ),
//                   ],
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             if (selectedPronunciation != null ||
//                 selectedSimilarWords != null ||
//                 selecteddefinition != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 20.0),
//   //               child: Card(
//   //                 elevation: 4,
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.all(16.0),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       if (selectedPronunciation != null)
//   //                         Text('Pronunciation: $selectedPronunciation'),
//   //                       if (selectedSimilarWords != null)
//   //                         Text('Similar Words: $selectedSimilarWords'),
//   //                       if (selecteddefinition != null)
//   //                         Text('Definition: $selecteddefinition'),
//   //                         if (selectedPartOfSpeech != null) // Add this condition
//   // Text(
//   //   'Part of Speech: $selectedPartOfSpeech', // Display the part of speech
//   //   style: TextStyle(fontWeight: FontWeight.bold),
//   // ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   child: Card(
//   elevation: 4,
//   child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (selectedPronunciation != null)
//           Text('Pronunciation: $selectedPronunciation'),
//         if (selectedSimilarWords?.isNotEmpty == true) // Use null-aware access
//           Text('Similar Words: $selectedSimilarWords'),
//         if (selecteddefinition?.isNotEmpty == true) // Use null-aware access
//           Text('Definition: $selecteddefinition'),
//         if (selectedPartOfSpeech?.isNotEmpty == true) // Use null-aware access
//           Text(
//             'Part of Speech: $selectedPartOfSpeech', // Display the part of speech
//             // style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//          IconButton(onPressed:()=> _playAudio(_searchController.text), icon:Tooltip(
//                 message: "Play Prounce",
//                 child: Icon(Icons.multitrack_audio_rounded),
//               ), )
//       ],
//     ),
//   ),
// ),

//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// //  final AudioPlayer audioPlayer = AudioPlayer();  
// //   Future<void> _playAudio(word) async {


// //   // Future<void> _speak(word) async {
// //     await flutterTts.setLanguage("en-US");
// //     await flutterTts.speak(word);
// //   // }
    
// //     // if (audioFilePath != null) {
// //     //   await audioPlayer.play(DeviceFileSource(audioFilePath!));
// //     // } else {
// //     //   print("Audio file path is null.");
// //     // }
// //   }
class MyWords extends StatefulWidget {
  @override
  _MyWordslevelState createState() => _MyWordslevelState();
}

class _MyWordslevelState extends State<MyWords> {
  List<Map<String, String?>> allItems = [];
  List<String> filteredItems = [];
  TextEditingController _searchController = TextEditingController();

  String? selectedPronunciation;
  String? selectedSimilarWords;
  String? selecteddefinition;
  String? selectedPartOfSpeech;
  bool _isNodata=false;

  @override
  void initState() {
    super.initState();
    _fetchVocabulary();
  }

  // Fetch vocabulary and populate allItems
  void _fetchVocabulary() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _englishProficiency = prefs.getString('englishProficency');
    int? _organizationID = prefs.getInt('organizationID');
    String _lessonLevel = 'Vocabulary';

    if (_englishProficiency == null || _organizationID == null) {
      print("Missing required fields");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
          'http://localhost:8000/fetchvocabulary?LessonLevel=$_lessonLevel&UserLevel=$_englishProficiency&OrganisationId=$_organizationID',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          allItems = (data['datas']['greetings'] as List<dynamic>).map((item) {
            return {
              'Words': item['Words'] as String?,
              'Pronunciation': item['pronunciation'] as String?,
              'SimilarWords': item['similarwords'] as String?,
              'definition': item['definition'] as String?,
            };
          }).toList();
          filteredItems = allItems.map((item) => item['Words']!).toList();
        });
      } else {
        print("Failed to fetch data: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  final FlutterTts flutterTts = FlutterTts();

  Future<void> _playAudio(String word) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(word);
  }
  void getapi() async {
  String word = _searchController.text.trim();
  if (word.isEmpty) {
    print('Please enter a word to search.');
    setState(() {
      _isNodata = true; // Show "Enter the correct word" message
    });
    return;
  }

  try {
    Map<String, String> data = {'word': word};
    final response = await http.post(
      Uri.parse('http://localhost:8000/getword'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData != null && responseData.isNotEmpty) {
        var firstEntry = responseData[0];
        var meanings = firstEntry['meanings'];
        List<String> definitionsList = [];
        List<String> synonymsList = [];
        List<String> antonymsList = [];
        List<String> partOfSpeechList = []; // List to hold parts of speech

        for (var meaning in meanings) {
          var partOfSpeech = meaning['partOfSpeech'];
          partOfSpeechList.add(partOfSpeech); // Add part of speech to the list
          var definitions = meaning['definitions'];
          if (definitions.isNotEmpty) {
            for (var definition in definitions) {
              definitionsList.add(definition['definition']);
            }
          }
          synonymsList.addAll(meaning['synonyms']?.cast<String>() ?? []);
          antonymsList.addAll(meaning['antonyms']?.cast<String>() ?? []);
        }

        setState(() {
          _isNodata = false; // Data exists, hide "Enter correct word" message
          selectedPronunciation = firstEntry['pronunciation'];
          selectedSimilarWords = synonymsList.join(', ');
          selecteddefinition = definitionsList.join(', ');
          selectedPartOfSpeech = partOfSpeechList.join(', '); // Join parts of speech
        });
        print(meanings);
      } else {
        setState(() {
          _isNodata = true; // Show "Enter correct word" message if data is empty
           selectedPronunciation = '';
          selectedSimilarWords = '';
          selecteddefinition =  '';
          selectedPartOfSpeech =  '';
        });
        print('No data available for the word: $word');
      }
    } else {
      print('Failed to fetch meaning: ${response.statusCode}');
      final errorData = json.decode(response.body);
      print('Error: ${errorData['error']}');
         setState(() {
          _isNodata = true; // Show "Enter correct word" message if data is empty
           selectedPronunciation = '';
          selectedSimilarWords = '';
          selecteddefinition =  '';
          selectedPartOfSpeech =  '';
        });
    }
  } catch (e) {
    print('An error occurred: $e');
    setState(() {
      _isNodata = true; // Show "Enter correct word" on exception
    });
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Autocomplete Search Box'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           TextField(
  //             controller: _searchController,
  //             decoration: InputDecoration(
  //               labelText: 'Search',
  //               suffixIcon: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   IconButton(
  //                     icon: Icon(Icons.clear),
  //                     onPressed: () {
  //                       _searchController.clear();
  //                       setState(() {
  //                         selectedPronunciation = null;
  //                         selectedSimilarWords = null;
  //                         selecteddefinition = null;
  //                         selectedPartOfSpeech = null;
  //                       });
  //                     },
  //                   ),
  //                   IconButton(
  //                     icon: Icon(Icons.search),
  //                     onPressed: getapi,
  //                   ),
  //                 ],
  //               ),
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           SizedBox(height: 20),
  //           if (selectedPronunciation != null ||
  //               selectedSimilarWords != null ||
  //               selecteddefinition != null ||
  //               selectedPartOfSpeech != null)
  //             // If any of the fields are not null, display the card with data
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20.0),
  //               child: Card(
  //                 elevation: 4,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       if (selectedPronunciation != null)
  //                         Text('Pronunciation: $selectedPronunciation'),
  //                       if (selectedSimilarWords?.isNotEmpty == true)
  //                         Text('Similar Words: $selectedSimilarWords'),
  //                       if (selecteddefinition?.isNotEmpty == true)
  //                         Text('Definition: $selecteddefinition'),
  //                       if (selectedPartOfSpeech?.isNotEmpty == true)
  //                         Text('Part of Speech: $selectedPartOfSpeech'),
  //                             !_isNodata?
  // IconButton(
  //                         onPressed: () => _playAudio(_searchController.text),
  //                         icon: Tooltip(
  //                           message: "Play Pronunciation",
  //                           child: Icon(Icons.multitrack_audio_rounded),
  //                         ),
  //                       ):SizedBox()
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             )
  //           else
  //             // If all fields are null, display the "No word found" message
  //             Padding(
  //               padding: const EdgeInsets.only(top: 20.0),
  //               child: Card(
  //                 elevation: 4,
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text(
  //                     'No word found',
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Autocomplete Search Box'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        selectedPronunciation = null;
                        selectedSimilarWords = null;
                        selecteddefinition = null;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: getapi,
                  ),
                ],
              ),
              border: OutlineInputBorder(),
            ),
          ),
TextButton(
          onPressed: () {
            // Navigate to TestPage when button is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VocabularyTest()),
            );
          },
          child: Text("Go to Test"),
        ),
          if (selectedPronunciation != null ||
              selectedSimilarWords != null ||
              selecteddefinition != null ||
              selectedPartOfSpeech != null)
            // Display data when fields are populated
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedPronunciation != null)
                        Text('Pronunciation: $selectedPronunciation'),
                      if (selectedSimilarWords?.isNotEmpty == true)
                        Text('Similar Words: $selectedSimilarWords'),
                      if (selecteddefinition?.isNotEmpty == true)
                        Text('Definition: $selecteddefinition'),
                      if (selectedPartOfSpeech?.isNotEmpty == true)
                        Text('Part of Speech: $selectedPartOfSpeech'),
                      !_isNodata
                          ? IconButton(
                              onPressed: () => _playAudio(_searchController.text),
                              icon: Tooltip(
                                message: "Play Pronunciation",
                                child: Icon(Icons.multitrack_audio_rounded),
                              ),
                            )
                          : SizedBox(), // Empty widget if no pronunciation is available
                    ],
                  ),
                ),
              ),
            )
          else if (_isNodata)
            // Show "Enter the correct word" message when no data is available
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Enter the correct word',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          else
            // Default "No word found" message
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No word found',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

}
