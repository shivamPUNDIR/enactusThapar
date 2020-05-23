import 'dart:convert';
import 'package:enactus_thapar/covid_pages/countyPage.dart';
import 'package:enactus_thapar/data/datasource.dart';
import 'package:enactus_thapar/panels-COVID/infoList.dart';
import 'package:enactus_thapar/panels-COVID/mostAffectedCountries.dart';
import 'package:enactus_thapar/panels-COVID/statusPanel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoronaTracker extends StatefulWidget {
  @override
  _CoronaTrackerState createState() => _CoronaTrackerState();
}

class _CoronaTrackerState extends State<CoronaTracker> {
  Map worldData;
  fetchWorldWideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
    print('fetchData called');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.lightbulb_outline,
                color: Colors.amber,
              ),
              onPressed: () {})
        ],
        centerTitle: true,
        title: Text(
          'COVID-19 TRACKER',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange[100],
              ),
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Worldwide'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Regional',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            worldData == null
                ? CircularProgressIndicator()
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            SizedBox(
              height: 12,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  'Most affected Countries'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            countryData == null
                ? Container()
                : MostAffectedPanel(
                    countryData: countryData,
                  ),
            SizedBox(
              height: 15,
            ),
            InfoPanel(),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'WE FIGHT THIS TOGETHER',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              ],
            )),
            SizedBox(
              height: 50,
            )
          ],
        )),
      ),
    );
  }
}
