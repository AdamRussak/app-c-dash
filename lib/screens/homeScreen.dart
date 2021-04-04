import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/utilities/const.dart';
import 'package:app_center_monitoring/widgets/latest_run.dart';
import 'package:app_center_monitoring/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final tokenTextController = TextEditingController();
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        var butotnOptions = taskData.buttonOptions;

        String inputApiToken;
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Row(
                        children: [
                          IconButton(
                              tooltip: "Set API Token",
                              iconSize: 35.0,
                              color: taskData.tokenSet == true
                                  ? Colors.green[400]
                                  : Colors.red[300],
                              icon: taskData.tokenSet == true
                                  ? Icon(FontAwesomeIcons.lock)
                                  : Icon(FontAwesomeIcons.lockOpen),
                              onPressed: () {
                                taskData.tokenSet == true
                                    ? null
                                    : taskData.setApiToken(inputApiToken);
                                tokenTextController.clear();
                              }),
                          SizedBox(
                            width: 220.0,
                            child: TextField(
                              obscureText: true,
                              autofocus: true,
                              controller: tokenTextController,
                              enabled: taskData.tokenSet == true ? false : true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  height: 1.2),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: taskData.tokenSet == true
                                      ? "Token is set"
                                      : "API Token"),
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.left,
                              onChanged: (newText) {
                                inputApiToken = newText;
                              },
                            ),
                          ),
                          IconButton(
                              tooltip: "Clean API settings",
                              iconSize: 35.0,
                              color: taskData.tokenSet == false ||
                                      taskData.tokenSet == null
                                  ? Colors.grey[100]
                                  : Colors.red[400],
                              icon: Icon(FontAwesomeIcons.trash),
                              onPressed: () {
                                taskData.tokenSet == false
                                    ? null
                                    : taskData.isTokenSet(false);
                              }),
                        ],
                      ),
                    ),
                    Container(
                        height: 60.0,
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Last refresh: ',
                                style: KListTextStyle,
                              ),
                              Text(taskData.formattedDate == null
                                  ? "Waiting..."
                                  : taskData.formattedDate)
                            ])),
                    Container(
                        margin: EdgeInsets.all(5.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Row(
                          children: [
                            Text(
                              'Refresh Rate:',
                              style: KHeaderStyle,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            for (var i in butotnOptions)
                              Container(
                                child: Column(
                                  children: [
                                    Text(i.toString() + "m"),
                                    Radio(
                                        value: i,
                                        groupValue: taskData.buttonSelect,
                                        onChanged: (value) {
                                          taskData.updateRadioButton(value);
                                        }),
                                  ],
                                ),
                              ),
                            SizedBox(
                              width: 5.0,
                            )
                          ],
                        ))
                  ],
                ),
                taskData.latestList.isEmpty == true
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
                    : Flexible(
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
                                          'Total Number of App\`s:',
                                          style: kTopicStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Flexible(
                                    child: Row(children: [
                                      Flexible(
                                        child: LatestRun(),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: 125,
                                          margin: EdgeInsets.all(5.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          child: Center(
                                            child: Text(
                                              taskData.taskCount.toString(),
                                              style: TextStyle(
                                                  fontSize: 45.0,
                                                  fontWeight: FontWeight.bold),
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
                                      "App\`s Last Run",
                                      style: kTopicStyle,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  SizedBox(
                                    child: Container(
                                      height: 625,
                                      child: TasksList(),
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
}
