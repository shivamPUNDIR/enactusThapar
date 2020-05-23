import 'package:enactus_thapar/models/projects.dart';
import 'package:enactus_thapar/providers/project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProjects extends StatefulWidget {
  final Projects projects;
  EditProjects([this.projects]);
  @override
  _EditProjectsState createState() => _EditProjectsState(projects);
}

class _EditProjectsState extends State {
  Projects projects;
  _EditProjectsState(this.projects);
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final urlController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    desController.dispose();
    urlController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    if (projects == null) {
      //New Record
      nameController.text = "";
      desController.text = "";
      urlController.text = "";

      new Future.delayed(Duration.zero, () {
        final projectProvider =
            Provider.of<ProjectProvider>(context, listen: false);
        projectProvider.loadValues(Projects());
      });
    } else {
      //Controller Update
      nameController.text = projects.name;
      desController.text = projects.description;
      urlController.text = projects.url;

      //State Update
      new Future.delayed(Duration.zero, () {
        final projectProvider =
            Provider.of<ProjectProvider>(context, listen: false);
        projectProvider.loadValues(projects);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProjectProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('EDIT PROJECT')),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: 'Project Name',
                            labelText: "Project Name :".toUpperCase(),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black)),
                        onChanged: (value) {
                          productProvider.changeTitle(value);
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: desController,
                        decoration: InputDecoration(
                            hintText: 'Project Description',
                            labelText: "Project Description :".toUpperCase(),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black)),
                        onChanged: (value) =>
                            productProvider.changeDescription(value),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: urlController,
                        decoration: InputDecoration(
                            hintText: 'Image Url',
                            labelText: "Image URL :".toUpperCase(),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black)),
                        onChanged: (value) => productProvider.changeURL(value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    productProvider.saveProject();
                    Navigator.of(context).pop();
                  },
                ),
                (projects != null)
                    ? IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          productProvider.removeProject(projects.projectId);
                          Navigator.of(context).pop();
                        },
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
