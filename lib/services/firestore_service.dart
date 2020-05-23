import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enactus_thapar/models/projects.dart';

class FireStoreService {
  Firestore _db = Firestore.instance;
  Future<void> saveProject(Projects project) {
    return _db
        .collection('projects')
        .document(project.projectId)
        .setData(project.toMap());
  }

  Stream<List<Projects>> getProjects() {
    return _db.collection('projects').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Projects.fromFirestore(document.data))
        .toList());
  }

  Future<void> removeProject(String projectId) {
    return _db.collection('projects').document(projectId).delete();
  }
}
