import 'package:flutter/material.dart';

class SegmentControllerDetailPage extends StatefulWidget {
  final String title;

  SegmentControllerDetailPage({this.title});

  @override
  State<StatefulWidget> createState() => SegmentControllerDetailPageState();
}

class SegmentControllerDetailPageState
    extends State<SegmentControllerDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.title),
    );
  }
}
