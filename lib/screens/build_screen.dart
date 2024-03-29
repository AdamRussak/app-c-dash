import 'package:after_layout/after_layout.dart';
import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/utilities/const.dart';
import 'package:app_center_monitoring/widgets/latest_run.dart';
import 'package:app_center_monitoring/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class BuildScreen extends StatefulWidget {
  static const String id = 'build_screen';

  @override
  _BuildScreenState createState() => _BuildScreenState();
}

class _BuildScreenState extends State<BuildScreen>
    with AfterLayoutMixin<BuildScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return Scaffold(
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
              : Padding(
                  padding: KpaddingApp,
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0))),
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: 500,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Text(
                                          "Latest Build",
                                          style: kTopicStyle,
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: 500,
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        child: Text(
                                          'Total Number of Apps:',
                                          style: kTopicStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 10.0,
                                  // ),
                                  Flexible(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: LatestRun('build'),
                                          ),
                                          Flexible(
                                            child: Container(
                                              height: 150,
                                              margin: EdgeInsets.all(2.5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[400],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              child: Center(
                                                child: Text(
                                                  taskData.buildAppCount
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 45.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 25,
                                    width: 500,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: Text(
                                      "Apps Last Run",
                                      style: kTopicStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  SizedBox(
                                    child: Container(
                                      height: 600,
                                      child: TasksList(
                                        screenList: taskData.appList,
                                        totalCount: taskData.buildAppCount,
                                        screen: "build",
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).appCenterApps();
    Provider.of<TaskData>(context, listen: false).setPage('build');
  }
}
