import 'dart:convert';
import 'dart:io';
  import 'package:http/http.dart' as http;


class Teacher{


   Future<List<Map<String, dynamic>>> fetchData(String createdBy) async {
    // print("SSSSS");
    final response = await http.get(
      Uri.parse('http://localhost:8000/studentdata?createdBy=$createdBy'),  // Replace with your actual endpoint
      headers: {'Content-Type': 'application/json'},
    );
// print(225565665652);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      print(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
   void _performActionWithSelectedValue(String? selectedValue) {
    if (selectedValue != null) {
      print('Selected Role: $selectedValue');
     
    }
  }
  
  // Future<void> _refreshData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? createdBy = prefs.getString('email');

  //   if (createdBy != null) {
  //     try {
  //       final response = await http.get(Uri.parse('http://localhost:8000/teacherdata?createdBy=$createdBy'));

  //       if (response.statusCode == 200) {
  //         final List<dynamic> jsonResponse = json.decode(response.body);
  //         final List<Map<String, dynamic>> data = jsonResponse.map((data) => data as Map<String, dynamic>).toList();

  //         // Update the ValueNotifier
  //         dataNotifier.value = data;
  //       } else {
  //         throw Exception('Failed to load data');
  //       }
  //     } catch (error) {
  //       print('Failed to refresh data: $error');
  //     }
  //   }
  // }
}