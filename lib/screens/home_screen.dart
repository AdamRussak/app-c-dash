import 'package:app_center_monitoring/models/task_data.dart';
import 'package:app_center_monitoring/utilities/const.dart';
import 'package:app_center_monitoring/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      return Scaffold(
        body: Padding(
          padding: KpaddingApp,
          child: Column(
            children: [
              TopBar(),
            ],
          ),
        ),
      );
    });
  }
}
