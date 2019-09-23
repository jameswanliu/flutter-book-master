import 'package:flutter/material.dart';

class CenterTitleWidget extends StatelessWidget {
  final String title;

  CenterTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: Colors.white,fontSize: 16),
    );
  }
}
