import 'dart:io';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final double width;
  final String label; 
  final List<String> data;
  final double elevationvalue = 25;

  CustomCard({
    required this.height,
    required this.width,
    required this.label,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: elevationvalue,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Text(
                    data[index],
                    style: TextStyle(fontSize: 14),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  

}