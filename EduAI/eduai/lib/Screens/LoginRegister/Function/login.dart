
  import 'dart:convert';
  import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  class LoginRegister {
      static const  url = "http://localhost:8000";  




// Future<String> loginData({
//   required String password,
//   required String registerNumber,
// }) async {
//   final String endpoint = "http://localhost:8000/login"; // Update with correct IP

//   try {
//     final response = await http.post(
//       Uri.parse(endpoint),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'password': password,
//         'registerNumber': registerNumber,
//       }),
//     );

//     print(response.body);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseBody = json.decode(response.body);

//       print(responseBody);

//       // Check if the response contains expected fields
//       if (responseBody.isNotEmpty) {
//         final String adminName = responseBody['adminName']?.toString() ?? '';
//         final String userClass = responseBody['class']?.toString() ?? '';
//         final String email = responseBody['email']?.toString() ?? '';
//         final int id = int.tryParse(responseBody['id']?.toString() ?? '0') ?? 0;
//         final String name = responseBody['name']?.toString() ?? '';
//         final int organizationID = int.tryParse(responseBody['organizationID']?.toString() ?? '0') ?? 0;
//         final String regNumber = responseBody['registerNumber']?.toString() ?? '';
//         final String role = responseBody['role']?.toString() ?? '';

//         // Store the data in SharedPreferences
//         final SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('adminName', adminName);
//         await prefs.setString('class', userClass);
//         await prefs.setString('email', email);
//         await prefs.setInt('id', id);
//         await prefs.setString('name', name);
//         await prefs.setInt('organizationID', organizationID);
//         await prefs.setString('registerNumber', regNumber);
//         await prefs.setString('role', role);

//         // Retrieve stored values for verification
//         print('Admin Name: $adminName');
//         print('Class: $userClass');
//         print('Email: $email');
//         print('ID: $id');
//         print('Name: $name');
//         print('Organization ID: $organizationID');
//         print('Register Number: $regNumber');
//         print('Role: $role');

//         // Handle login based on user role
//             if (role == 'Teacher') {
//   return 'Teacher Login successful';
// } else if (role == 'Student') {
//   return 'Student Login successful';
// } else if (organizationID == 0) {
//   return 'Individual Login successful'; // Individual Login
// } else {
//   return 'User Login successful';
// }
   

//       } else {
//         return 'No data found in the response';
//       }
//     } else {
//       return 'Failed to login: ${response.body}';
//     }
//   } catch (error) {
//     print("Error during HTTP request: $error");
//     return 'Failed to load data';
//   }
// }

Future<String> loginData({
  required String password,
  required String registerNumber,
}) async {
  final String endpoint = "http://localhost:8000/login"; // Update with correct IP

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

      // Check if the response contains expected fields
      if (responseBody.isNotEmpty) {
        final String adminName = responseBody['adminName']?.toString() ?? '';
        final String userClass = responseBody['class']?.toString() ?? '';
        final String email = responseBody['email']?.toString() ?? '';
        final int id = int.tryParse(responseBody['id']?.toString() ?? '0') ?? 0;
        final String name = responseBody['name']?.toString() ?? '';
        final int organizationID = int.tryParse(responseBody['organizationID']?.toString() ?? '0') ?? 0;
        final String regNumber = responseBody['registerNumber']?.toString() ?? '';
        final String role = responseBody['role']?.toString() ?? '';
        final String englishProficency = responseBody['englishProficency']?.toString() ?? 'Unknown';

        // Store the data in SharedPreferences
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

        // Handle login based on user role
        if (role == 'Teacher') {
          return 'Teacher Login successful';
        } else if (role == 'Student') {
          return 'Student Login successful';
        } else if (organizationID == 0) {
          return englishProficency == 'UnKnown' 
              ? ' Login - Unknown proficiency' 
              : 'User Login successful'; // Individual Login
        } else {
          return englishProficency == 'UnKnown' 
              ? ' Login - Unknown proficiency' 
              : 'User Login successful';
        }

      } else {
        return 'No data found in the response';
      }
    } else {
      return 'Failed to login: ${response.body}';
    }
  } catch (error) {
    print("Error during HTTP request: $error");
    return 'Failed to load data';
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
    final String endpoint = "http://localhost:8000/organisationregister";  // Update with correct IP


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
      
      // print(response.body);
      
      if (response.statusCode == 200) {
        // print('Organization registered successfully ${response.body}');
        return 'Organization registered successfully';
      } else {
        // print('Failed to register Organization: ${response.body}');
        return 'Failed to register Organization';
      }
    } catch (error) {
      print("Error during HTTP request: $error");
      return 'Failed to load data';
    }
  }
  
}


  