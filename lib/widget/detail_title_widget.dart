import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_detail_page.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/utils/TimeUtil.dart';

import 'look_confirm_button.dart';

class DetailTitleWidget extends StatelessWidget {
  final BookDetail bean;
  final Color shadowColor;

  DetailTitleWidget(this.bean, this.shadowColor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenW = MediaQuery.of(context).size.width;
    var imgW = screenW / 4;
    var imgH = imgW * 421 / 297;
    var pubdates = bean.updated;
    var wordCount = bean.wordCount;
    //将按下的颜色设置较为浅色
    var btnPressedColor =
        Color.fromARGB(100, shadowColor.red, shadowColor.red, shadowColor.red);
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Card(
            //影音海报
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            color: shadowColor,
            clipBehavior: Clip.antiAlias,
            elevation: 10.0,
            child: Image.network(
              Constant.IMG_BASE_URL + bean.cover,
              width: imgW,
              height: imgH,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: Constant.MARGIN_LEFT),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 15.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        bean.author,
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      '更新时间：${TimeUtil.timerFormat(pubdates)}\n${bean.minorCate}\n总字数：$wordCount',
                      style: TextStyle(fontSize: 12.0, color: Colors.white70),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: LookConfirmButton(
                          btnText: '加入书架',
                          iconAsset: 'assets/images/ic_info_wish.png',
                          defaultColor: Colors.white,
                          pressedColor: btnPressedColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                      ),
                      Expanded(
                        child: LookConfirmButton(
                          btnText: '开始阅读',
                          iconAsset: 'assets/images/ic_info_done.png',
                          defaultColor: Colors.white,
                          pressedColor: btnPressedColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
