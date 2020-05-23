import 'package:enactus_thapar/providers/project_provider.dart';
import 'package:enactus_thapar/screens/loader.dart';
import 'package:enactus_thapar/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fireStoreService = FireStoreService();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProjectProvider()),
          StreamProvider(
            create: (context) => fireStoreService.getProjects(),
          ),
        ],
        child: MaterialApp(
          theme:
              ThemeData(accentColor: Colors.black, primaryColor: Colors.black),
          home: Loader(),
        ));
  }
}
