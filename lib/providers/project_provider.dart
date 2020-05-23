import 'package:enactus_thapar/models/projects.dart';
import 'package:enactus_thapar/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProjectProvider with ChangeNotifier {
  final fireStoreService = FireStoreService();

  String _title;
  String _description;
  String _projectId;
  String _url;
  var uuid = Uuid();

  //getters
  String get title => _title;
  String get description => _description;
  String get url => _url;

  //setters
  changeTitle(String value) {
    _title = value;
    notifyListeners();
  }

  changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  changeURL(String value) {
    _url = value;
    notifyListeners();
  }

  loadValues(Projects project) {
    _title = project.name;
    _description = project.description;
    _url = project.url;
    _projectId = project.projectId;
  }

  saveProject() {
    print(_projectId);

    if (_projectId == null) {
      var newProject = Projects(
          name: title,
          description: description,
          url: url,
          projectId: uuid.v4());
      fireStoreService.saveProject(newProject);
    } else {
      //Update
      var updateProject = Projects(
          name: _title,
          url: _url,
          description: _description,
          projectId: _projectId);
      fireStoreService.saveProject(updateProject);
    }
  }

  removeProject(String projectId) {
    fireStoreService.removeProject(projectId);
  }
}
