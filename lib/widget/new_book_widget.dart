import 'package:flutter/material.dart';
import 'package:flutter_book_master/widget/image/LaminatedImage.dart';


///今日新书更新widget
class TodayNewBookWidget extends StatelessWidget {
  final urls;
  final backgroundColor;

  TodayNewBookWidget(this.urls, {Key key, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (urls == null || (urls.isEmpty)) {
      return Container();
    }
    return Stack(
      alignment: AlignmentDirectional(1.0, 1.0),
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: backgroundColor == null
                      ? Color.fromARGB(255, 47, 22, 74)
                      : backgroundColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
            ),
            Container(
              height: 140.0,
              margin: EdgeInsets.only(left: 13.0, bottom: 14.0),
              child: Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      LaminatedImage(urls: urls, w: 90.0),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0, left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '今日新书已更新',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: Text(
                              '查看全部 999+> ',
                              style:
                                  TextStyle(fontSize: 11, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
