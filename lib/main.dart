import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/screens/build_screen.dart';
import 'package:app_center_monitoring/screens/home_screen.dart';
import 'package:app_center_monitoring/screens/release_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

//TODO:find way to filtter project with no repo attached
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.grey[100]),
        initialRoute: HomeScreen.id,
        routes: {
          BuildScreen.id: (context) => BuildScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          ReleaseScreen.id: (context) => ReleaseScreen(),
        },
      ),
    );
  }
}
