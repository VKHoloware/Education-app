import 'dart:convert';
import 'dart:math';
import 'package:eduai/Screens/EntryTest/Function/Entrylevel.dart';
import 'package:eduai/Screens/Mainpage/UI/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Entrylevel extends StatefulWidget {
  @override
  _Entrylevel createState() => _Entrylevel();
}

class _Entrylevel extends State<Entrylevel> {
  String? _selectedOption;
  String _fillInAnswer = '';
  int _currentQuestionIndex = 0;
  int _score = 0; // Score tracker
  bool _isTestFinished = false; // Flag to track completion
  List<Question> _questions = [];
  final TextEditingController _fillInController = TextEditingController();
  EntrylevelData _entrylevelData = EntrylevelData();

  @override
  void initState() {
    super.initState();
    fetchQuestions(); // Fetch questions when the widget initializes
  }

  Future<void> fetchQuestions() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/data'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _questions = (data['entrylevelquestions'] as List)
              .map((item) => Question.fromJson(item))
              .toList();
          _shuffleQuestions(); // Shuffle questions after fetching
        });
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      // Handle exceptions and errors
      print('Error fetching questions: $e');
    }
  }

  void _shuffleQuestions() {
    final random = Random();
    _questions.shuffle(random); // Shuffle questions list
  }

  void _nextQuestion() {
    if (_selectedOption != null || _fillInAnswer.isNotEmpty) {
      setState(() {
        final currentQuestion = _questions[_currentQuestionIndex];
        // Evaluate the answer
        if (currentQuestion.type == 'mcq' && _selectedOption == currentQuestion.answer) {
          _score++;
        } else if (currentQuestion.type == 'fill_in' &&
            _fillInAnswer.trim().toLowerCase() == (currentQuestion.answer?.trim().toLowerCase() ?? '')) {
          _score++;
        }

        if (_currentQuestionIndex < _questions.length - 1) {
          _currentQuestionIndex++;
          _selectedOption = null; // Reset selected option for the next question
          _fillInAnswer = ''; // Reset fill-in-the-blanks answer for the next question
          _fillInController.clear(); // Clear the TextField
        } else {
          _fillInController.clear(); // Clear the TextField

          String rank = _entrylevelData.calculateRank(_score, _questions.length); // Call public method
          print(rank);
          showRankPopup(rank);
          _entrylevelData.saveResultsToDatabase(rank, _score);

          // Mark test as finished
          _isTestFinished = true;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please answer the question'),
        ),
      );
    }
  }

  void showRankPopup(String rank) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Completed'),
          content: Text('Your rank is: $rank'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _navigatetoMainPage(); // Navigate to the main page after closing
              },
            ),
          ],
        );
      },
    );
  }

  void _navigatetoMainPage() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Auditinfo()), // Main page to navigate to
      (route) => false, // Remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      // Show a loading indicator if questions are not yet fetched
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/External/Images/EntryLevel1BG.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.60,
                height: MediaQuery.of(context).size.height * 0.50,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Entry Level',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              currentQuestion.question,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            if (currentQuestion.type == 'mcq') ...[
                              ...currentQuestion.options.map<Widget>((option) {
                                return RadioListTile<String>(
                                  title: Text(option),
                                  value: option,
                                  groupValue: _selectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedOption = value;
                                    });
                                  },
                                );
                              }).toList(),
                            ] else if (currentQuestion.type == 'fill_in') ...[
                              TextField(
                                controller: _fillInController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Your answer',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _fillInAnswer = value;
                                  });
                                },
                              ),
                            ],
                            SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: _isTestFinished ? _navigatetoMainPage : _nextQuestion,
                                child: Text(_currentQuestionIndex < _questions.length - 1 ? 'Next' : 'Finish'),
                              ),
                            ),
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
}

class Question {
  final String question;
  final List<String> options;
  final String type;
  final String? answer; // Correct answer

  Question({
    required this.question,
    required this.options,
    required this.type,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      options: json['options'] != null ? List<String>.from(json['options']) : [],
      type: json['type'] ?? '',
      answer: json['answer'],
    );
  }
}
