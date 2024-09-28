import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Savedwords extends StatefulWidget {
  @override
  _SavedWordsState createState() => _SavedWordsState();
}

class _SavedWordsState extends State<Savedwords> {
  List<dynamic> _words = []; // List to store the words from the API

  Future<void> _submitWord() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8000/getwords?id=2'), // Ensure this URL is correct
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _words = responseData['words']; // Save the words list in state
        });
      } else {
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _submitWord(); // Fetch words when the widget is first loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Words'),
      ),
      body: _words.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading spinner until data is fetched
          : ListView.builder(
              itemCount: _words.length, // Number of cards (based on fetched data)
              itemBuilder: (context, index) {
                final wordData = _words[index]; // Extract word data for each index
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wordData['Word'] ?? '',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Definition: ${wordData['Definition'] ?? ''}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pronunciation: ${wordData['Pronunciation'] ?? ''}',
                          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
