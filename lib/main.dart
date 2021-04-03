import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/screens/homeScreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//TODO:clean repo and upload it again
//TODO:set upload script for dockerhub
//TODO: add direct link to apps from the web (pressing the name of the app)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.grey[100]),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => HomeScreen(),
        },
      ),
    );
  }
}
