import 'dart:convert';

  import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AdminFunction{
   var   data=[];



  Future<List> refreshData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? createdBy = prefs.getString('email');
  print(1);

  if (createdBy != null) {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/teacherdata?createdBy=$createdBy'));

      if (response.statusCode == 200) {
        // Decode the JSON response and cast it into a List of Maps
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<Map<String, dynamic>> responsedata = jsonResponse.map((data) => data as Map<String, dynamic>).toList();

        // Optionally update a notifier or state variable here (uncomment if needed)
        // dataNotifier.value = responsedata;

        // Return the fetched data
        return responsedata;
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to refresh data: $error');
      return []; // Return an empty list on failure
    }
  } else {
    print('No email found in SharedPreferences');
    return []; // Return an empty list if no email is found
  }
}


}

// class AdminScreen
// {
//   Future<List<Map<String, dynamic>>> fetchOrganisationNames() async {
//     final String endpoint = "http://localhost:8000/organisationname"; // Update with correct IP

//     try {
//       final response = await http.get(
//         Uri.parse(endpoint),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         List<dynamic> jsonResponse = jsonDecode(response.body);
//         List<Map<String, dynamic>> organisations = jsonResponse.map((item) {
//           return {
//             'id': item['id'],
//             'name': item['name'],
//           };
//         }).toList();
//         return organisations;
//       } else {
//         throw Exception('Failed to load organisations');
//       }
//     } catch (error) {
//       print("Error during HTTP request: $error");
//       return [];
//     }
    
//   }
//   Future<List<Map<String, dynamic>>> fetchData() async {
//     final response = await http.get(
//       Uri.parse('http://localhost:8000/teacherdata'),  // Replace with your actual endpoint
//       headers: {'Content-Type': 'application/json'},
//     );
// print(222);
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       // print(response.body);
//       return List<Map<String, dynamic>>.from(data);
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }