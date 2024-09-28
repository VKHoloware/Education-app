


import 'dart:convert';
import 'dart:io';
import 'package:eduai/Screens/EntryTest/UI/Entrylevel.dart';
import 'package:eduai/Screens/LoginRegister/Function/login.dart';
import 'package:eduai/Screens/LoginRegister/UI/UserRegistration.dart';
import 'package:eduai/Screens/LoginRegister/UI/organisation.dart';
import 'package:eduai/Screens/Mainpage/UI/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Admin/UI/admin.dart';
import '../../Admin/UI/dashboard.dart';
import '../../Teacher/UI/dashboard.dart';





class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _passwordError;
  String? _Error;



void _login() async {
  final String password = _passwordController.text;
  final String registerNumber = _registerNumberController.text;
  LoginRegister _loginRegister = LoginRegister();

  if (password.isEmpty || registerNumber.isEmpty) {
    setState(() {
      _passwordError = 'Password cannot be empty';
      _Error = 'This Field cannot be empty';
    });
    return;
  }

  try {
    final response = await _loginRegister.loginData(
      password: password,
      registerNumber: registerNumber,
    );
    final String message = response['message']!;
    final String role = response['role']!;
          final SharedPreferences prefs = await SharedPreferences.getInstance();


String? englishProficency=await prefs.getString('englishProficency');
    print('EP:$englishProficency');

print(englishProficency);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.contains('successful') ? 'Success' : 'Error'),
          content: Text(
            message.contains('successful')
                ? message
                : 'Please enter correct details.',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();

                if (role == 'Teacher') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => TeacherDashboard()), 
                    (route) => false,
                  );
                } else if ( englishProficency == 'UnKnown') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Entrylevel()), 
                    (route) => false,
                  );
                } else if (role == 'Admin') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => AdminDashboard()), 
                    (route) => false,
                  );
                } else if (role == 'Student') {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Mainpage()), // Entry level page
                    (route) => false,
                  );
                } else if (englishProficency == 'Beginner' ||englishProficency == 'Intermediate'||englishProficency == 'Advanced')  {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Mainpage()), // Default page
                    (route) => false,
                  );
                }
                
              },
            ),
          ],
        );
      },
    );
  } catch (error) {
    print("Error during login: $error");
  }




}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/External/Images/login.jpg'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Center(
            child: Opacity(
              opacity: 0.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(180.0, 0, 0, 0), // Add left padding
                child: Container(
                  width: 400,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            "Login ",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _registerNumberController,
                            decoration: InputDecoration(
                              labelText: 'Register Number',
                              border: OutlineInputBorder(),
                              errorText: _Error
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Note: ',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text("If you are an Admin, Enter the Email ID"),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(),
                              errorText: _passwordError, // Display error if any
                            ),
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _login,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(Colors.blue), // Button color
                              foregroundColor: WidgetStateProperty.all(Colors.white), // Text color
                              padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)), // Button padding
                              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              )),
                              elevation: WidgetStateProperty.all(8), // Shadow elevation
                              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return const Color.fromARGB(255, 1, 14, 36).withOpacity(0.5); // Hover color
                                  }
                                  if (states.contains(WidgetState.pressed)) {
                                    return Colors.blueAccent.withOpacity(0.7); // Pressed color
                                  }
                                  return null; // Defer to the default color
                                },
                              ),
                            ),
                            child: Text('Login'),
                          ),
                          SizedBox(height: 16),

                              Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Did not have a account Register Here',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => Register()),
                                        (route) => false, // Remove all previous routes
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
                              RichText(
                                text: TextSpan(
                                  text: 'Register your Organisation',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => OrganizationRegister()),
                                        (route) => false, // Remove all previous routes
                                      );
                                    },
                                ),
                              ),
                            ],
                          ),
                        ],
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





//   // void _login() async {
//      void _login() async {
//     final String password = _passwordController.text;
//     final String registerNumber = _registerNumberController.text;
//     LoginRegister _loginRegister = LoginRegister();

//     // Check if the password and register number fields are empty
//     if (password.isEmpty || registerNumber.isEmpty) {
//       setState(() {
//         _passwordError = password.isEmpty ? 'Password cannot be empty' : null;
//         _Error = registerNumber.isEmpty ? 'This field cannot be empty' : null;
//       });
//       return; // Exit the function if fields are empty
//     }

//     try {
//       final message = await _loginRegister.loginData(
//         password: password,
//         registerNumber: registerNumber,
//       );
// final String englishProficency = responseBody['englishProficency']?.toString() ?? 'Unknown';

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('loginMessage', message);
//       print("LoginData: $message");

//      showDialog(
//   context: context,
//   builder: (BuildContext context) {
//     return AlertDialog(
//       title: Text(message.contains('successful') ? 'Success' : 'Error'),
//       content: Text(message.contains('successful') ? message : 'Enter the correct details'),
//       actions: <Widget>[
//         TextButton(
//           child: const Text('OK'),
//           onPressed: () async {
//             Navigator.of(context).pop(); // Close the dialog

//             // Check English proficiency for navigation
//             if (message.contains('successful')) {
//               if (message.contains('Student Login successful')) {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to EntryLevel for Students
//                   (route) => false,
//                 );
//               } else if (message.contains('Teacher Login successful')) {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => TeacherDashboard()), // Navigate to Teacher Dashboard
//                   (route) => false,
//                 );
//               } else if (message.contains('Individual Login successful')) {
//                 // Use the retrieved English proficiency for navigation
//                 if (englishProficency == 'Unknown') {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to Entrylevel
//                     (route) => false,
//                   );
//                 } else {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => Auditinfo()), // Navigate to Auditinfo for known proficiency
//                     (route) => false,
//                   );
//                 }
//               }
//             }
//           },
//         ),
//       ],
//     );
//   },
// );
//     } catch (error) {
//       print("Login error: $error");
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: const Text('An error occurred while logging in. Please try again.'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
    //  }
//     void _login() async {
//   final String password = _passwordController.text;
//   final String registerNumber = _registerNumberController.text;
//   LoginRegister _loginRegister = LoginRegister();

//   if (password.isEmpty || registerNumber.isEmpty) {
//     setState(() {
//       _passwordError = 'Password cannot be empty';
//       _Error = 'This Field cannot be empty';
//     });
//     return;
//   }

//   try {
//     final message = await _loginRegister.loginData(
//       password: password,
//       registerNumber: registerNumber,
//     );
// print(message);
//     final prefs = await SharedPreferences.getInstance();
//     var englishProficency = await prefs.getString('englishProficency') ?? 'Unknown';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message.contains('successful') ? 'Success' : 'Error'),
//           content: Text(message.contains('successful') ? message : 'Enter the correct details'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Check navigation based on proficiency
//                 if (message.contains(' Login - Unknown proficiency')) {
//                   // if (englishProficency == 'Unknown') {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to Entrylevel
//                       (route) => false,
//                     );
//                   } 
//                   else if (message.contains(' User Login successful'))  {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Auditinfo()), // Navigate to Auditinfo
//                       (route) => false,
//                     );
//                   }
//                 }
//               // },
//             ),
//           ],
//         );
//       },
//     );
//   } catch (error) {
//     print("Error during login: $error");
//   }
// // }
// void _login() async {
//   final String password = _passwordController.text;
//   final String registerNumber = _registerNumberController.text;
//   LoginRegister _loginRegister = LoginRegister();

//   if (password.isEmpty || registerNumber.isEmpty) {
//     setState(() {
//       _passwordError = 'Password cannot be empty';
//       _Error = 'This Field cannot be empty';
//     });
//     return;
//   }

//   try {
//     final message = await _loginRegister.loginData(
//       password: password,
//       registerNumber: registerNumber,
//     );

//     final prefs = await SharedPreferences.getInstance();
//     var englishProficency = prefs.getString('englishProficency') ?? 'Unknown';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text((message.contains('Login') || message.contains('successful')) ? 'Success' : 'Error'),
//           content: Text(
//             message.contains('successful')
//                 ? 'User Login Successfull'
//                 : message.contains('Error')
//                     ? message
//                     : 'Enter the correct details',
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Check navigation based on proficiency and login status
//                 if (message.contains('Login - Unknown proficiency')) {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to Entrylevel
//                     (route) => false,
//                   );
//                 } else if (message.contains('User Login successful')) {
//                   if (englishProficency == 'Advanced') {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Register()), // Navigate to advanced page
//                       (route) => false,
//                     );
//                   } else {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Auditinfo()), // Navigate to Auditinfo
//                       (route) => false,
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } catch (error) {
//     print("Error during login: $error");
//   }
// }


//   void _login() async {
//   final String password = _passwordController.text;
//   final String registerNumber = _registerNumberController.text;
//   LoginRegister _loginRegister = LoginRegister();

//   if (password.isEmpty || registerNumber.isEmpty) {
//     setState(() {
//       _passwordError = 'Password cannot be empty';
//       _Error = 'This Field cannot be empty';
//     });
//     return;
//   }

//   try {
//     final message = await _loginRegister.loginData(
//       password: password,
//       registerNumber: registerNumber,
//     );
    
//     final prefs = await SharedPreferences.getInstance();
//     var englishProficency = prefs.getString('englishProficency') ?? 'Unknown';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message.contains('successful') ? 'Success' : 'Error'),
//           content: Text(message.contains('successful') ? message : 'Enter the correct details'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Check navigation based on proficiency
//                 if (message.contains('Login - Unknown proficiency')) {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to Entrylevel
//                     (route) => false,
//                   );
//                 } else if (message.contains('User Login successful')) {
//                   if (englishProficency == 'Advanced') {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Register()), // Navigate to advanced page
//                       (route) => false,
//                     );
//                   } else {
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       MaterialPageRoute(builder: (context) => Auditinfo()), // Navigate to Auditinfo
//                       (route) => false,
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } catch (error) {
//     print("Error during login: $error");
//   }
// }



//     final String password = _passwordController.text;
//     final String registerNumber = _registerNumberController.text;
// LoginRegister _loginRegister=LoginRegister();
//     // Check if the password field is empty
//     if (password.isEmpty&& registerNumber.isEmpty) {
//       setState(() {
//         _passwordError = 'Password cannot be empty';
//         _Error = 'This Field cannot be empty';

//       });
//       return; // Exit the function if the password is empty
//     }

//     try {
//       final message = await _loginRegister.loginData(
//         password: password,
//         registerNumber: registerNumber,
//       );
//           final prefs = await SharedPreferences.getInstance();
// // var userdata=message

// var logindata=await prefs.setString('loginMessage', message);
// print("LoginData$logindata");
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text(message.contains('successful') ? 'Success' : 'Error'),
//             content: Text(message.contains('successful') ? message : 'Enter the Correct Details'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Close the dialog
//                  if (message.contains('successful')) {
//   if (message.contains('Student Login successful')) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Entrylevel()), // Navigate to EntryLevel for Students
//       (route) => false, // Remove all previous routes
//     );
//   } else if (message.contains('Teacher Login successful')) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => TeacherDashboard()), // Navigate to Teacher Dashboard
//       (route) => false, // Remove all previous routes
//     );
//   } else if (message.contains('Individual Login successful')) {
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => Entrylevel()), 
//       (route) => false, // Remove all previous routes
//     );
//   }
// }

//                 },
//               ),
//             ],
//           );
//         },
//       );

//       setState(() {
//         _passwordError = null;
//         _Error =null ;

//       });
//     } catch (e) {
//       setState(() {
//         _passwordError = 'Failed to load data';
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Error'),
//             content: Text('Failed to load data'),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('OK'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
  // }  

//   final String password = _passwordController.text;
//   final String registerNumber = _registerNumberController.text;
//   LoginRegister _loginRegister = LoginRegister();

//   if (password.isEmpty || registerNumber.isEmpty) {
//     setState(() {
//       _passwordError = 'Password cannot be empty';
//       _Error = 'This Field cannot be empty';
//     });
//     return;
//   }

//   try {
//     final message = await _loginRegister.loginData(
//       password: password,
//       registerNumber: registerNumber,
//     );

//     final prefs = await SharedPreferences.getInstance();
//     var englishProficiency = prefs.getString('englishProficency') ?? 'Unknown';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message.contains('successful') ? 'Success' : 'Error'),
//           content: Text(
//             message.contains('Login - Unknown proficiency')
//                 ? 'Your English proficiency is unknown. You will be directed to the Entry level.'
//                 : message.contains('successful')
//                     ? message
//                     : 'Please enter correct details.',
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();

//                 // Navigate based on proficiency
//                 if (message.contains('User Login successful')) {
                  // if (englishProficiency == 'UnKnown') {
                  //   Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Entrylevel()), // Entry level page
                  //     (route) => false,
                  //   );
                  // } else {
                  //   Navigator.pushAndRemoveUntil(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => Mainpage()), // Audit page
                  //     (route) => false,
                  //   );
                  // }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } catch (error) {
//     print("Error during login: $error");
//   }