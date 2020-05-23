import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              child: Text(
                "About Us",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
