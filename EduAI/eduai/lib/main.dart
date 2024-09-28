import 'dart:io';
import 'package:eduai/Screens/Mainpage/UI/mainpage.dart';
import 'package:eduai/Screens/Read/UI/Vocabulary/mywords.dart';
import 'package:eduai/Screens/Read/UI/Vocabulary/vocabulary.dart';
import 'package:eduai/Screens/Read/UI/vocabularymain.dart';
import 'package:eduai/Screens/Teacher/UI/dashboard.dart';
import 'package:eduai/Screens/Teacher/UI/lessons.dart';
import 'package:flutter/material.dart';






import 'package:eduai/Screens/LoginRegister/UI/login.dart';

import 'Screens/EntryTest/UI/Entrylevel.dart';
import 'Screens/LoginRegister/UI/UserRegistration.dart';
import 'Screens/Read/UI/Vocabulary/vocabularymainpage.dart';
import 'Screens/Teacher/UI/Vocabulary/UI/vocabularytest.dart';
import 'Screens/Read/UI/readmainpage.dart';
import 'Screens/Teacher/UI/lessons.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.blue, 
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Colors.blue, 
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: const Color.fromARGB(179, 0, 0, 0)),
          selectedLabelTextStyle: TextStyle(color: Colors.white),
          unselectedLabelTextStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
        ),
      ),
    //  home:Student(),
      // home: VocabularyTest(),
      home: Login(),


    );
  }
} 


























// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SearchAutocomplete(),
//     );
//   }
// }

// class SearchAutocomplete extends StatefulWidget {
//   @override
//   _SearchAutocompleteState createState() => _SearchAutocompleteState();
// }

// class _SearchAutocompleteState extends State<SearchAutocomplete> {
//   List<String> allItems = [
//     'apple',
//     'apple butter',
//     'apple cider vinegar',
//     'apple green',
//     'apple-green',
//     'apple juice',
//     'apple pie',
//     'apple sauce',
//     'apple scab',
//     'apple tree'
//   ];
//   List<String> filteredItems = [];
//   TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     filteredItems = allItems;
//   }

//   void _filterItems(String query) {
//     setState(() {
//       filteredItems = allItems
//           .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

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
//               onChanged: _filterItems,
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 suffixIcon: _searchController.text.isNotEmpty
//                     ? IconButton(
//                         icon: Icon(Icons.clear),
//                         onPressed: () {
//                           _searchController.clear();
//                           _filterItems('');
//                         },
//                       )
//                     : null,
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             Expanded(
//               child: filteredItems.isNotEmpty && _searchController.text.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: filteredItems.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(filteredItems[index]),
//                           onTap: () {
//                             _searchController.text = filteredItems[index];
//                             // Optionally handle selection
//                           },
//                         );
//                       },
//                     )
//                   : Container(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TTSPage(),
//     );
//   }
// }

// class TTSPage extends StatefulWidget {
//   @override
//   _TTSPageState createState() => _TTSPageState();
// }

// class _TTSPageState extends State<TTSPage> {
//   final FlutterTts flutterTts = FlutterTts();
//   final TextEditingController controller = TextEditingController();

//   Future<void> _speak() async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.speak(controller.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Text to Speech')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: controller),
//             ElevatedButton(
//               onPressed: _speak,
//               child: Text('Play'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';

// class Base64AudioPlayer extends StatefulWidget {
//   final String base64Audio;

//   Base64AudioPlayer({required this.base64Audio});

//   @override
//   _Base64AudioPlayerState createState() => _Base64AudioPlayerState();
// }

// class _Base64AudioPlayerState extends State<Base64AudioPlayer> {
//   String? audioFilePath;
//   AudioPlayer audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     _convertBase64ToAudio();
//   }

//   Future<void> _convertBase64ToAudio() async {
//     // Decode the Base64 string
//     final decodedBytes = base64Decode(widget.base64Audio);

//     // Get the directory to store the audio file
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/audio.wav'; // Use appropriate extension

//     // Write the bytes to a file
//     final File audioFile = File(filePath);
//     await audioFile.writeAsBytes(decodedBytes);

//     setState(() {
//       audioFilePath = filePath;
//     });
//   }

//   Future<void> _playAudio() async {
//     if (audioFilePath != null) {
//       await audioPlayer.play(DeviceFileSource(audioFilePath!));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Base64 Audio Player'),
//       ),
//       body: Center(
//         child: audioFilePath == null
//             ? CircularProgressIndicator()
//             : ElevatedButton(
//                 onPressed: _playAudio,
//                 child: Text('Play Audio'),
//               ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // Replace this with your actual Base64-encoded audio string
//     String base64Audio = "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";

//     return MaterialApp(
//       home: Base64AudioPlayer(base64Audio: base64Audio),
//     );
//   }
// }
