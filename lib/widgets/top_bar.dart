import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        var butotnOptions = taskData.buttonOptions;
        String inputApiToken;
        final tokenTextController = TextEditingController();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                          color: Colors.black, fontSize: 18, height: 1.2),
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
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: taskData.tokenSet == true
                  ? Row(
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
                    )
                  : null,
            )
          ],
        );
      },
    );
  }
}
