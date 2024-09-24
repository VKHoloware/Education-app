

// // import 'dart:io';

// // import 'package:educationgame/screen/loginandregister/organisationRegister.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/gestures.dart';
// // import 'register.dart';

// // import 'loginui.dart';



// // class Register extends StatefulWidget {

// //   @override
// //   _RegisterPage createState() => _RegisterPage();
// // }

// // class _RegisterPage extends State<Register> {

// //   @override
// //   void initState(){
// //     // _selectedValue = items[0];
// //     super.initState();
// //   }

// //  final LoginRegister _loginRegister = LoginRegister();
// //   String _message = '';
// //  String? _selectedValue; // State variable to hold the selected value
// //   String? _displayValue; // State variable to display the selected value in the card
// // List <String> _organisationname=[];
 
// // void getorganisationname() async{
  
// //   try {
// //     final message = await _loginRegister.organisationName(  
      
// //     );
// //     _organisationname.add()

// //     if (message == 'User registered successfully') {
// //       // Navigate to the Login page and remove all previous routes
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(builder: (context) => Login()),
// //         (route) => false, // Remove all previous routes
// //       );
// //     }
// //   } catch (e) {
// //     setState(() {
// //       _message = 'Failed to load data';
// //     });
// // }


// // void _register() async {
// //   final String name = _usernameController.text;
// //   final String email = _emailController.text;
// //   final String password = _passwordController.text;
// //   final String registerNumber = _registerNumberController.text;

// //   try {
// //     final message = await _loginRegister.organisationName(  
      
// //     );
// //     setState(() {
// //       _message = message;
// //     });

// //     if (message == 'User registered successfully') {
// //       // Navigate to the Login page and remove all previous routes
// //       Navigator.pushAndRemoveUntil(
// //         context,
// //         MaterialPageRoute(builder: (context) => Login()),
// //         (route) => false, // Remove all previous routes
// //       );
// //     }
// //   } catch (e) {
// //     setState(() {
// //       _message = 'Failed to load data';
// //     });
// //   }
// // }




// //  final TextEditingController _usernameController = TextEditingController();
// //  final TextEditingController _registerNumberController = TextEditingController();

// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //     List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];


// //   @override
// //   Widget build(BuildContext context) {

// //   return     Scaffold(
// //       body: Stack(
// //         children: [
// //           // Background image or color
// //           Positioned.fill(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 image: DecorationImage(
// //                   image: AssetImage('assets/images/register.jpg'),
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Row(
// //             children: [
// //               // Left Side Image
// //               Padding(padding: EdgeInsets.only(left: 50.0),

// //               child:Container(
// //                 width: 400,
// //                 height: 400,
// //                 child: Image.asset(
// //                   'assets/images/notepad.png',
// //                   fit: BoxFit.fitHeight,
// //                 ),
// //               ),),
// //               Expanded(
// //                 child: Align(
// //                   alignment: Alignment.centerRight,
// //                   child: Opacity(
// //                     opacity: 0.6,
// //                     child: Padding(
// //                       padding: const EdgeInsets.only(right: 100.0),
// //                       child: Container(
// //                         width: 500,
// //                         child: Card(
// //                           elevation: 8, // This creates the drop shadow effect
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(15),
// //                           ),
// //                           color: Color.fromARGB(255, 233, 216, 216),
// //                           child: Padding(
// //                             padding: const EdgeInsets.all(16.0),
// //                             child: Column(
// //                               mainAxisSize: MainAxisSize.min,
// //                               children: <Widget>[
// //                                 Text(
// //                                   "User Register",
// //                                   style: TextStyle(fontSize: 20),
// //                                 ),

// //                                 SizedBox(height: 16),
// //                                 Row(
// //                                   children: [
// //                                     Text(
// //                                       "Organisation Name",
// //                                       style: TextStyle(fontSize: 18),
// //                                     ),
// //                                     SizedBox(width: 16),
// //                                     DropdownButton<String>(
// //                                       value: _selectedValue, // Bind the selected value to the dropdown
// //                                       hint: Text('Select an option'),
// //                                       onChanged: (String? newValue) {
// //                                         setState(() {
// //                                           _selectedValue = newValue; // Update the selected value
// //                                         });
// //                                       },
// //                                       items: items.map<DropdownMenuItem<String>>((String value) {
// //                                         return DropdownMenuItem<String>(
// //                                           value: value,
// //                                           child: Text(value),
// //                                         );
// //                                       }).toList(),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 SizedBox(height: 16),
// //                                 TextField(
// //                                   controller: _usernameController,
// //                                   decoration: const InputDecoration(
// //                                     labelText: 'Name',
// //                                     border: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Default border color
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     enabledBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         width: 1.0,
// //                                       ),
// //                                     ),
// //                                     focusedBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Border color when focused
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 16),
// //                                 TextField(
// //                                   controller: _registerNumberController,
// //                                   decoration: const InputDecoration(
// //                                     labelText: 'Register Number',
// //                                     border: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Default border color
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     enabledBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         width: 1.0,
// //                                       ),
// //                                     ),
// //                                     focusedBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Border color when focused
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 16),
// //                                 TextField(
// //                                   controller: _emailController,
// //                                   decoration: const InputDecoration(
// //                                     labelText: 'Email-Id',
// //                                     border: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Default border color
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     enabledBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         width: 1.0,
// //                                       ),
// //                                     ),
// //                                     focusedBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Border color when focused
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 16),
// //                                 TextField(
// //                                   controller: _passwordController,
// //                                   obscureText: true,
// //                                   decoration: const InputDecoration(
// //                                     labelText: 'Password',
// //                                     border: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Default border color
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                     enabledBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         width: 1.0,
// //                                       ),
// //                                     ),
// //                                     focusedBorder: OutlineInputBorder(
// //                                       borderSide: BorderSide(
// //                                         color: Colors.blue, // Border color when focused
// //                                         width: 2.0,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                                 SizedBox(height: 24),
// //                                 ElevatedButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       _displayValue = _selectedValue; // Set the value to display in the card
// //                                     });
// //                                     _register();
// //                                   },
// //                                   child: Text('Register'),
// //                                 ),
// //                                 SizedBox(height: 24),
// //                                 if (_displayValue != null) // Show the selected value if it is not null
// //                                   Card(
// //                                     elevation: 4,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(10),
// //                                     ),
// //                                     color: Colors.grey[200],
// //                                     child: Padding(
// //                                       padding: const EdgeInsets.all(16.0),
// //                                       child: Text(
// //                                         'Selected Organisation: $_displayValue',
// //                                         style: TextStyle(fontSize: 18),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 Row(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Text("Already registered? "),
// //                                     RichText(
// //                                       text: TextSpan(
// //                                         text: 'Login',
// //                                         style: const TextStyle(
// //                                             color: Colors.blue,
// //                                             fontSize: 14,
// //                                             decoration: TextDecoration.underline),
// //                                         recognizer: TapGestureRecognizer()
// //                                           ..onTap = () {
// //                                             Navigator.pushAndRemoveUntil(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (context) => Login()),
// //                                               (route) => false, // Remove all previous routes
// //                                             );
// //                                           },
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                                                 SizedBox(height: 14),

// //                                   Row(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     // Text("Register your Organ "),
// //                                     RichText(
// //                                       text: TextSpan(
// //                                         text: 'Register your Organisation',
// //                                         style: const TextStyle(
// //                                             color: Colors.blue,
// //                                             fontSize: 14,
// //                                             decoration: TextDecoration.underline),
// //                                         recognizer: TapGestureRecognizer()
// //                                           ..onTap = () {
// //                                             Navigator.pushAndRemoveUntil(
// //                                               context,
// //                                               MaterialPageRoute(
// //                                                   builder: (context) => OrganizationRegister()),
// //                                               (route) => false, // Remove all previous routes
// //                                             );
// //                                           },
// //                                       ),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // // Scaffold(
// // //       body: Stack(
// // //         children: [
// // //           // Background image or color
// // //           Positioned.fill(
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 image: DecorationImage(
// // //                   image: AssetImage('assets/images/register.jpg'),
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           // Main content with card
// // //           Align(
// // //             alignment: Alignment.centerRight,
// // //             child: Opacity(
// // //               opacity: 0.5,
// // //               child: Padding(
// // //                 padding: const EdgeInsets.only(right: 100.0),
// // //                 child: Container(
// // //                   height: 500,
// // //                   width: 500,
// // //                   child: Card(
// // //                     elevation: 8, // This creates the drop shadow effect
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(15),
// // //                     ),
// // //                     color: Color.fromARGB(255, 221, 197, 197),
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(16.0),
// // //                       child: Column(
// // //                         mainAxisSize: MainAxisSize.min,
// // //                         children: <Widget>[
// // //                           Text("User Register ",
// // // style: TextStyle(fontSize: 20),
// // // ),
// // //                           Row(
// // //                             children: [
// // //                               Text(
// // //                                 "Organisation Name",
// // //                                 style: TextStyle(fontSize: 18),
// // //                               ),
// // //                               SizedBox(width: 106),
// // //                              DropdownButton<String>(
// // //                                 value: _selectedValue, // Bind the selected value to the dropdown
// // //                                 hint: Text('Select an option'),
// // //                                 onChanged: (String? newValue) {
// // //                                   setState(() {
// // //                                     _selectedValue = newValue; // Update the selected value
// // //                                   });
// // //                                 },
// // //                                 items: items.map<DropdownMenuItem<String>>((String value) {
// // //                                   return DropdownMenuItem<String>(
// // //                                     value: value,
// // //                                     child: Text(value),
// // //                                   );
// // //                                 }).toList(),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           SizedBox(height: 16),
// // //                           TextField(
// // //                             controller: _usernameController,
// // //                             decoration: const InputDecoration(
// // //                               labelText: 'Name',
// // //                               border: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Default border color
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                               enabledBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   width: 1.0,
// // //                                 ),
// // //                               ),
// // //                               focusedBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Border color when focused
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 16),
// // //                           TextField(
// // //                             controller: _registerNumberController,
// // //                             decoration: const InputDecoration(
// // //                               labelText: 'Register Number',
// // //                               border: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Default border color
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                               enabledBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   width: 1.0,
// // //                                 ),
// // //                               ),
// // //                               focusedBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Border color when focused
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 16),
// // //                           TextField(
// // //                             controller: _emailController,
// // //                             decoration: const InputDecoration(
// // //                               labelText: 'Email-Id',
// // //                               border: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Default border color
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                               enabledBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   width: 1.0,
// // //                                 ),
// // //                               ),
// // //                               focusedBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Border color when focused
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           const SizedBox(height: 16),
// // //                           TextField(
// // //                             controller: _passwordController,
// // //                             obscureText: true,
// // //                             decoration: const InputDecoration(
// // //                               labelText: 'Password',
// // //                               border: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Default border color
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                               enabledBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   width: 1.0,
// // //                                 ),
// // //                               ),
// // //                               focusedBorder: OutlineInputBorder(
// // //                                 borderSide: BorderSide(
// // //                                   color: Colors.blue, // Border color when focused
// // //                                   width: 2.0,
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 24),
// // //                            ElevatedButton(
// // //                             onPressed: () {
// // //                               setState(() {
// // //                                 _displayValue = _selectedValue; // Set the value to display in the card
// // //                               });
// // //                               _register();
// // //                             },
// // //                             child: Text('Register'),
// // //                           ),
// // //                           SizedBox(height: 24),
// // //                           if (_displayValue != null) // Show the selected value if it is not null
// // //                             Card(
// // //                               elevation: 4,
// // //                               shape: RoundedRectangleBorder(
// // //                                 borderRadius: BorderRadius.circular(10),
// // //                               ),
// // //                               color: Colors.grey[200],
// // //                               child: Padding(
// // //                                 padding: const EdgeInsets.all(16.0),
// // //                                 child: Text(
// // //                                   'Selected Organisation: $_displayValue',
// // //                                   style: TextStyle(fontSize: 18),
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.center,
// // //                             children: [
// // //                               Text("Already registered? "),
// // //                               RichText(
// // //                                 text: TextSpan(
// // //                                   text: 'Login',
// // //                                   style: const TextStyle(
// // //                                       color: Colors.blue,
// // //                                       fontSize: 14,
// // //                                       decoration: TextDecoration.underline),
// // //                                   recognizer: TapGestureRecognizer()
// // //                                     ..onTap = () {
// // //                                       Navigator.pushAndRemoveUntil(
// // //                                         context,
// // //                                         MaterialPageRoute(
// // //                                             builder: (context) => Login()),
// // //                                         (route) => false, // Remove all previous routes
// // //                                       );
// // //                                     },
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// //   }
// // }
// import 'dart:convert';
// import 'dart:io';
// import 'package:educationgame/screen/loginandregister/loginui.dart';
// import 'package:educationgame/screen/loginandregister/register.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:educationgame/screen/loginandregister/registerui.dart';

// class Register extends StatefulWidget {
//   @override
//   _RegisterPage createState() => _RegisterPage();
// }

// class _RegisterPage extends State<Register> {
//   final LoginRegister _loginRegister = LoginRegister();
//   String _message = '';
//   String? _selectedValue; // State variable to hold the selected value
//   String? _selectedId; // State variable to hold the selected ID
//   late Future<List<Map<String, dynamic>>> _dataList; // Change this to List<Map<String, dynamic>>

//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _registerNumberController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _placeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _dataList = _loginRegister.fetchOrganisationNames(); // Fetch data when the widget is initialized
//     fetchOrganisationNames() ;
//   }
// Future<List<Map<String, dynamic>>> fetchOrganisationNames() async {
//   final String endpoint = "http://localhost:8000/organisationname"; // Update with correct IP

//   try {
//     final response = await http.get(
//       Uri.parse(endpoint),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       List<dynamic> jsonResponse = jsonDecode(response.body);
//       List<Map<String, dynamic>> organisations = jsonResponse.map((item) {
//         return {
//           'id': item['id'],
//           'name': item['name'],
//         };
//       }).toList();
//       return organisations;
//     } else {
//       print('Failed to load organisations. Status code: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       throw Exception('Failed to load organisations');
//     }
//   } catch (error) {
//     print("Error during HTTP request: $error");
//     return [];
//   }
// }



//   void _handleSelection(String? selectedName) {
//     setState(() {
//       _selectedValue = selectedName;

//       // Find the corresponding ID based on the selected name
//       _dataList.then((organisations) {
//         final selectedOrganisation = organisations.firstWhere(
//           (org) => org['name'] == selectedName,
//           orElse: () => {'id': null, 'name': null},
//         );
//         _selectedId = selectedOrganisation['id'];
//       });
//     });
//   }

//   void _register() async {
//     // Uncomment and update your registration logic
// int organisationId = int.parse(_selectedId!);
//     final String name = _usernameController.text;
//     final String email = _emailController.text;
//     final String password = _passwordController.text;
//     final String registerNumber = _registerNumberController.text;
//     final String message;
//  // Check if _selectedId is null
//   if (_selectedId == null) {
//     setState(() {
//       _message = 'Please select an organization';
//     });
//     return;
//   }

//   try {
//     // Convert _selectedId to int
//     int organisationId = int.parse(_selectedId!);

//     final message = await _loginRegister.registerData(
//       organisationId: organisationId, // Use the converted int value
//       name: name,
//       email: email,
//       password: password,
//       registerNumber: registerNumber,
//     );

//     setState(() {
//       _message = message;
//     });
//   } catch (e) {
//     setState(() {
//       _message = 'Failed to register: ${e.toString()}';
//     });
//   }


//       // if (message == 'User registered successfully') {
//       //   // Show a success dialog
//       //   showDialog(
//       //     context: context,
//       //     builder: (BuildContext context) {
//       //       return AlertDialog(
//       //         title: Text('Success'),
//       //         content: Text('User registered successfully!'),
//       //         actions: <Widget>[
//       //           TextButton(
//       //             onPressed: () {
//       //               Navigator.of(context).pop(); // Close the dialog
//       //               Navigator.pushAndRemoveUntil(
//       //                 context,
//       //                 MaterialPageRoute(builder: (context) => Login()),
//       //                 (route) => false, // Remove all previous routes
//       //               );
//       //             },
//       //             child: Text('OK'),
//       //           ),
//       //         ],
//       //       );
//       //     },
//       //   );
//       // }
//     // } catch (e) {
//     //   setState(() {
//     //     _message = 'Failed to load data';
//     //   });
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image or color
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/register.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Row(
//             children: [
//               // Left Side Image
//               Padding(
//                 padding: EdgeInsets.only(left: 50.0),
//                 child: Container(
//                   width: 400,
//                   height: 400,
//                   child: Image.asset(
//                     'assets/images/notepad.png',
//                     fit: BoxFit.fitHeight,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Opacity(
//                     opacity: 0.6,
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 100.0),
//                       child: Container(
//                         width: 500,
//                         child: Card(
//                           elevation: 8, // This creates the drop shadow effect
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           color: Color.fromARGB(255, 233, 216, 216),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: <Widget>[
//                                 Text(
//                                   "User Register",
//                                   style: TextStyle(fontSize: 20),
//                                 ),
//                                 SizedBox(height: 16),
//                                 FutureBuilder<List<Map<String, dynamic>>>(
//                                   future: _dataList,
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                       return CircularProgressIndicator();
//                                     } else if (snapshot.hasError) {
//                                       return Text('Error: ${snapshot.error}');
//                                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                                       return Text('No organisations available');
//                                     } else {
//                                       return Row(
//                                         children: [
//                                           Text(
//                                             "Organisation Name",
//                                             style: TextStyle(fontSize: 18),
//                                           ),
//                                           SizedBox(width: 16),
//                                           DropdownButton<String>(
//                                             value: _selectedValue,
//                                             hint: Text('Select an option'),
//                                             onChanged: (String? newValue) {
//                                               setState(() {
//                                                 _selectedValue = newValue;
//                                                 _handleSelection(newValue);
//                                               });
//                                             },
//                                             items: snapshot.data!.map<DropdownMenuItem<String>>((Map<String, dynamic> org) {
//                                               return DropdownMenuItem<String>(
//                                                 value: org['name'],
//                                                 child: Text(org['name']), // Display the name
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ],
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 SizedBox(height: 16),
//                                 TextField(
//                                   controller: _usernameController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Name',
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 TextField(
//                                   controller: _registerNumberController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Register Number',
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 TextField(
//                                   controller: _emailController,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Email-Id',
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 TextField(
//                                   controller: _passwordController,
//                                   obscureText: true,
//                                   decoration: const InputDecoration(
//                                     labelText: 'Password',
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: 1.0,
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Colors.blue,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 16),
//                                 // TextField(
//                                 //   controller: _phoneController,
//                                 //   decoration: const InputDecoration(
//                                 //     labelText: 'Phone Number',
//                                 //     border: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         color: Colors.blue,
//                                 //         width: 2.0,
//                                 //       ),
//                                 //     ),
//                                 //     enabledBorder: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         width: 1.0,
//                                 //       ),
//                                 //     ),
//                                 //     focusedBorder: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         color: Colors.blue,
//                                 //         width: 2.0,
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 // SizedBox(height: 16),
//                                 // TextField(
//                                 //   controller: _placeController,
//                                 //   decoration: const InputDecoration(
//                                 //     labelText: 'Place',
//                                 //     border: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         color: Colors.blue,
//                                 //         width: 2.0,
//                                 //       ),
//                                 //     ),
//                                 //     enabledBorder: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         width: 1.0,
//                                 //       ),
//                                 //     ),
//                                 //     focusedBorder: OutlineInputBorder(
//                                 //       borderSide: BorderSide(
//                                 //         color: Colors.blue,
//                                 //         width: 2.0,
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 SizedBox(height: 16),
//                                 ElevatedButton(
//                                   onPressed: _register,
//                                   child: Text('Register'),
//                                 ),
//                                 SizedBox(height: 16),
//                                 Text(_message),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
// import 'package:eduai/Screens/LoginRegister/UI/organisation.dart';
// import 'package:educationgame/screen/loginandregister/loginui.dart';
// import 'package:educationgame/screen/loginandregister/organisationRegister.dart';
// import 'package:educationgame/screen/student/mainlevel.dart';
import 'package:eduai/Screens/LoginRegister/UI/login.dart';
import 'package:eduai/Screens/LoginRegister/UI/organisation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<Register> {
  String _message = '';
  String? _selectedValue; // State variable to hold the selected value
  late int  _selectedId; // State variable to hold the selected ID
  late Future<List<Map<String, dynamic>>> _dataList;
   String _selectedProficiency = 'Beginner'; // Default selection

  // List of proficiency options
  final List<String> _proficiencyLevels = ['Beginner', 'Intermediate', 'Advanced','UnKnown'];

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nativelanguageController = TextEditingController();
  final TextEditingController _englishProficency = TextEditingController();



  @override
  void initState() {
    super.initState();
    _dataList = fetchOrganisationNames();
  }

  Future<List<Map<String, dynamic>>> fetchOrganisationNames() async {
    final String endpoint = "http://localhost:8000/organisationname";

    try {
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        List<Map<String, dynamic>> organisations = jsonResponse.map((item) {
          return {
            'id': item['id'],
            'name': item['name'],
          };
        }).toList();
        return organisations;
      } else {
        print('Failed to load organisations. Status code: ${response.statusCode}');
        throw Exception('Failed to load organisations');
      }
    } catch (error) {
      print("Error during HTTP request: $error");
      return [];
    }
  }

  void _handleSelection(String? selectedName) {
    setState(() {
      _selectedValue = selectedName;

      // Find the corresponding ID based on the selected name
      _dataList.then((organisations) {
        final selectedOrganisation = organisations.firstWhere(
          (org) => org['name'] == selectedName,
          orElse: () => {'id': null, 'name': null},
        );
        _selectedId = selectedOrganisation['id']; // Convert ID to String
      });
    });
  }

  void _register() async {
    // if (_selectedId == null) {
    //   setState(() {
    //     _message = 'Please select an organization';
    //   });
    //   return;
    // }
    print('English Proficiency: $_selectedProficiency');

    try {
      final String name = _usernameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String registerNumber = _registerNumberController.text;
      final String nativelanguage = _nativelanguageController.text;
      final String englishProficency = _selectedProficiency;


      final int organisationId = 0; // Convert to int
// print(" org:$organisationId");
      // Make registration request to your backend
      final response = await http.post(
        Uri.parse('http://localhost:8000/userRegister'),  // Update with your actual endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'registernumber': registerNumber,
          'OrganizationID':0, 
          'Nativelanguage':nativelanguage,
          'EnglishProficency':englishProficency
        }),
      );

      if (response.statusCode == 200) {

        setState(() {
          _message = 'User registered successfully';
        });
        showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User registered successfully!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false, // Remove all previous routes
                  );
                },
                child: Text('OK'),
                
              ),
              
            ],
          );
        },
      );
      setState(() {
      _message = '';
    });
      } else {
        setState(() {
          _message = 'Failed to register: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Failed to register: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/register.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Container(
                  width: 400,
                  height: 400,
                  child: Image.asset(
                    'assets/images/notepad.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Opacity(
                    opacity: 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Container(
                        width: 500,
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: Color.fromARGB(255, 233, 216, 216),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "User Register",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(height: 16),
                            
                                SizedBox(height: 16),
                                TextField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Name',
                                  ),
                                ),
                                SizedBox(height: 16),
                            
                                SizedBox(height: 16),
                                TextField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    labelText: 'Email-Id',
                                  ),
                                ),
                                SizedBox(height: 16),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                  ),
                                ),
                                  SizedBox(height: 16),
                                      DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'English Proficiency',
              ),
              value: _selectedProficiency, // Initial value
              items: _proficiencyLevels.map((String proficiency) {
                return DropdownMenuItem<String>(
                  value: proficiency,
                  child: Text(proficiency),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedProficiency = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
                                SizedBox(height: 16),
                                TextField(
                                  controller: _nativelanguageController,
                                  decoration: const InputDecoration(
                                    labelText: 'Native-Language',
                                  ),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: _register,
                                  child: Text('Register'),
                                ),
                                SizedBox(height: 16),
 Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have a account? "),
                            RichText(
                              text: TextSpan(
                                text: 'Login ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => Login()),
                                      (route) => false,
                                    );
                                  },
                              ),
                            ),
                          ],
                        ),
                                                SizedBox(height: 16),


                          Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Text("Register your Organ "),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Register your Organisation',
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            decoration: TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => OrganizationRegister()),
                                              (route) => false, // Remove all previous routes
                                            );
                                          },
                                      ),
                                    ),
                                  ],
                                ),                              ],
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
        ],
      ),
    );
  }
}
