import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class Vocabulary {

  

        Future<Map<String, String>> fetchDataFromDB(int index) async {
          try {
            await Future.delayed(Duration(seconds: 2));

            final response = await http.get(Uri.parse('http://localhost:8000/vocabulary'));

            if (response.statusCode == 200) {
              print('Raw response: ${response.body}');

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

              return result;  
            } else {
              return {'Error': 'Failed to fetch data'};
            }
          } catch (e) {
            return {'Error': 'Error: $e'};
          }
        }









}