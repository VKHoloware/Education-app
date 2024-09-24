

import 'dart:io';

import 'package:eduai/Screens/LoginRegister/UI/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../Function/login.dart';




class OrganizationRegister extends StatefulWidget {

  @override
  _OrganizationRegisterPage createState() => _OrganizationRegisterPage();
}

class _OrganizationRegisterPage extends State<OrganizationRegister> {

  @override
  void initState(){
    super.initState();
  }

 final LoginRegister _loginRegister = LoginRegister();
  String _message = '';


void _organisationregister() async {
  final String organisationname = _organisationnameController.text;
  final String name = _usernameController.text;
  final String email = _emailController.text;
  final String phonenumber = _phoneController.text;
  final String place = _placeController.text;
  final String password = _passwordController.text;


  try {
    final message = await _loginRegister.organisationRegister(
      organisationname: organisationname,
      name: name,
      email: email,
      place: place,
      phonenumber: phonenumber,
      password:password,
    );
    setState(() {
      _message = message;
    });

    if (message == 'Organization registered successfully') {
      // Show a success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Organization registered successfully!'),
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
    }
    else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Enter the Correct Detailes!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => OrganizationRegister()),
                    (route) => false, // Remove all previous routes
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (e) {
    setState(() {
      _message = 'Failed to load data';
    });
  }
}



 final TextEditingController _organisationnameController = TextEditingController();

 final TextEditingController _usernameController = TextEditingController();
 final TextEditingController _placeController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
    List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];


  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
    return 
    Scaffold(
      body:
       Stack(
        children: [
          // Background image or color
          Positioned.fill(
            child:
              Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('lib/External/Images/organisationregister.jpg'),
                fit: BoxFit.cover,
                )
                // gradient: LinearGradient(
                //   // colors: [Colors.blue, Colors.white], // Define your gradient colors here
                //   // begin: Alignment.bottomLeft,
                //   // end: Alignment.bottomRight,
                // ),
              ),
            ),
          ),
                                                 SizedBox(width: 1006),

          // Main content with card
          Center(
            child: Padding(
padding: const EdgeInsets.only(left: 12.0),              child: Opacity(  

opacity: 0.6,
              child:Container(
                
                height: screenHeight*0.6,
                width: screenWidth*0.25,
                child: Card(
                  elevation: 8, // This creates the drop shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // ClipRRect(
                        //   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        //   child: Image.network(
                        //     'https://via.placeholder.com/400x200',
                        //     fit: BoxFit.cover,
                        //     width: double.infinity,
                        //     height: 200,
                        //   ),
                        // ),
Text("Organisation Register ",
style: TextStyle(fontSize: 25),
),
                        SizedBox(height: 25),

                        TextField(
                          controller:_organisationnameController ,
                          decoration: const InputDecoration(
                            labelText: 'Organisation  Name ',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Default border color
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                // color: Colors.green, // Border color when not focused
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:  Colors.blue, // Border color when focused
                                width: 2.0,
                              ),
                            ),
                            
                          ),
                          
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller:_usernameController ,
                          decoration: const InputDecoration(
                            labelText: 'Admin Name ',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Default border color
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                // color: Colors.green, // Border color when not focused
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:  Colors.blue, // Border color when focused
                                width: 2.0,
                              ),
                            ),
                            
                          ),
                          
                        ),
                        // TextField(
                        //   controller:_placeController,
                        //   decoration: const InputDecoration(
                        //     labelText: 'Place ',
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color: Colors.blue, // Default border color
                        //         width: 2.0,
                        //       ),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         // color: Colors.green, // Border color when not focused
                        //         width: 1.0,
                        //       ),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(
                        //         color:  Colors.blue, // Border color when focused
                        //         width: 2.0,
                        //       ),
                        //     ),
                            
                        //   ),
                          
                        // ),

                        SizedBox(height: 20),
                        TextField(
                          controller:_emailController ,
                          decoration: const InputDecoration(
                            labelText: 'Email-Id',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Default border color
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                // color: Colors.green, // Border color when not focused
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:  Colors.blue, // Border color when focused
                                width: 2.0,
                              ),
                            ),
                            
                          ),
                          
                        ),
                        
                        SizedBox(height: 20),

                            TextField(
                              
                                  controller: _passwordController,
                                  obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue, // Default border color
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                // color: Colors.green, // Border color when not focused
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:  Colors.blue, // Border color when focused
                                width: 2.0,
                              ),
                            ),
                            
                          ),
                          
                        ),
                        
                        SizedBox(height: 20),

                  
                       
                        // SizedBox(height: 24),
                         ElevatedButton(
                          onPressed: _organisationregister,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 0, 110, 199)), // Button color
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
                          child: Text('Register'),
                        ),

                                                SizedBox(height: 20),

                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Go to Login',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(builder: (context) => Login()),
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


