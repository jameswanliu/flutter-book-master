import 'package:flutter/material.dart';

class BookNormalListPage extends StatefulWidget {
  final String title;

  BookNormalListPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BookNormalListPageState();
  }
}

class BookNormalListPageState extends State<BookNormalListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(widget.title));
  }
}
