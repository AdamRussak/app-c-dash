import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/screens/build_screen.dart';
import 'package:app_center_monitoring/screens/release_screen.dart';
import 'package:app_center_monitoring/screens/testing_screen.dart';
import 'package:app_center_monitoring/widgets/tab_header.dart';
import 'package:app_center_monitoring/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return MaterialApp(
        title: "App-c-Dash",
        color: Colors.grey[500],
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[200],
              foregroundColor: Colors.grey[600],
              bottom: TabBar(
                tabs: [
                  Tab(
                    child: TabHeader(
                      tabText: 'Builds',
                      tabIcon: Icon(
                        FontAwesomeIcons.hammer,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Tab(
                    child: TabHeader(
                      tabText: 'Tests',
                      tabIcon: Icon(
                        FontAwesomeIcons.thermometer,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Tab(
                    child: TabHeader(
                      tabText: 'Release',
                      tabIcon: Icon(
                        Icons.delivery_dining,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
              title: TopBar(),
            ),
            body: TabBarView(
              children: [
                BuildScreen(),
                TestScreen(),
                ReleaseScreen(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
