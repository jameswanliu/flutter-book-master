import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_detail_page.dart';
import 'package:flutter_book_master/bean/book_hot_review.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/widget/bottom_drag_widget.dart';
import 'package:flutter_book_master/widget/center_title_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_book_master/widget/detail_title_widget.dart';
import 'package:flutter_book_master/widget/loading_widget.dart';
import 'package:flutter_book_master/widget/rating_bar.dart';
import 'package:flutter_book_master/widget/score_start.dart';
import 'long_comment_widget.dart';

///书籍详情
class BookDetailPage extends StatefulWidget {
  final String title;

  BookDetailPage(this.id, this.title);

  ///书籍id
  final String id;

  @override
  State<StatefulWidget> createState() => BookDetailPageState();
}

class BookDetailPageState extends State<BookDetailPage> {
  bool isLoading = true;
  var pickColor = Color.fromARGB(255, 47, 22, 74);
  BookDetail _bookDetail;

  double get screenH => MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _getBookDetail();
  }

  ///获取书籍详情
  _getBookDetail() {
    BookApiRepository.getInstance().getBookDetail(widget.id).then((data) {
      setState(() {
        isLoading = false;
        _bookDetail = data;
      });
    });
  }

  padding() {
    return EdgeInsets.only(
        left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT);
  }

  Widget _getBody() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
//        SliverAppBar(
//          title: Text(widget.title),
//          centerTitle: true,
//          pinned: true,
//        ),
        SliverToBoxAdapter(
          child: DetailTitleWidget(_bookDetail, Colors.transparent),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
            margin: padding(),
            child: ScoreStartWidget(
              score:
                  _bookDetail.rating == null || _bookDetail.rating.score == null
                      ? 8.9
                      : _bookDetail.rating.score,
              p1: 0.01,
              p2: 0.02,
              p3: 0.05,
              p4: 0.32,
              p5: 0.58,
            ),
          ),
        ),
        sliverTags(),
        sliverSummary(),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 25.0),
          ),
        ),
      ],
    );
  }

  ///书籍简介
  SliverToBoxAdapter sliverSummary() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
              child: Text(
                '书籍简介',
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              _bookDetail.longIntro,
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0x44000000),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        padding: EdgeInsets.all(12.0),
        margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
      ),
    );
  }

  ///所属分类
  SliverToBoxAdapter sliverTags() {
    return SliverToBoxAdapter(
      child: Container(
        height: 30.0,
        padding: padding(),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _bookDetail.tags.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text(
                      '所属分类',
                      style: TextStyle(color: Colors.white, fontSize: 13.0),
                    ),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                      color: Color(0x23000000),
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  child: Text(
                    '${_bookDetail.tags[index - 1]}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: LoadingPage())
        : Scaffold(
            body: Container(
              child: SafeArea(
                  child: BottomDragWidget(
                      bgUrl: Constant.IMG_BASE_URL + _bookDetail.cover,
                      body: _getBody(),
                      dragContainer: DragContainer(
                          drawer: Container(
                            child: OverscrollNotificationWidget(
                              child: LongCommentTabView(widget.id),
                            ),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 243, 244, 248),
                                borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(10.0),
                                    topRight: const Radius.circular(10.0))),
                          ),
                          defaultShowHeight: screenH * 0.1,
                          height: screenH * 0.8))),
            ),
          );
  }
}
