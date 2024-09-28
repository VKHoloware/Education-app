
import 'dart:convert';
import 'dart:io';
import 'package:eduai/Screens/Teacher/UI/lessons.dart';
import 'package:eduai/Screens/Teacher/UI/teacher.dart';
// import 'package:educationgame/screen/Teacher/Function/teacher.dart';
// import 'package:educationgame/screen/Teacher/UI/learnlesson.dart';
// import 'package:educationgame/screen/Teacher/UI/studentlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;

import '../../LoginRegister/UI/login.dart';

// import '../../loginandregister/loginui.dart';


class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final List<DashboardItem> dashboardItems = [
    DashboardItem(title: 'StudentList', icon: Icons.cast_for_education, page: StudentList()),
    DashboardItem(title: 'Lesson', icon: Icons.edit_outlined, page: SynonymsLesson()),

  ];
  String? registerNumber;
       String?      organizationName;
       String?      classname;

  int? organizationID;
String? _selectedValue;  
  // final List<String> _roles = ['Student'];
  String _message='';


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _registerNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

void _updateTextFieldValue(String newValue) {
    setState(() {
      _classController.text = newValue;
    });
  }


  @override
  void initState() {
    super.initState();
    _retrieveLoginData();
  }

  Widget _currentPage = StudentList();
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  void _onDrawerItemTapped(int index) {
    setState(() {
      _currentPage = dashboardItems[index].page;
      _selectedIndex = index;
    });
  }
 

bool _isEmailFieldEmpty = false;
  bool _isnameFieldEmpty = false;
  bool _isRegisterNumberFieldEmpty = false;
  bool _isPasswordEmpty = false;
  String? _Error;

 

Future<void> _retrieveLoginData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    registerNumber = prefs.getString('registerNumber');
    organizationID = prefs.getInt('organizationID');
    classname = prefs.getString('class');
  });

  print(classname);

  // Ensure organizationID is not null before calling fetchOrganisationDetails
  if (organizationID != null) {
    fetchOrganisationDetails(organizationID!); // Use the non-null assertion operator
  } else {
    print("OrganizationID is null.");
  }
}
 
  final List<String> _roles = ['Teacher'];
  // String _message = '';
  String _usernameError = '';
  String _registerNumberError = '';
  String _emailError = '';
  String _passwordError = '';
  String _classError = '';

  


  

 
  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   children: [
              //     Text(
              //       "Role",
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     SizedBox(width: 16),
                  // DropdownButton<String>(
                  //   value: _selectedValue,
                  //   hint: Text('Select an option'),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       _selectedValue = newValue;
                  //     });
                  //   },
                  //   items: _roles.map<DropdownMenuItem<String>>((String role) {
                  //     return DropdownMenuItem<String>(
                  //       value: role,
                  //       child: Text(role),
                  //     );
                  //   }).toList(),
                  // ),
              //   ],
              // ),
              // SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  errorText: _usernameError.isNotEmpty ? _usernameError : null,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _registerNumberController,
                decoration: InputDecoration(
                  labelText: 'Register Number',
                  errorText: _registerNumberError.isNotEmpty ? _registerNumberError : null,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email-Id',
                  errorText: _emailError.isNotEmpty ? _emailError : null,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordError.isNotEmpty ? _passwordError : null,
                ),
              ),
              SizedBox(height: 16),
              // TextField(
              //   controller: _classController,
              //   decoration: InputDecoration(
              //     labelText: 'Class',
              //     errorText: _classError.isNotEmpty ? _classError : null,
              //   ),
              // ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_validateAndSubmit()) {
                    // Close the dialog only if validation passes
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _validateAndSubmit() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty ? 'Name cannot be empty' : '';
      _registerNumberError = _registerNumberController.text.isEmpty ? 'Register Number cannot be empty' : '';
      _emailError = _emailController.text.isEmpty ? 'Email cannot be empty' : '';
      _passwordError = _passwordController.text.isEmpty ? 'Password cannot be empty' : '';
      _classError = _classController.text.isEmpty ? 'Class cannot be empty' : '';
    });

    if (_usernameError.isEmpty &&
        _registerNumberError.isEmpty &&
        _emailError.isEmpty &&
        _passwordError.isEmpty 
        ) {
      printdata();
      return true; // Validation passes
    } else {
      // Show an error message if validation fails
      _showValidationErrorMessage();
      return false; // Validation fails
    }
  }

  void _showValidationErrorMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Validation Error'),
          content: Text('Please fill out all fields.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> printdata() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final int? storedOrganizationId = prefs.getInt('organizationID');
      final int? userId = prefs.getInt('ID');
      final String? adminid = prefs.getString('email');

      if (storedOrganizationId == null) {
        setState(() {
          _message = 'Failed to register: Organization ID is missing.';
        });
        return;
      }
      final String? classLevel = classname;

      final String name = _usernameController.text;
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String registerNumber = _registerNumberController.text;
      final String? classlevel = classLevel;
      final String role = _selectedValue ?? '';

      final int organisationId = storedOrganizationId;
      final int loginId = userId ?? 0;

      final response = await http.post(
        Uri.parse('http://localhost:8000/userRegister'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'registernumber': registerNumber,
          'OrganizationID': organisationId,
          'role': "Student",
          'EnglishProficency': 'UnKnown',
          'createdby': adminid,
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
                    setState(() {
                      _usernameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _registerNumberController.clear();
                      _classController.clear();
                      _selectedValue = null;
                      _message = '';
                    });
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
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
    print("Response: $_message");
  }

 



  void _performActionWithSelectedValue(String? selectedValue) {
    if (selectedValue != null) {
      print('Selected Role: $selectedValue');
     
    }
  }
 Future<void> fetchOrganisationDetails(int id) async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/organisationDetails?id=$id'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Fetched Data: $data");
    print(data['name']);
     final String name = data['name'] ?? '';
     setState(() {
       organizationName=name;
     });
     print(organizationName);
  } else {
    print("Failed to fetch data: ${response.body}");
     setState(() {
       organizationName="School";
     });
  }
}

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            title: Row(
              children: [
                Text(organizationName.toString()),
                Spacer(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text('Data 1'),
                    // Text('Data 2'),
                  ],
                ),
                IconButton(
                      onPressed: () {
_showPopup();                      },
                      icon:Tooltip(
        message: "Add Student", // Hover text
        child: Icon(Icons.add),
      ),
                    ),
                   IconButton(
      onPressed: () async {
        // Clear SharedPreferences data
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (route) => false, 
                  );
      },
      icon: Tooltip(
        message: "Logout", // Hover text
        child: Icon(Icons.account_circle_outlined),
      ),
    )
              ],
            ),
          ),
        ),
      ),
      drawer: !isWideScreen
          ? Drawer(
              child: Container(
                width: 215,
                color: Colors.blue,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                            ),
                            child: Text(
                               "Menu",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          for (var i = 0; i < dashboardItems.length; i++)
                            GestureDetector(
                              onTap: () => _onDrawerItemTapped(i),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                leading: Icon(
                                  dashboardItems[i].icon,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _selectedIndex == i ? Color.fromRGBO(255, 255, 255, 0.83) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedIndex == i ? Colors.blue : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    dashboardItems[i].title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: _selectedIndex == i ? Colors.blue : Colors.white,
                                    ),
                                  ),
                                ),
                                onTap: () => _onDrawerItemTapped(i),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Version 1.0',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: Row(
        children: [
          if (isWideScreen)
            Container(
              width: 220,
              color: Colors.blue,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        for (var i = 0; i < dashboardItems.length; i++)
                          GestureDetector(
                            onTap: () => _onDrawerItemTapped(i),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              leading: Icon(
                                dashboardItems[i].icon,
                                color: Colors.white,
                              ),
                              title: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _selectedIndex == i ? Color.fromRGBO(255, 255, 255, 0.83) : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _selectedIndex == i ? Colors.blue : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  dashboardItems[i].title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: _selectedIndex == i ? Colors.blue : Colors.white,
                                  ),
                                ),
                              ),
                              onTap: () => _onDrawerItemTapped(i),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                ],
              ),
            ),
          Expanded(
            child: PageStorage(
              bucket: _bucket,
              child: IndexedStack(
                index: _selectedIndex,
                children: dashboardItems.map((item) => item.page).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}

class DashboardItem {
  final String title;
  final IconData icon;
  final Widget page;

  DashboardItem({required this.title, required this.icon, required this.page});
}














// void printdata() async {
//   print(22);
//         print(5);

//   try {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final int? storedOrganizationId = prefs.getInt('organizationID');
//     final int? userId = prefs.getInt('ID');  
//     final String? teachername = prefs.getString('name');
//     final String? classlevel1 = prefs.getString('class');

// print(classlevel1);
//         print(598);


//     if (storedOrganizationId == null) {
//       setState(() {
//         _message = 'Failed to register: Organization ID is missing.';
//       });
//       return;  
//     }

//     final String name = _usernameController.text;
//     final String email = _emailController.text;
//     final String password = _passwordController.text;
//     final String registerNumber = _registerNumberController.text;
//     final String classlevel = _classController.text;
//     final String role = _selectedValue ?? '';  // Handle null for role

//     // Assign the fetched organization ID
//     final int organisationId = storedOrganizationId;
// final int loginId = userId ?? 0;

//     print("Organization ID: $organisationId");
//     print("Register Number: $registerNumber");

//     // Make the registration request to your backend
//     final response = await http.post(
//       Uri.parse('http://localhost:8000/userRegister'),  // Update with your actual endpoint
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'name': name,
//         'email': email,
//         'password': password,
//         'registernumber': registerNumber,
//         'OrganizationID': organisationId,  // Send the organization ID
//         'role': role,
//         'class': classlevel,
//         'createdby':loginId,
        
//       }),
//     );
// //     final response = await http.post(
// //   Uri.parse('http://localhost:8000/userRegister'),  // Ensure the correct endpoint
// //   headers: {'Content-Type': 'application/json'},
// //   body: jsonEncode({
// //     'name': name,                 // User's name
// //     'email': email,               // User's email
// //     'password': password,         // User's password
// //     'registernumber': registerNumber,  // Register number
// //     'OrganizationID': organisationId,  // Organization ID
// //     'role': role,                 // Role (e.g., "student", "teacher")
// //     'class': classlevel,          // Class level
// //     'createdby': loginId,         // Admin who created the account (login ID)
// //   }),
// // );

// print(response);
//     if (response.statusCode == 200) {
//       setState(() {
//         _message = 'User registered successfully';
//       });

//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('User registered successfully!'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();  // Close the dialog
//                   setState(() {
//                     _usernameController.clear();
//                     _emailController.clear();
//                     _passwordController.clear();
//                     _registerNumberController.clear();
//                     _classController.clear();
//                     _selectedValue = null;  // Reset dropdown
//                     _message = '';  // Clear message
//                   });
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       setState(() {
//         _message = 'Failed to register: ${response.body}';
//       });
//     }
//   } catch (e) {
//     setState(() {
//       _message = 'Failed to register: $e';
//     });
//   }
//   print("Response: $_message");
// }