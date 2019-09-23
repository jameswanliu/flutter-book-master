import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoDataPage extends StatelessWidget {
  var content = '';

  NoDataPage({this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 120.0),
              child: Icon(
                Icons.cloud_circle,
                size: 150.0,
                color: Colors.black12,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Text(
              content == null ? '暂无该类书籍' : content,
              style: TextStyle(fontSize: 13.0, color: Colors.black26),
            )
          ]),
    );
  }
}
