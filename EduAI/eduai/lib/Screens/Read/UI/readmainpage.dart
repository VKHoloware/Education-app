import 'package:flutter/material.dart';

import '../../../Comman/UI/Customcard.dart';

class Readmainpage extends StatefulWidget {
  @override
  _ReadmainpageState createState() => _ReadmainpageState();
}

class _ReadmainpageState extends State<Readmainpage> {
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    
    final cardWidth = 250.0; // Fixed card width
    final cardHeight = 250.0; // Fixed card height
    final gapWidth = (screenWidth - 2 * cardWidth) / 4;
    final gapHeight = (screenWidth - 2 * cardWidth) / 12; 
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Main Page'),
      ),
      body: Container(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
                                            SizedBox(width:100),

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
                      child:  Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Vocabulary  Level",
                          data: ["I'll help rewrite it to be clearer and easier to understand."],
                        ),
                      ),
                    ),
                  ),
              
                                            SizedBox(width:gapWidth),

                        Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Words usage Level",
                          data: ["I'll help rewrite it to be clearer and easier to understand."],
                        ),
                      ), 
                      SizedBox(width:gapWidth),
                      
                       Container(
                        height: cardHeight,
                        width: cardWidth,
                        child: CustomCard(
                          height: cardHeight,
                          width: cardWidth,
                          label: "Reading a Passage  Level",
                          data: ["I'll help rewrite it to be clearer and easier to understand."],
                        ),
                      ),
                               ],
          ),
        ),
      ),
    );
  }
}
