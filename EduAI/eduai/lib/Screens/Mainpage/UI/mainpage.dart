
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// import '../Comman/Function/powershellfunction.dart';
// import '../Comman/UI/carddesign.dart';

// class Trackinginfo extends StatefulWidget {
//   @override
//   _Trackinginfo createState() => _Trackinginfo();
// }

// class _Trackinginfo extends State<Trackinginfo> {
//   List<String> processor_info = [];
//   List<String> systemdriver_info = ["jf"];
//   List<String> diskDrive_info = [];
//   List<String> computer_info = [];
//   List<String> osData_info = [];
//   List<String> biosData_info = [];
//   List<String> baseboardData_info = [];
//   List<String> physicalMemory_info = [];
//   List<String> devicememoryaddress_info = [];
//   List<String> dmaChannel_info = [];
//   List<String> irqResource_info = [];
//   List<String> diskpartition_info = [];
//   List<String> printer_info = [];
//   // List<String> dmaChannel_info = [];
//   // List<String> dmaChannel_info = [];
//   // List<String> dmaChannel_info = [];



//   bool _isShowmore = false;
//   bool _isHovered = false;
//   bool loader = false;

//   Powershellfunction powershellcommand = Powershellfunction();

//   @override
//   void initState() {
//     super.initState();
//     cardDatas();
//   }

//   void cardDatas() async {
//     var processorinfo = await powershellcommand.runPowerShellCommand('Get-Wmiobject -ClassName Win32_Processor');
//     List<String> outputdata = processorinfo.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//      var systemdriver = await powershellcommand.runPowerShellCommand('Get-Wmiobject -ClassName Win32_SystemDriver');
//     List<String> systemdriveroutputdata = systemdriver.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var computerInfodata = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_ComputerSystem');
//     List<String> computerInfoOutputdata = computerInfodata.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//      var diskDrivedata = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_DiskDrive');
//     List<String> diskDriveoutputdata = diskDrivedata.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var osData = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_OperatingSystem');
//     List<String> osDataoutputdata = osData.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

    
//     var biosData = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_BIOS ');
//     List<String> biosDataoutputdata = biosData.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var baseboardData = await powershellcommand.runPowerShellCommand(' Get-WmiObject -ClassName Win32_BaseBoard ');
//     List<String> baseboardoutputdata = baseboardData.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var physicalMemory = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_PhysicalMemory ');
//     List<String> physicalMemoryoutputdata = physicalMemory.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var devicememoryaddress = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_DeviceMemoryAddress');
//     List<String> devicememoryaddressoutputdata = devicememoryaddress.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var dmaChannel = await powershellcommand.runPowerShellCommand(' Get-WmiObject -ClassName Win32_DMAChannel');
//     List<String> dmaChanneloutputdata = dmaChannel.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var irqResource = await powershellcommand.runPowerShellCommand(' Get-WmiObject -ClassName Win32_IRQResource');
//     List<String> irqResourceoutputdata = irqResource.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var diskpartition = await powershellcommand.runPowerShellCommand(' Get-WmiObject -ClassName Win32_DiskPartition ');
//     List<String>diskpartitionoutputdata = diskpartition.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     var printer = await powershellcommand.runPowerShellCommand('Get-WmiObject -ClassName Win32_Printer');
//     List<String>printeroutputdata = printer.split('\n').map((line) => line.trim()).where((line) => line.isNotEmpty).toList();

//     setState(() {
//       processor_info = outputdata;
//       systemdriver_info = systemdriveroutputdata;
//       diskDrive_info = diskDriveoutputdata;
//       computer_info = computerInfoOutputdata;
//       osData_info=osDataoutputdata;
//       biosData_info=biosDataoutputdata;
//       baseboardData_info=baseboardoutputdata;
//       physicalMemory_info=physicalMemoryoutputdata;
//       devicememoryaddress_info=devicememoryaddressoutputdata;
//       dmaChannel_info=dmaChanneloutputdata;
//       irqResource_info=irqResourceoutputdata;
//       diskpartition_info=diskpartitionoutputdata;
//       printer_info=printeroutputdata;

//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final gapWidth = screenWidth * 0.04;
//     final cardWidth = (screenWidth - 3 * gapWidth) / 3;
//     final cardHeight = 300.0;
//     final singlecardWidth = (screenWidth - 3 * gapWidth) / 1.8;
//     final gapHeight=20.0;



//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Processor Info", data: processor_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Disk Drive Info", data: diskDrive_info, height: cardHeight,),
//               ],
//             ),
//             SizedBox(height: gapHeight,),
//             Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Computer Info", data: computer_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "OS Info", data: osData_info, height: cardHeight,),
//               ],
//             ),
//                         SizedBox(height: gapHeight,),

//             Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Bios Data Info", data: biosData_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "BaseBoard Info", data: baseboardData_info, height: cardHeight,),
//               ],
//             ),
//                         SizedBox(height: gapHeight,),
//                           Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "IRQ Resources Info", data: irqResource_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Printer Info", data: printer_info, height: cardHeight,),
//               ],
//             ),
//                         SizedBox(height: gapHeight,),
//                           Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Disk Partition Info", data: diskpartition_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Disk Drive Info", data: baseboardData_info, height: cardHeight,),
//               ],
//             ),
//                         SizedBox(height: gapHeight,),
//                           Row(
//               children: [
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Processor Info", data: biosData_info, height: cardHeight,),
//                 SizedBox(width: gapWidth),
//                 CustomCard(width: cardWidth, label: "Disk Drive Info", data: baseboardData_info, height: cardHeight,),
//               ],
//             ),
//                         SizedBox(height: gapHeight,),

//              ElevatedButton(
//           onPressed: () {
//             setState(() {
//               _isShowmore = !_isShowmore;
//             });
//           },
//    child: Text(_isShowmore ? "Show Less" : "Show More"),

//         ),
//       // );
//             if (_isShowmore)
//               Row(
//                 children: [
//                   SizedBox(width: gapWidth),
//                   CustomCard(width: singlecardWidth, label: "System Driver_info", data: systemdriver_info, height: cardHeight,),
//                   // SizedBox(width: gapWidth),
//                   // CustomCard(width: cardWidth, label: "Disk Drive Info", data: diskDrive_info),
//                 ],
//               ),
//                           if (_isShowmore)

//               Row(children: [        SizedBox(width: gapWidth),     
//                 CustomCard(width: singlecardWidth, label: "Physical Meomery Info", data: physicalMemory_info, height: cardHeight,),
//                   ],),
//                    if (_isShowmore)

//               Row(children: [        SizedBox(width: gapWidth),     
//                 CustomCard(width: singlecardWidth,  label: "IRQ Resources Info", data: irqResource_info, height: cardHeight,),
//                   ],),
//             if (loader)
//               Center(
//                 child: LoadingAnimationWidget.twistingDots(
//                   leftDotColor: const Color.fromRGBO(14, 119, 190, 1),
//                   rightDotColor: Color.fromRGBO(240, 240, 245, 1),
//                   size: 50,
//                 ),
//               ),
//             SizedBox(height: 50, width: 20.0),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInfoContainer(String title, String content) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//       child: Card(
//         elevation: 3.0,
//         child: MouseRegion(
//           onEnter: (event) {
//             setState(() {
//               _isHovered = true;
//             });
//           },
//           onExit: (event) {
//             setState(() {
//               _isHovered = false;
//             });
//           },
//           child: AnimatedContainer(
//             duration: Duration(milliseconds: 200),
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: AnimatedContainer(
//               duration: Duration(milliseconds: 200),
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.blue, width: 1.5),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     content,
//                     style: TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:eduai/Comman/UI/Customcard.dart';
import 'package:eduai/Screens/LoginRegister/UI/login.dart';
import 'package:eduai/Screens/Read/UI/readmainpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    final cardWidth = 250.0; // Fixed card width
    final cardHeight = 250.0; // Fixed card height
    final gapWidth = (screenWidth - 2 * cardWidth) / 7;
    final gapHeight = (screenWidth - 2 * cardWidth) / 12; 

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: AppBar(
            title: Row(
              children: [
                Text("Main Page"),
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
      body: Container(
        // Set the gradient background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Color.fromARGB(190, 72, 76, 193)], // Replace with your desired colors
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: gapHeight), // Space between rows

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: gapWidth),
                  // First Card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Readmainpage(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Read Level",
                          data: ['I can assist you in simplifying it for better readability.'],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: gapWidth),
                  // Second Card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WriteLevelPage(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Writing Level",
                          data: ["I'll help rewrite it to be clearer and easier to understand."],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: gapWidth), // Space between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: gapWidth),
                  // Third Card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListeningLevelPage(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Listening Level",
                          data: ["I'll help listen to it to be clearer and easier to understand."],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: gapWidth),
                  // Fourth Card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpeakingInfoPage(),
                        ),
                      );
                    },
                    child: Opacity(
                      opacity: 0.8, // Adjust opacity as needed
                      child: Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Speaking Info",
                          data: ["I'll help speak it to be clearer and easier to understand."],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class ReadLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Level'),
      ),
      body: Center(
        child: Text('This is the Read Level page'),
      ),
    );
  }
}

class WriteLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write Level'),
      ),
      body: Center(
        child: Text('This is the Write Level page'),
      ),
    );
  }
}

class ListeningLevelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listening Level'),
      ),
      body: Center(
        child: Text('This is the Listening Level page'),
      ),
    );
  }
}

class SpeakingInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speaking Info'),
      ),
      body: Center(
        child: Text('This is the Speaking Info page'),
      ),
    );
  }
}
