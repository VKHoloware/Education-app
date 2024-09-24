import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  Map<String, String> vocabularyData = {};
  bool isLoading = true;
  final List<TextEditingController> _questionControllers = [];
  final List<TextEditingController> _answerControllers = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromDB(); // Fetch data when the widget is initialized
  }

  Future<void> fetchDataFromDB() async {
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulating network delay

      final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> dataList = jsonResponse['data'];

        Map<String, String> result = {};

        for (var item in dataList) {
          if (item is Map<String, dynamic>) {
            String datas = item['datas'];
            final Map<String, dynamic> datasJson = jsonDecode(datas);

            for (var entry in datasJson['entrylevelquestions']) {
              if (entry is Map<String, dynamic>) {
                String question = entry['question'] ?? '';
                String answer = entry['answer'] ?? '';
                result[question] = answer;
              }
            }
          }
        }

        setState(() {
          vocabularyData = result; // Update the state with fetched data
          isLoading = false; // Data loading is complete

          // Initialize controllers for each question and answer
          _questionControllers.clear();
          _answerControllers.clear();
          vocabularyData.forEach((question, answer) {
            _questionControllers.add(TextEditingController(text: question));
            _answerControllers.add(TextEditingController(text: answer));
          });
        });
      } else {
        setState(() {
          vocabularyData = {'Error': 'Failed to fetch data'};
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        vocabularyData = {'Error': 'Error: $e'};
        isLoading = false;
      });
    }
  }
 void _saveQuestions() {
  TextEditingController levelController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Save Questions"),
        content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Text("Level"),
            TextField(
              controller: levelController, 
              decoration: InputDecoration(
                hintText: "Enter the level",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              String level = levelController.text;
              print('Level saved: $level');

              // Close the dialog
              Navigator.of(context).pop();
            },
            child: Text("Save"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      );
    },
  );
}


@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Vocabulary Level'),
    ),
    body: isLoading
        ? Center(child: CircularProgressIndicator()) // Show loading indicator
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: vocabularyData.length,
                  itemBuilder: (context, index) {
                    String question = vocabularyData.keys.elementAt(index);
                    String answer = vocabularyData[question] ?? 'No answer';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _questionControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Question',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 8),
                              TextField(
                                controller: _answerControllers[index],
                                decoration: InputDecoration(
                                  labelText: 'Answer',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
_saveQuestions();            
                },
                child: Text('Save Changes'),
              ),
              SizedBox(height: 16), // Add some spacing below the button
            ],
          ),
  );
}
}

