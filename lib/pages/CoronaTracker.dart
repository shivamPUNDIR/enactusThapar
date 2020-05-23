import 'package:enactus_thapar/models/coronaModel.dart';
import 'package:enactus_thapar/services/coronaService.dart';
import 'package:flutter/material.dart';

class CoronaTracker extends StatefulWidget {
  @override
  _CoronaTrackerState createState() => _CoronaTrackerState();
}

class _CoronaTrackerState extends State<CoronaTracker> {
  final url = "https://covid-193.p.rapidapi.com/statistics?country=india";
  final apiKey = "046c476138mshd53e76af280e60cp16fa5cjsn6cb510e26d37";
  CoronaModel corona = new CoronaModel();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CoronaService(url: url, api_key: apiKey, corona: corona),
    );
  }
}
