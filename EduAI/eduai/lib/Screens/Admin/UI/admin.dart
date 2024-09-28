

// // import 'dart:convert';

// // import 'package:educationgame/screen/Admin/Function/organisation.dart';
// // import 'package:flutter/material.dart';
// //   import 'package:http/http.dart' as http;


// // class Admin extends StatefulWidget{
// //   @override
// //   _AdminPage createState()=>_AdminPage();
// // }

// // class _AdminPage extends State<Admin>{
// //  @override
// //   void initState() {
// //     super.initState();
// //     _loadData();
// //   }
// //   AdminScreen _adminScreen = AdminScreen();

// //   List<Map<String, dynamic>> _data = [];

// //   // This is the correct method signature for loading data
// //   Future<void> _loadData() async {
// //     try {
// //       List<Map<String, dynamic>> data = await _adminScreen.fetchData();
// //       setState(() {
// //         _data = data;
// //       });
// //       print(data);
// //     } catch (error) {
// //       print('Failed to load data: $error');
// //     }
// //   }


// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     body: _data.isEmpty
// //         ? Center(child: CircularProgressIndicator())
// //         : SingleChildScrollView(
// //             scrollDirection: Axis.vertical,
// //             child: SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: DataTable(
// //                 columns: const <DataColumn>[
// //                   DataColumn(label: Text('Name')),
// //                   DataColumn(label: Text('Email')),
// //                   DataColumn(label: Text('RegisterNumber')),
// //                   DataColumn(label: Text('Class')),
// //                   DataColumn(label: Text('CreatedBy')),

// //                 ],
// //                 rows: _data
// //                     .map(
// //                       (data) => DataRow(
// //                         cells: <DataCell>[
// //                           // Use an empty string if the value is null
// //                           DataCell(Text(data['name'] ?? '')),
// //                           DataCell(Text(data['email'] ?? '')),
// //                           DataCell(Text(data['registernumber'] ?? '')),
// //                           DataCell(Text(data['class'] ?? '')),
// //                           DataCell(Text(data['createdby'] ?? '')),

// //                         ],
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //             ),
// //           ),
// //   );
// // }
// // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Admin extends StatefulWidget {
//   @override
//   _AdminPage createState() => _AdminPage();
// }

// class _AdminPage extends State<Admin> {
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   AdminScreen _adminScreen = AdminScreen();
//     List<Map<String, dynamic>> _data = [];
//   Future<void> _loadData() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? createdBy = prefs.getString('email');

//     print('CreatedBy: $createdBy');

//     if (createdBy == null) {
//       print('No createdBy value found in SharedPreferences');
//       return;
//     }

//     try {
//       List<Map<String, dynamic>> data = await _adminScreen.fetchData(createdBy);
//       print(data);
//       setState(() {
//         _data = data;
//       });
//     } catch (error) {
//       print('Failed to load data: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _data.isEmpty
//     ? SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             columns: const <DataColumn>[
//               DataColumn(label: Text('Information')),
//             ],
//             rows: [
//               DataRow(
//                 cells: [
//                   DataCell(Text("No Data Found")),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       )
//     : SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: DataTable(
//             columns: const <DataColumn>[
//               DataColumn(label: Text('Name')),
//               DataColumn(label: Text('Email')),
//               DataColumn(label: Text('Register Number')),
//               DataColumn(label: Text('Created Time')),
//               DataColumn(label: Text('Class')),
//             ],
//             rows: _data
//                 .map(
//                   (data) => DataRow(
//                     cells: <DataCell>[
//                       DataCell(Text(data['name'] ?? '')),
//                       DataCell(Text(data['email'] ?? '')),
//                       DataCell(Text(data['registernumber'] ?? '')),
//                       DataCell(Text(data['createdtime'] ?? '')),
//                       DataCell(Text(data['class'] ?? 'N/A')),
//                     ],
//                   ),
//                 )
//                 .toList(),
//           ),
//         ),
//       ),

//     );
//   }
// }

// class AdminScreen {
//  Future<List<Map<String, dynamic>>> fetchData(String createdBy) async {
//     // Replace this URL with your actual API endpoint
//     final response = await http.get(Uri.parse('http://localhost:8000/teacherdata?createdBy=$createdBy'));
//     print(response.body);

//     if (response.statusCode == 200) {
//       final List<dynamic> jsonResponse = json.decode(response.body);
//       return jsonResponse.map((data) => data as Map<String, dynamic>).toList();
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
// }





import 'dart:convert';

import 'package:eduai/Screens/Admin/Function/admin.dart';
import 'package:eduai/Screens/Admin/UI/datanotifier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  @override
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<Admin> {
  final DataNotifier dataNotifier = DataNotifier([]);
  AdminFunction adminFunction =AdminFunction();

  @override
  void initState() {
    super.initState();
    _loadData();
  }
List<dynamic>  _data = [];


  // Future<void> _loadData() async {
  //   await _refreshData();
  // }

    Future<void> _loadData() async {
    // Await the async function and store the result
    List<dynamic> responseData = await adminFunction.refreshData();
    print(responseData);
    setState(() {
      _data=responseData;
    });
              

    // Do something with the responseData, such as updating the UI or a notifier
    // dataNotifier.value = responseData;
  }
  Future<void> _refreshData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? createdBy = prefs.getString('email');

    if (createdBy != null) {
      try {
        final response = await http.get(Uri.parse('http://localhost:8000/teacherdata?createdBy=$createdBy'));

        if (response.statusCode == 200) {
          final List<dynamic> jsonResponse = json.decode(response.body);
          final List<Map<String, dynamic>> data = jsonResponse.map((data) => data as Map<String, dynamic>).toList();

          // Update the ValueNotifier
          dataNotifier.value = data;
        } else {
          throw Exception('Failed to load data');
        }
      } catch (error) {
        print('Failed to refresh data: $error');
      }
    }
  }

  void Deletedata(int id) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? createdBy = prefs.getString('email');

  final uri = Uri.parse('http://localhost:8000/deleteuser');

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'id': id,
      'deletedby': createdBy,
    }),
  );

  if (response.statusCode == 200) {
    print('User deleted successfully');
  } else {
    print('Failed to delete user: ${response.statusCode}');
  }
}

//   @override
Widget build(BuildContext context) {
//   return Scaffold(
//     body:Row(children: [Text("ffff",style: TextStyle(),),     _data.isEmpty
//         ? SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                       columns: const <DataColumn>[
//                         DataColumn(label: Text('Information')),
//                       ],
//                       rows: [
//                         DataRow(
//                           cells: [
//                             DataCell(Text("No Data Found")),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//         : SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: DataTable(
//                 columns: const <DataColumn>[
//                   DataColumn(label: Text('Name')),
//                   DataColumn(label: Text('Email')),
//                   DataColumn(label: Text('RegisterNumber')),
//                   DataColumn(label: Text('Class')),
//                   DataColumn(label: Text('CreatedTime')),
//                   DataColumn(label: Text('Delete')),


//                 ],
//                 rows: _data
//                     .map(
//                       (data) => DataRow(
//                         cells: <DataCell>[
//                           // Use an empty string if the value is null
//                           DataCell(Text(data['name'] ?? '')),
//                           DataCell(Text(data['email'] ?? '')),
//                           DataCell(Text(data['registernumber'] ?? '')),
//                           DataCell(Text(data['class'] ?? '')),
//                           DataCell(Text(data['createdtime'] ?? '')),
//                           DataCell(ElevatedButton(child: Text("Deleted"),onPressed: () =>_loadData() ,)),


//                         ],
//                       ),
//                     )
//                     .toList(),
//               ),
//             ),
//           ),],)
    
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
    //                       DataCell(ElevatedButton(child: Text("Deleted"),onPressed: () =>_loadData() ,)),


    //                     ],
    //                   ),
    //                 )
    //                 .toList(),
    //           ),
    //         ),
    //       ),
  // );
  return Scaffold(
  body: Column(
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

