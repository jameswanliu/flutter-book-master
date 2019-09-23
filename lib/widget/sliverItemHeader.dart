import 'package:flutter/material.dart';

class SliverItemHeader extends StatelessWidget {
  final String title;

  final Function callBack;

  final Color bgColor;
  double leftSizeBoxSize = 10.0;
  double rightSizeBoxSize = 10.0;

  SliverItemHeader(this.title,
      {this.bgColor,
      this.leftSizeBoxSize,
      this.rightSizeBoxSize,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor != null ? bgColor : Colors.white,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: leftSizeBoxSize,
            ),
            Icon(Icons.bookmark, size: 12.0, color: Colors.redAccent),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                    child: Text(title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)))),
            GestureDetector(
                onTap: callBack,
                child: Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                        child: Text(
                          '更多',
                          textAlign: TextAlign.right,
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black38),
                        )),
                    SizedBox(
                      width: 2.0,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black38,
                      size: 12.0,
                    )
                  ],
                )),
            SizedBox(
              width: rightSizeBoxSize,
            )
          ],
        ));
  }
}
