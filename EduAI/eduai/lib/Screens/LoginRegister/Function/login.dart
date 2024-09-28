
  import 'dart:convert';
  import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  class LoginRegister {
      static const  url = "http://localhost:8000";                //url

Future<Map<String, String>> loginData({
  required String password,
  required String registerNumber,
}) async {
  final String endpoint = "$url/login"; // Update with correct endpoint

  try {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'password': password,
        'registerNumber': registerNumber,
      }),
    );

    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      print(responseBody);

      // Extract role
      // final String role = responseBody['role']?.toString() ?? '';
    final String adminName = responseBody['adminName']?.toString() ?? '';
          final String userClass = responseBody['class']?.toString() ?? '';
          final String email = responseBody['email']?.toString() ?? '';
          final int id = int.tryParse(responseBody['id']?.toString() ?? '0') ?? 0;
          final String name = responseBody['name']?.toString() ?? '';
          final int organizationID = int.tryParse(responseBody['organizationID']?.toString() ?? '0') ?? 0;
          final String regNumber = responseBody['registerNumber']?.toString() ?? '';
          final String role = responseBody['role']?.toString() ?? '';
          final String englishProficency = responseBody['englishProficency']?.toString() ?? 'Unknown';

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('adminName', adminName);
          await prefs.setString('class', userClass);
          await prefs.setString('email', email);
          await prefs.setInt('id', id);
          await prefs.setString('name', name);
          await prefs.setInt('organizationID', organizationID);
          await prefs.setString('registerNumber', regNumber);
          await prefs.setString('role', role);
          await prefs.setString('englishProficency', englishProficency); // Store proficiency as well

print('EP:$englishProficency');
      if (role == 'Teacher') {
        return {'message': 'Teacher Login successful', 'role': role};
      } else if (role == 'Student') {
        return {'message': 'Student Login successful', 'role': role};
      } else if (responseBody['organizationID'] == 0) {
        return {'message': 'User Login successful', 'role': 'Individual'};
      } else {
        return {'message': 'User Login successful', 'role': 'Admin'};
      }
    } else {
      return {'message': 'Failed to login: ${response.body}', 'role': ''};
    }
  } catch (error) {
    print("Error during HTTP request: $error");
    return {'message': 'Failed to load data', 'role': ''};
  }
}


 Future<String> organisationRegister({
    required String organisationname,
    required String name,
    required String email,
    required String place,
    required String phonenumber,
    required String password,

  }) async {
    final String endpoint = "$url/organisationregister";  // Update with correct IP


    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'place': place,
          'phonenumber': phonenumber,
          'organisationname':organisationname,
        'password': password,

        }),
      );
      
      
      if (response.statusCode == 200) {
        return 'Organization registered successfully';
      } else {
        return 'Failed to register Organization';
      }
    } catch (error) {
      print("Error during HTTP request: $error");
      return 'Failed to load data';
    }
  }
  
}


  