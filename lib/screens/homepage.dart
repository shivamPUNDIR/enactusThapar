import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:enactus_thapar/pages/CoronaTracker.dart';
import 'package:enactus_thapar/pages/OnGoingProjects.dart';
import 'package:enactus_thapar/pages/gallery.dart';
import 'package:enactus_thapar/pages/home.dart';
import 'package:enactus_thapar/pages/volunteer.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentPage = 2;
  final List<Widget> _children = [
    OnGoingProjects(),
    CoronaTracker(),
    Home(),
    Volunteer(),
    Gallery(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 55,
          index: 2,
          animationDuration: Duration(milliseconds: 300),
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.nature_people, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.favorite, size: 30),
            Icon(Icons.account_circle, size: 30),
          ],
          onTap: (index) {
            onTappedBar(index);
          },
        ),
        body: _children[_currentPage]);
  }
}
