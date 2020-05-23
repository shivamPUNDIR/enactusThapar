import 'package:flutter/material.dart';

class Volunteer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteer"),
        elevation: 0.0,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Text("Volunteer"),
      ),
    );
  }
}
