import 'dart:io';
import 'package:eduai/Screens/Mainpage/UI/mainpage.dart';
import 'package:eduai/Screens/Teacher/UI/dashboard.dart';
import 'package:eduai/Screens/Teacher/UI/lessons.dart';
import 'package:flutter/material.dart';






import 'package:eduai/Screens/LoginRegister/UI/login.dart';

import 'Screens/EntryTest/UI/Entrylevel.dart';
import 'Screens/LoginRegister/UI/UserRegistration.dart';
import 'Screens/Teacher/UI/lessons.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.blue, 
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: Colors.blue, 
          selectedIconTheme: IconThemeData(color: Colors.white),
          unselectedIconTheme: IconThemeData(color: const Color.fromARGB(179, 0, 0, 0)),
          selectedLabelTextStyle: TextStyle(color: Colors.white),
          unselectedLabelTextStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
        ),
      ),
    //  home:Student(),
      // home: MyHomePage(),
      home: Register(),


    );
  }
} 