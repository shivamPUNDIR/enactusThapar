import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:enactus_thapar/models/coronaModel.dart';
import 'package:http/http.dart' as http;

class CoronaService extends StatefulWidget {
  @override
  _CoronaServiceState createState() => _CoronaServiceState();
  CoronaModel corona = new CoronaModel();
  final String url;
  final String api_key;
  CoronaService({this.api_key, this.url, this.corona});
}

class _CoronaServiceState extends State<CoronaService> {
  Future<CoronaModel> getData() async {
    await http.get(widget.url,
        headers: {"x-rapidapi-key": widget.api_key}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["response"].forEach((element) {
        print(element);
        widget.corona = CoronaModel.fromMap(element);
        print(widget.corona.cases.active);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Corona Tracker"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
