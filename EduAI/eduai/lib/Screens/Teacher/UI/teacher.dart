

import 'dart:convert';

import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Function/teacher.dart';


class StudentList extends StatefulWidget{
  @override
  _StudentList createState()=>_StudentList();
}

class _StudentList extends State<StudentList>{
 @override
  void initState() {
    super.initState();
    _loadData();
  }
  Teacher _TeacherScreen = Teacher();


List<Map<String, dynamic>> _data = [];

Future<List<Map<String, dynamic>>> fetchData(String createdBy) async {
  final response = await http.get(
    Uri.parse('http://localhost:8000/studentdata?createdBy=$createdBy'),  // Replace with your actual endpoint
    headers: {'Content-Type': 'application/json'},
  );
print(response.body);
  if (response.statusCode == 200) {
    // Decode the response body as a List<dynamic>
    final List<dynamic> data = jsonDecode(response.body);

    // Convert List<dynamic> to List<Map<String, dynamic>>
    return data.map((item) => item as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

   void _performActionWithSelectedValue(String? selectedValue) {
    if (selectedValue != null) {
      print('Selected Role: $selectedValue');
     
    }
  }

  // This is the correct method signature for loading data
 Future<void> _loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final String? emailid = prefs.getString('email');
  if (emailid != null) {
    try {
      List<Map<String, dynamic>> data = await fetchData(emailid);
      setState(() {
        _data = data; // Update the non-final list
      });
    } catch (error) {
      print('Failed to load data: $error');
    }
  } else {
    print('Email ID is null');
  }
}

void isDelete(){
  showDialog(context: context,
  builder:(BuildContext context){return AlertDialog(title: Text("Confirmation"),content: Text("Are you want to delete"),);});
}

void Deletedata(id){

  print(id);
}



@override
Widget build(BuildContext context) {
  return Scaffold(
    body:
    
    
    //  _data.isEmpty
    //     ? SingleChildScrollView(
    //               scrollDirection: Axis.vertical,
    //               child: SingleChildScrollView(
    //                 scrollDirection: Axis.horizontal,
    //                 child: DataTable(
    //                   columns: const <DataColumn>[
    //                     DataColumn(label: Text('Information')),
    //                   ],
    //                   rows: [
    //                     DataRow(
    //                       cells: [
    //                         DataCell(Text("No Data Found")),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             )
    //     : SingleChildScrollView(
    //         scrollDirection: Axis.vertical,
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: DataTable(
    //             columns: const <DataColumn>[
    //               DataColumn(label: Text('Name')),
    //               DataColumn(label: Text('Email')),
    //               DataColumn(label: Text('RegisterNumber')),
    //               DataColumn(label: Text('Class')),
    //               DataColumn(label: Text('CreatedTime')),
    //               DataColumn(label: Text('Delete')),


    //             ],
    //             rows: _data
    //                 .map(
    //                   (data) => DataRow(
    //                     cells: <DataCell>[
    //                       // Use an empty string if the value is null
    //                       DataCell(Text(data['name'] ?? '')),
    //                       DataCell(Text(data['email'] ?? '')),
    //                       DataCell(Text(data['registernumber'] ?? '')),
    //                       DataCell(Text(data['class'] ?? '')),
    //                       DataCell(Text(data['createdtime'] ?? '')),
    //                       DataCell(ElevatedButton(child: Text("Deleted"),onPressed: () => isDelete(),)),


    //                     ],
    //                   ),
    //                 )
    //                 .toList(),
    //           ),
    //         ),
    //       ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.end, // Align text to the start (left) of the screen
    children: [
      // Add padding to move text down slightly if needed
      Padding(
        padding: const EdgeInsets.all(16.0), // Adjust the padding as per your requirement
        child: ElevatedButton(child: Icon(Icons.refresh_outlined),onPressed:()=>_loadData() ,)
        
      ),
      
      // Add a space or SizedBox to create a gap between the text and the table
      SizedBox(height: 10),

      Expanded(
        child: _data.isEmpty
            ? SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Information')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(Text("No Data Found")),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('RegisterNumber')),
                      DataColumn(label: Text('Class')),
                      DataColumn(label: Text('CreatedTime')),
                      DataColumn(label: Text('Delete')),
                    ],
                    rows: _data.map(
                      (data) => DataRow(
                        cells: <DataCell>[
                          DataCell(Text(data['name'] ?? '')),
                          DataCell(Text(data['email'] ?? '')),
                          DataCell(Text(data['registernumber'] ?? '')),
                          DataCell(Text(data['class'] ?? '')),
                          DataCell(Text(data['createdtime'] ?? '')),
                          DataCell(ElevatedButton(
                            child: Text("Deleted"),
                            onPressed: () => Deletedata(data['id']),
                          )),
                        ],
                      ),
                    ).toList(),
                  ),
                ),
              ),
      ),
    ],
  ),
  );
}
}