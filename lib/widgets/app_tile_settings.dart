import 'package:flutter/material.dart';

class AppTileSettings extends StatelessWidget {
  const AppTileSettings({
    @required this.tileInput,
    @required this.rowDeiscriiption,
  });

  final Widget tileInput;
  final Widget rowDeiscriiption;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          rowDeiscriiption,
          SizedBox(
            width: 5.0,
          ),
          tileInput,
        ],
      ),
    );
  }
}
