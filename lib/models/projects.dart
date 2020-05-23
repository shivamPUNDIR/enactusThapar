class Projects {
  final String projectId;
  final String name;
  final String description;
  final String url;
  Projects({this.projectId, this.description, this.name, this.url});

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'name': name,
      'description': description,
      'url': url
    };
  }

  Projects.fromFirestore(Map<String, dynamic> firestore)
      : projectId = firestore['projectId'],
        name = firestore['name'],
        description = firestore['description'],
        url = firestore['url'];
}
