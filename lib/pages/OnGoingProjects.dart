import 'package:enactus_thapar/models/projects.dart';
import 'package:enactus_thapar/pages/EditProjects.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnGoingProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projects = Provider.of<List<Projects>>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text("Projects"),
            centerTitle: true,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProjects(),
                  ));
                },
              )
            ]),
        body: (projects != null)
            ? ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: CardBuilder(projects[index].name,
                        projects[index].description, projects[index].url),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProjects(projects[index])));
                    },
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}

Widget CardBuilder(String title, String Subtitle, String url) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: EdgeInsets.all(12),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 23 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.center,
                  image: NetworkImage(url),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            title.toUpperCase(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            Subtitle,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );
}
