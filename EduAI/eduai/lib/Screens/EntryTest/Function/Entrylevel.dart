import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class EntrylevelData{


  String calculateRank(int score, int totalQuestions) {
  double percentage = (score / totalQuestions) * 100;

  if (percentage >= 90) {
    return 'Expert';
  } else if (percentage >= 70) {
    return 'Advance';
  } else if (percentage >= 50) {
    return 'Intermidiate';
  } else {
    return 'Beginner';
  }
}




Future<void> saveResultsToDatabase(String rank, int score) async {
  
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? id = prefs.getInt('id');
        await prefs.setString('level', rank);

  print(id);
  final url = 'http://localhost:8000/savelevel'; // Change this to your API URL
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'level': rank,
        'id': id,
      }),
    );

    if (response.statusCode == 200) {
      print('Score and rank saved successfully');
    } else {
      print('Failed to save score and rank');
    }
  } catch (e) {
    print('Error saving score and rank: $e');
  }
}



}

