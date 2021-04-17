import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/screens/build_screen.dart';
import 'package:app_center_monitoring/screens/release_screen.dart';
import 'package:app_center_monitoring/screens/testing_screen.dart';
import 'package:app_center_monitoring/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  //TODO: create buttons for Testing
//TODO: create Page for Testing
//TODO: create buttons for Builds
//TODO: create buttons for Distrabute
//TODO: create Page for Distrabute
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return MaterialApp(
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
                      icon: Icon(
                    FontAwesomeIcons.thermometerQuarter,
                    color: Colors.grey[600],
                  )),
                  Tab(
                      icon: Icon(
                    Icons.delivery_dining,
                    color: Colors.grey[600],
                  )),
                  Tab(
                      icon: Icon(
                    FontAwesomeIcons.hammer,
                    color: Colors.grey[600],
                  )),
                ],
              ),
              title: TopBar(),
            ),
            body: taskData.latestList.isEmpty == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitDoubleBounce(
                        color: taskData.tokenSet == true
                            ? Colors.green[200]
                            : Colors.grey[600],
                        size: 300.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      taskData.tokenSet == true
                          ? Text(
                              "Loading...",
                              style: TextStyle(
                                  color: Colors.green[200], fontSize: 35.0),
                            )
                          : Text("Waiting for API token...",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 35.0)),
                    ],
                  )
                : TabBarView(
                    children: [
                      TestScreen(),
                      ReleaseScreen(),
                      BuildScreen(),
                    ],
                  ),
          ),
        ),
      );
    });
  }
}
