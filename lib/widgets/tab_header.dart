import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({
    @required this.tabText,
    @required this.tabIcon,
  });
  final String tabText;
  final tabIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Row(
            children: [
              tabIcon,
              SizedBox(
                width: 10,
              ),
              Text(
                tabText,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
